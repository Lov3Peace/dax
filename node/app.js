import express from 'express';
const app = express()
import cors from 'cors';

app.get('/node', (req, res) =>
    res.send('YO IT WORKS'));

app.use(cors());

export default app;