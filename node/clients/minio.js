import * as Minio from "minio";
import dotenv from "dotenv";

dotenv.config();

export const minioClient = new Minio.Client({
  // endPoint: "assets.crbn.cx",
  endPoint: "10.7.77.10",
  // port: 443,
  port: 8010,
  // useSSL: true,
  useSSL: false,
  // accessKey: process.env.MINIO_ACCESS_KEY,
  // secretKey: process.env.MINIO_SECRET_KEY,
});

// const getCreatorPng = await minioClient.getObject(
//   "carbon-assets",
//   "images/creator.png",
// );
