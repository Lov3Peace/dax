import mongoose from "mongoose";
import app from "./app.js";
import dotenv from "dotenv";
import { Pool } from "pg";
import { updateProjectCategoriesCollection } from "./controllers/projectsController.js";
import { updateProfileCrestsCollection } from "./controllers/profileController.js";
import { Server } from "socket.io";
import { createServer } from "node:http";
// used for env variables
dotenv.config();

const port = process.env.PORT;
const maxConnections = 50;

// app.listen(port, console.log(`Dax Server listening on port ${port}!`));

// Server
const server = createServer(app);
// Client
const io = new Server(server);

server.listen(port, () => {
  `Dax Server listening on port ${port}!`;
});

io.on("connection", (socket) => {
  console.log("WE IN DA BUILDIN");
});

export const pgClient = new Pool({
  host: process.env.PG_DB_HOST,
  port: process.env.PG_DB_PORT,
  database: process.env.PG_DB_NAME,
  user: process.env.PG_DB_USER,
  password: process.env.PG_DB_USER_PW,
  max: maxConnections,
});

pgClient
  .connect()
  .then(() => {
    console.log(
      `Postgres Database Connection Established \nMax Connections: ${maxConnections}`,
    );
    updateProjectCategoriesCollection();
    updateProfileCrestsCollection();
  })
  .catch((error) => console.log(error));

mongoose
  .connect(process.env.MONGO_DB_CONN)
  .then(() => console.log(`Mongo Database Connection Established`))
  .catch((error) => console.log(error));
