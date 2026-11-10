import authCheck from "../auth/authCheck.js";
import { pgClient, io } from "../server.js";
import user from "../storage/models/user.js";
import User from "../storage/models/user.js";

export const getUsers = async (req, res) => {
  console.log("Get Users Hit");
  const param = req.query.searchString;
  // Only search for users that have characters starting with the query string
  const regex = new RegExp("^" + param, "i");
  let users;
  if (param) {
    // Only return the username and online status in the response, not the whole user object
    users = await User.find({ username: { $regex: regex } }, [
      "username",
      "online",
    ]).limit(25);
    // console.log("Get Users Results: ", users);
    return res.status(200).json(users);
  } else {
    return res.status(400).json("Search cannot be empty!");
  }
  // console.log(`Users: ${users}`);
};

export const getUserDashboardData = async (req, res) => {
  console.log("trying to fetch user data...");
  const username = req.cookies.username;

  if (username) {
    const user = await User.findOne({ username });

    return res.status(200).json({
      username: user.username,
    });
  }
  return res.status(404).json("User not found");
};

export const getLocation = async (req, res) => {
  try {
    let ip = req.ip;
    // for local testing
    if (ip === "::1" || ip === "127.0.0.1") {
      ip = "8.8.8.8"; // test only
    }
    console.log("IP: ", ip);
    if (!ip) {
      return res.status(404).json("Sorry, no location data available");
    }
    // Fetch location details from ipApi
    let locationRes = await fetch(
      "https://api.ipapi.com/api/check?access_key=5b20163bd553535fc71b6addd2ab130c",
    );

    locationRes = await locationRes.json();

    return res.status(200).json({
      latitude: locationRes.latitude,
      longitude: locationRes.longitude,
    });
  } catch (e) {
    return res.status(500).json("Error: ", e);
  }
};

// Join Room for User by username
export const joinUserRoom = (socket) => {
  socket.on("joinUserRoom", (username) => {
    socket.data.username = username;

    socket.join(`user: ${username}`);
    socket.broadcast.emit("userPresenceChanged", {
      username,
      online: true,
    });
    console.log(
      `Socket ${socket.id} joined room 'user: ${username}' successfully`,
    );

    socket.emit("userRoomJoined");
  });

  socket.on("disconnect", async () => {
    const username = socket.data.username;

    if (!username) return;

    // Check whether the user has other active connections
    const sockets = await io.in(`user:${username}`).fetchSockets();

    if (sockets.length > 0) return;

    console.log(`${username} went offline at ${new Date().toISOString()}`);

    const result = await User.updateOne(
      { username },
      {
        $set: {
          online: false,
          lastSeen: new Date(),
        },
      },
    );
    socket.broadcast.emit("userPresenceChanged", {
      username,
      online: false,
      lastSeen: new Date().toISOString(),
    });
    // Next: Save this timestamp to MongoDB
  });
};

// Send Connection Request
export const sendConnectionRequest = (socket) => {
  socket.on("sendConnectionRequest", async (data) => {
    try {
      const senderUsername = data.sender;
      const receiverUsernames = data.receivers;

      for (const user of receiverUsernames) {
        // Check for an existing connection in either direction
        const existingConnection = await pgClient.query(
          `
          SELECT status FROM users.connection_requests
          WHERE
            (sender_username = $1 AND receiver_username = $2)
            OR
            (sender_username = $2 AND receiver_username = $1)
          LIMIT 1
          `,
          [senderUsername, user],
        );

        if (existingConnection.rows.length > 0) {
          socket.emit("connectionRequestError", {
            message:
              existingConnection.rows[0].status === 1
                ? `You are already connected with ${user}`
                : `A connection request with ${user} is already pending`,
          });

          continue;
        }

        // Prevent sending a request to yourself
        if (senderUsername === user) {
          socket.emit("connectionRequestError", {
            message: "You cannot send a connection request to yourself",
          });

          continue;
        }

        // Create connection request
        const result = await pgClient.query(
          `
          INSERT INTO users.connection_requests
            (sender_username, receiver_username, status)
          VALUES
            ($1, $2, 0)
          RETURNING *
          `,
          [senderUsername, user],
        );

        const connection = result.rows[0];

        // Notify recipient
        io.to(`user: ${user}`).emit("connectionRequestReceived", connection);

        // Confirm successful request to sender
        io.to(`user: ${senderUsername}`).emit(
          "connectionRequestSent",
          connection,
        );
      }
    } catch (error) {
      console.error(error);

      socket.emit("connectionRequestError", {
        message: "Could not send connection request",
      });
    }
  });
};

