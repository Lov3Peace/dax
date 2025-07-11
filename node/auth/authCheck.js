import User from "../models/user.js";
// Logger for info, debug, errors, etc.
import { errorLog, infoLog } from "../log.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { generateKeyPairSync } from "crypto";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const privateKey = fs.readFileSync(path.join(__dirname, "privateKey.pem"));
const publicKey = fs.readFileSync(path.join(__dirname, "publicKey.pem"));
export const authCheck = async (req, res, next) => {
    debugger;
    const rememberMe = req.headers.rememberme;
    const username = req.body.username;
    try {
        console.log("LoginCheck Hit");
        // debugger;
        const cookies = req.cookies;
        if (cookies.token) {
            // If the token is invalid or expired, it throws an error. So, just catch it, log it, and log out the user
            const decoded = jwt.verify(cookies.token, publicKey, {
                algorithms: ["RS256"],
            });
            console.log("User currently logged in.");
            next();
            // return res.status(200).json("Token currently valid.");
        } else {
            // res.clearCookie("token");
            // res.clearCookie("username");
            infoLog.info(`No token found`);
            return res.status(401).json(`No token found`);
        }
    } catch (error) {
        if (error.message.includes("expired") && rememberMe == "true") {
            next();
        } else {
            res.clearCookie("token");
            res.clearCookie("username");
            infoLog.info(error);
            res.status(401).json(`Token expired or invalid`);
        }
    }
};
