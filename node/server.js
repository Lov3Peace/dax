import mongoose from "mongoose";
import app from "./app.js";
import dotenv from "dotenv";
import https from "https";
import fs from "fs";

// used for env variables
dotenv.config();

const port = process.env.PORT;
// http.createServer(app).listen(80);
https
    .createServer(
        {
            key: fs.readFileSync("./key.pem"),
            cert: fs.readFileSync("./cert.pem"),
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
