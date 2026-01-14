import express from "express";
import cors from "cors";
import authRouter from "./routers/authRouter.js";
import cookieParser from "cookie-parser";
import authCheck from "./auth/authCheck.js";
import userDataRouter from "./routers/userDataRouter.js";
import projectsRouter from "./routers/projectsRouter.js";

const app = express();
app.use(express.json());

app.use(
  cors({
    credentials: true,
    origin: process.env.ORIGIN_URL || "http://localhost:7778",
    exposedHeaders: ["Authorization"],
  }),
); // for dev

app.use(cookieParser());

// Routers
app.use("/api/", authRouter);

app.use("/api/", userDataRouter);

app.use("/api/", projectsRouter);

export default app;