// Get Pending Connection Requests
export const getConnectionRequest = (socket) => {
  socket.on("getConnectionRequests", async (username) => {
    try {
      const result = await pgClient.query(
        `
        SELECT *
        FROM users.connection_requests
        WHERE receiver_username = $1
          AND status = 0
        ORDER BY timestamp DESC
        `,
        [username],
      );

      socket.emit("currentConnectionRequests", result.rows);
    } catch (error) {
      console.error(error);

      socket.emit("connectionRequestError", {
        message: "Could not load connection requests",
      });
    }
  });
};

// Accept Connection Request
export const acceptConnectionRequest = (socket) => {
  socket.on("acceptConnection", async (data) => {
    try {
      const { requestId, username } = data;

      const result = await pgClient.query(
        `
        UPDATE users.connection_requests
        SET status = 1
        WHERE request_id = $1
          AND receiver_username = $2
        RETURNING *
        `,
        [requestId, username],
      );

      const connection = result.rows[0];

      if (!connection) {
        return socket.emit("connectionRequestError", {
          message: "Connection request not found",
        });
      }

      io.to(`user: ${connection.sender_username}`).emit(
        "connectionRequestAccepted",
        connection,
      );

      io.to(`user: ${connection.receiver_username}`).emit(
        "connectionRequestAccepted",
        connection,
      );
    } catch (error) {
      console.error(error);

      socket.emit("connectionRequestError", {
        message: "Could not accept request",
      });
    }
  });
};

// Reject Connection Request
export const rejectConnectionRequest = (socket) => {
  socket.on("rejectConnection", async (data) => {
    try {
      const { requestId, username } = data;
      const result = await pgClient.query(
        `
        DELETE FROM users.connection_requests
        WHERE request_id = $1
          AND receiver_username = $2
        AND status = 0
        RETURNING *
        `,
        [requestId, username],
      );
      const connection = result.rows[0];

      if (!connection) {
        return socket.emit("connectionRequestError", {
          message: "Connection request not found",
        });
      }

      io.to(`user: ${connection.sender_username}`).emit(
        "connectionRequestRejected",
        connection,
      );

      io.to(`user: ${connection.receiver_username}`).emit(
        "connectionRequestRejected",
        connection,
      );
    } catch (error) {
      console.error(error);

      socket.emit("connectionRequestError", {
        message: "Could not reject request",
      });
    }
  });
};
// Get Accepted Connections
export const getConnections = (socket) => {
  socket.on("getConnections", async (username) => {
    try {
      const result = await pgClient.query(
        `
        SELECT *
        FROM users.connection_requests
        WHERE status = 1
          AND (
            sender_username = $1
            OR receiver_username = $1
          )
        ORDER BY timestamp DESC
        `,
        [username],
      );

      // Get the other user's username for each connection
      const connections = await Promise.all(
        result.rows.map(async (connection) => {
          const friendUsername =
            connection.sender_username === username
              ? connection.receiver_username
              : connection.sender_username;

          const user = await User.findOne({
            username: friendUsername,
          }).select("online lastSeen");

          return {
            ...connection,
            online: user?.online ?? false,
            lastSeen: user?.lastSeen ?? null,
          };
        }),
      );

      socket.emit("connections", connections);
    } catch (error) {
      console.error(error);

      socket.emit("connectionRequestError", {
        message: "Could not load connections",
      });
    }
  });
};
// Remove a accepted connection
export const removeConnection = (socket) => {
  socket.on("removeConnection", async (data) => {
    try {
      const { requestId } = data;
      const username = socket.data.username;
      if (!username) {
        return socket.emit("connectionRemovalError", {
          message: "User not authenticated",
        });
      }

      const result = await pgClient.query(
        `
        DELETE FROM users.connection_requests
        WHERE request_id = $1
          AND status = 1
          AND (
            sender_username = $2
            OR receiver_username = $2
          )
        RETURNING *
        `,
        [requestId, username],
      );

      const connection = result.rows[0];

      if (!connection) {
        return socket.emit("connectionRemovalError", {
          message: "Connection not found or unauthorized",
        });
      }
      io.to(`user: ${connection.sender_username}`).emit("connectionRemoved", {
        requestId: String(connection.request_id),
      });

      io.to(`user: ${connection.receiver_username}`).emit("connectionRemoved", {
        requestId: String(connection.request_id),
      });
      socket.emit("connectionRemoved", {
        requestId: String(connection.request_id),
      });
      socket.emit("refreshConnections");
    } catch (error) {
      console.error("REMOVE CONNECTION ERROR:", error);

      socket.emit("connectionRemovalError", {
        message: "Could not remove connection",
      });
    }
  });
};
