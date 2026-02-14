import express from "express";
import cors from "cors";
import authRouter from "./routers/authRouter.js";
import cookieParser from "cookie-parser";
import authCheck from "./auth/authCheck.js";
import profileRouter from "./routers/profileRouter.js";
import projectsRouter from "./routers/projectsRouter.js";

const app = express();
app.use(express.json());

// app.use(cors({ credentials: true, origin: "http://10.7.77.8:7778" })); // for web build
app.use(
  cors({
    credentials: true,
    origin: process.env.ORIGIN_URL || "http://localhost:7778",
    exposedHeaders: ["Authorization"],
  }),
); // for dev

app.use(cookieParser());

app.use("/api/", authRouter);

app.use("/api/", profileRouter);

app.use("/api/", projectsRouter);

// app.get('/node', (req, res) => {
//     console.log(`Connected: ${req.ip}`);a
//     res.send({ success: true });
// });

export default app;
