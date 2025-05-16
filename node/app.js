import express from 'express';
const app = express();
import mongoose from 'mongoose';
import cors from 'cors';
import authRouter from './routers/authRouter.js';

app.get('/node', (req, res) => {
    console.log(`Connected: ${req.ip}`);
    res.send({ success: true });
});

app.use(express.json())

app.use('/api/', authRouter)

app.use(cors());

export default app;