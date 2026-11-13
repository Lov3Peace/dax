import mongoose from "mongoose";
import app from "./app.js";
import dotenv from "dotenv";
import { Pool } from "pg";
import {
  createProjectFeedPost,
  getProjectFeed,
  joinProjectRoom,
  updateProjectCategoriesCollection,
} from "./controllers/projectsController.js";
import { updateProfileCrestsCollection } from "./controllers/profileController.js";
import jwt from "jsonwebtoken";
import { pubKey } from "./auth/keygen.js";
import { Server } from "socket.io";
import { createServer } from "node:http";
import {
  joinUserRoom,
  sendConnectionRequest,
  getConnectionRequest,
  getConnections,
  getUserProfile,
  acceptConnectionRequest,
  rejectConnectionRequest,
  removeConnection,
  updateUserBio,
} from "./controllers/userController.js";
// used for env variables
dotenv.config();

const port = process.env.PORT;
const maxConnections = 50;

// app.listen(port, console.log(`Dax Server listening on port ${port}!`));

// NodeJs Server
const server = createServer(app);

// Socket.io Server (wraps Node server)
export const io = new Server(server, {
  cors: {
    origin: process.env.ORIGIN_URL || "http://localhost:7778",
  },
  connectionStateRecovery: {},
});

// Start Socket.io Server
server.listen(port, () => {
  console.log(`Dax Server listening on port ${port}!`);
});
io.use((socket, next) => {
  try {
    const cookies = socket.handshake.headers.cookie || "";

    const token = cookies
      .split(";")
      .map((c) => c.trim())
      .find((c) => c.startsWith("accessToken="))
      ?.split("=")[1];

    const decoded = jwt.verify(token, pubKey, { algorithms: ["RS256"] });

    socket.data.username = decoded.username;
    next();
  } catch (error) {
    next(new Error("Unauthorized"));
  }
});

io.on("connection", (socket) => {
  console.log("Connection from Socket ID: ", socket.id);
  console.log("Number of Listeners: ", socket.listenerCount());
  console.log(
    "Socket cookie present:",
    Boolean(socket.handshake.headers.cookie),
  );
  console.log(
    "Access token present:",
    socket.handshake.headers.cookie
      ?.split(";")
      .some((c) => c.trim().startsWith("accessToken=")),
  );
  console.log("Socket connected:", socket.id);
  console.log("Cookie present:", !!socket.handshake.headers.cookie);
  // console.log("Socket ID: ", socket.id);
  socket.emit("connected", "Connection to Socket.io Server Established");
  // Join Project Room by PID
  joinProjectRoom(socket);
  // Create Project Feed Post Based on PID
  createProjectFeedPost(socket);
  // // Get Project Feed Based on PID
  getProjectFeed(socket);
  // Join User Room by Username
  joinUserRoom(socket);
  // Send a Connection Request
  sendConnectionRequest(socket);
  // Get a Connection Request
  getConnectionRequest(socket);
  // Get Accepted Connections
  getConnections(socket);
  //Get User Profile
  getUserProfile(socket);
  // update user bio
  updateUserBio(socket);
  // User Accepted Connection Request
  acceptConnectionRequest(socket);
  // User Rejected Connection Request
  rejectConnectionRequest(socket);
  // User Remove Existing Connections
  removeConnection(socket);
});

// Create Postgres Database Pool
export const pgClient = new Pool({
  host: process.env.PG_DB_HOST,
  port: process.env.PG_DB_PORT,
  database: process.env.PG_DB_NAME,
  user: process.env.PG_DB_USER,
  password: process.env.PG_DB_USER_PW,
  max: maxConnections,
});

// Connect to Postgres Database
pgClient
  .connect()
  .then(() => {
    console.log(
      `Postgres Database Connection Established \nMax Connections: ${maxConnections}`,
    );
    updateProjectCategoriesCollection();
  })
  .catch((error) => console.log(error));

// Connect to Mongo Database
mongoose
  .connect(process.env.MONGO_DB_CONN)
  .then(() => {
    console.log(`Mongo Database Connection Established`);
    updateProfileCrestsCollection();
  })
  .catch((error) => console.log(error));
