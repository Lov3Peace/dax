import express from 'express';
const app = express()
import cors from 'cors';

app.get('/node', (req, res) => {
    console.log(`Connected: ${req.ip}`);
    res.send({ success: true });
});

app.use(cors());

export default app;