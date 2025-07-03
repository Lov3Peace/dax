import express from "express";
const app = express();
import cors from "cors";
import authRouter from "./routers/authRouter.js";
import cookieParser from "cookie-parser";

app.use(express.json());

app.use(cors({ credentials: true, origin: "http://localhost:7778" }));

app.use(cookieParser());

app.use("/api/", authRouter);

// app.get('/node', (req, res) => {
//     console.log(`Connected: ${req.ip}`);a
//     res.send({ success: true });
// });

export default app;
