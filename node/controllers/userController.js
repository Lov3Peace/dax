import authCheck from "../auth/authCheck.js";
import user from "../storage/models/user.js";
import User from "../storage/models/user.js";

export const getUsers = async (req, res) => {
	console.log("Get Users Hit");
	const param = req.query.searchString;
	// Only search for users that have characters starting with the query string
	const regex = new RegExp("^" + param, "i");
	let users;
	if (param) {
		// Only return the username in the response, not the whole user object
		users = await User.find({ username: { $regex: regex } }, "username").limit(
			25,
		);
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
		socket.join(`user:${username}`);

		console.log(
			`Socket ${socket.id} joined user:${username} successfully`
		);

		socket.emit("userRoomJoined");
	});
};

// Send Connection Request
export const sendConnectionRequest = (socket, io) => {
	socket.on("sendConnectionRequest", async (data) => {
		try {
			const { senderUsername, receiverUsername } = data;

			const result = await db.query(
				`
        INSERT INTO users.connection_requests
          (sender_username, receiver_username, status)
        VALUES
          ($1, $2, 0)
        RETURNING *
        `,
				[senderUsername, receiverUsername]
			);

			const connection = result.rows[0];

			io.to(`user:${receiverUsername}`)
				.emit("connectionRequestReceived", connection);

		} catch (error) {
			console.error(error);

			socket.emit("connectionRequestError", {
				message: "Could not send connection request"
			});
		}
	});
};

// Get Pending Connection Requests
export const getConnectionRequest = (socket) => {
	socket.on("getConnectionRequests", async (username) => {
		try {
			const result = await db.query(
				`
        SELECT *
        FROM users.connection_requests
        WHERE receiver_username = $1
          AND status = 0
        ORDER BY timestamp DESC
        `,
				[username]
			);

			socket.emit(
				"connectionRequestsResponse",
				result.rows
			);

		} catch (error) {
			console.error(error);

			socket.emit(
				"connectionRequestError",
				{
					message: "Could not load connection requests"
				}
			);
		}
	});
};

// Accept Connection Request
export const acceptConnectionRequest = (socket, io) => {
	socket.on("acceptConnection", async (data) => {
		try {
			const { requestId, username } = data;

			const result = await db.query(
				`
        UPDATE users.connection_requests
        SET status = 1
        WHERE request_id = $1
          AND receiver_username = $2
        RETURNING *
        `,
				[requestId, username]
			);

			const connection = result.rows[0];

			if (!connection) {
				return socket.emit("connectionRequestError", {
					message: "Connection request not found"
				});
			}

			io.to(`user:${connection.sender_username}`)
				.emit("connectionRequestAccepted", connection);

			io.to(`user:${connection.receiver_username}`)
				.emit("connectionRequestAccepted", connection);

		} catch (error) {
			console.error(error);

			socket.emit("connectionRequestError", {
				message: "Could not accept request"
			});
		}
	});
};

// Reject Connection Request
export const rejectConnectionRequest = (socket, io) => {
	socket.on("rejectConnection", async (data) => {
		try {
			const { requestId, username } = data;

			const result = await db.query(
				`
        DELETE FROM users.connection_requests
        WHERE request_id = $1
          AND receiver_username = $2
        RETURNING *
        `,
				[requestId, username]
			);

			const connection = result.rows[0];

			if (!connection) {
				return socket.emit("connectionRequestError", {
					message: "Connection request not found"
				});
			}

			io.to(`user:${connection.sender_username}`)
				.emit("connectionRequestRejected", connection);

			io.to(`user:${connection.receiver_username}`)
				.emit("connectionRequestRejected", connection);

		} catch (error) {
			console.error(error);

			socket.emit("connectionRequestError", {
				message: "Could not reject request"
			});
		}
	});
};
// Get Accepted Connections
export const getConnections = (socket) => {
	socket.on("getConnections", async (username) => {
		try {
			const result = await db.query(
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
				[username]
			);

			socket.emit(
				"connectionsResponse",
				result.rows
			);

		} catch (error) {
			console.error(error);

			socket.emit(
				"connectionRequestError",
				{
					message: "Could not load connections"
				}
			);
		}
	});
};
