import mongoose from "mongoose";
import app from "./app.js";
import dotenv from "dotenv";
import https from "https";
import fs from "fs";
import { minioClient } from "./clients/minio.js";
import { getProjectsCategoryAssets } from "./controllers/projectsController.js";

// used for env variables
dotenv.config();

const port = process.env.PORT;
https
  .createServer(
    {
      key: fs.readFileSync("./ssl/key.pem"),
      cert: fs.readFileSync("./ssl/cert.pem"),
      minVersion: "TLSv1.2",
    },
    app,
  )
  .listen(port, () =>
    console.log(`Dax Server Started with HTTPS on port: ${port}`),
  );

// app.listen(port, console.log(`Dax Server listening on port ${port}!`));

// mongoose.connect(process.env.DB_CONN)
//     .then(() => console.log(`Database Connection Established`))
//     .catch((error) => console.log(error));
mongoose
  .connect(process.env.LOCAL_DB_CONN)
  .then(() => console.log(`Database Connection Established`))
  .catch((error) => console.log(error));
