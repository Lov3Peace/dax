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

export async function sendConnectionRequest(req, res) {
	try {

		const senderUsername = req.user.username;
		const { receiverUsername } = req.body;

		// Get Socket.IO instance from server.js
		const io = req.app.get("io");

		// Insert connection request into postgres
		const result = await db.query(
			`
      INSERT INTO connections
        (sender_username, receiver_username, status)
      VALUES
        ($1, $2, 0)
      RETURNING *
      `,
			[senderUsername, receiverUsername]
		);

		const connection = result.rows[0];

		// Notify receiver in real time
		io
			.to(`user:${receiverUsername}`)
			.emit("connection_request_received", {
				connectionId: connection.id,
				senderUsername,
				status: "pending"
			});

		return res.status(201).json(connection);

	} catch (error) {

		console.error(error);

		return res.status(500).json({
			message: "Could not send connection request"
		});
	}
};
//
// Accepting Connection Request
export async function acceptConnection(req, res) {
	try {
		const username = req.user.username;
		const connectionId = req.params.id;

		// Get Socket.IO instance from server.js
		const io = req.app.get("io");

		// Insert connection request into postgres
		const result = await db.query(
			`
      UPDATE connections
      SET
        status = 1
      WHERE request_id = $1
        AND receiver_username = $2
      RETURNING *
      `,
			[connectionId, username]
		);

		const connection = result.rows[0];

		if (!connection) {
			return res.status(404).json({
				message: "Connection request not found"
			});
		}
		// Tell original sender.
		io
			.to(`user:${connection.sender_username}`)
			.emit("connection_request_accepted", connection);
		// Tell person who accepted it too.
		io
			.to(`user:${connection.receiver_username}`)
			.emit("connection_updated", connection);

		return res.json(connection);

	} catch (error) {

		console.error(error);

		return res.status(500).json({
			message: "Could not accept request"
		});
	}
}
//
// Rejecting Connection Request
export async function rejectConnection(req, res) {
	try {
		const username = req.user.username;
		const connectionId = req.params.id;

		// Get Socket.IO instance from server.js
		const io = req.app.get("io");

		// Insert connection request into Postgres
		const result = await db.query(
			`
			DELETE FROM connections
			WHERE request_id = $1
				AND receiver_username = $2
			RETURNING *
			`,
			[connectionId, username]
		);

		const connection = result.rows[0];

		if (!connection) {
			return res.status(404).json({
				message: "Connection request not found"
			});
		}

		io
			.to(`user:${connection.sender_username}`)
			.emit("connectionRequestRejected", connection);

		io
			.to(`user:${connection.receiver_username}`)
			.emit("connectionRequestRejected", connection);

		return res.json(connection);

	} catch (error) {
		console.error(error);

		return res.status(500).json({
			message: "Could not reject request"
		});
	}
}

