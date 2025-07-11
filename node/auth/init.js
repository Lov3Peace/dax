// Logger for info, debug, errors, etc.
import { errorLog, infoLog } from "../log.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { generateKeyPairSync } from "crypto";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { privKey, pubKey } from "./keygen.js";
import User from "../models/user.js";
export const initLoginCheck = async (req, res, next) => {
    console.log("Init Hit");
    debugger;
    try {
        const token = req.cookies.token;
        if (!token) {
            console.log("Token didn't load or got erased");
            return res.status(401).json("User must login");
        } else {
            const decoded = jwt.verify(token, pubKey, {
                algorithms: ["RS256"],
            });
            //decoded.user_id and get the data from db call and put in res
            const userID = decoded._id;
            const user = await User.findOne({ userID });
            const username = user.username;
            return res.status(200).json({
                message: "Valid token found - login successful",
                username: username,
            });
        }
    } catch (error) {
        if (error.message.includes("expired")) {
            const refreshToken = jwt.sign(
                {
                    id: user._id,
                    role: user.roles,
                    isAdmin: user.isAdmin,
                    rememberMe: user.rememberMe,
                },
                privKey,
                { algorithm: "RS256", expiresIn: "1m" },
            );
            res.cookie("token", refreshToken, {
                httpOnly: true,
                sameSite: "None",
                secure: true,
                maxAge: "60000",
            });
            res.cookie("username", req.cookies.username, {
                httpOnly: true,
                sameSite: "None",
                secure: true,
                maxAge: "60000",
            });
            return res.status(200).json("Refresh token generated - login successful");
        }
        infoLog.info(error);
        res.status(401).json(`Token expired or invalid`);
    }
};
