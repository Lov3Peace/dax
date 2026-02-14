import mongoose from "mongoose";
import app from "./app.js";
import dotenv from "dotenv";
import { Client } from "pg";
import https from "https";
import fs from "fs";
import { minioClient } from "./clients/minio.js";
import {
  getProjectsCategoryAssets,
  updateProjectCategoriesCollection,
} from "./controllers/projectsController.js";
import {
  getProfileCrestAssets,
  updateProfileCrestsCollection,
} from "./controllers/profileController.js";
// used for env variables
dotenv.config();

const port = process.env.PORT;
// https
//   .createServer(
//     {
//       key: fs.readFileSync("./ssl/key.pem"),
//       cert: fs.readFileSync("./ssl/cert.pem"),
//       minVersion: "TLSv1.2",
//     },
//     app,
//   )
//   .listen(port, () =>
//     console.log(`Dax Server Started with HTTPS on port: ${port}`),
//   );

updateProjectCategoriesCollection();

updateProfileCrestsCollection();

app.listen(port, console.log(`Dax Server listening on port ${port}!`));

const client = new Client({
  host: process.env.PG_DB_HOST,
  port: process.env.PG_DB_PORT,
  database: process.env.PG_DB_NAME,
  user: process.env.PG_DB_USER,
  password: process.env.PG_DB_PW,
});

client
  .connect()
  .then(() => console.log(`Postgres Database Connection Established`))
  .catch((error) => console.log(error));

mongoose
  .connect(process.env.DB_CONN)
  .then(() => console.log(`Mongo Database Connection Established`))
  .catch((error) => console.log(error));
