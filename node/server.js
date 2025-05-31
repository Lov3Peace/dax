import mongoose from 'mongoose';
import app from './app.js';
import dotenv from "dotenv";

// used for env variables
dotenv.config()

const port = process.env.PORT;

app.listen(port, console.log(`Dax Server listening on port ${port}!`));

mongoose.connect(process.env.DB_CONN)
    .then(() => console.log(`Database Connection Established`))
    .catch((error) => console.log(error));