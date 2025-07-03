import User from "../models/user.js";
import { errorLog, infoLog } from "../log.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { generateKeyPairSync } from "crypto";
import cookieParser from "cookie-parser";
import { log } from "console";
// Logger for info, debug, errors, etc.

const { privateKey, publicKey } = generateKeyPairSync("rsa", {
    modulusLength: 2048,
    privateKeyEncoding: { type: "pkcs8", format: "pem" },
    publicKeyEncoding: { type: "spki", format: "pem" },
});

const userCheck = async (req, res) => {
    const { username, password } = req.body;
    const user = await User.findOne({ username });
    if (!username || !password) {
        infoLog.info(`Username/password cannot be null`);
        return res.status(400).json(`Must input username and password!`);
    }
    if (!user) {
        infoLog.info(`User '${username}' not found`);
        return res.status(404).json(`User '${username}' not found`);
    }
    return user;
};

export const createUser = async (req, res) => {
    try {
        const { username, password } = req.body;
        const user = await User.findOne({ username });
        if (user) {
            return res
                .status(400)
                .json(`User already exists. Please enter a unique username.`);
        }
        const hashedPw = await bcrypt.hash(req.body.password, 10);
        const newUser = new User({
            username: req.body.username,
            password: hashedPw,
            email: req.body.email,
            isAdmin: req.body.isAdmin,
        });
        // Tries to save a newUser to the db and returns the
        // response in JSON format with the 201 status code.
        // If it fails then return status code of 500 and
        // the error in JSON format
        const savedUser = await newUser.save();
        infoLog.info(`User ${savedUser.username} Account Created Successfully`);
        return res.status(201).json(savedUser);
    } catch (error) {
        errorLog.error("error", error);
        return res.status(500).json(error);
    }
};

export const loginUser = async (req, res) => {
    try {
        console.log("Login Endpoint Hit!");
        // debugger;
        const { username, password } = req.body;
        const user = await userCheck(req, res);
        // Retrieve the hashed pw in the DB
        const hashedDbPw = await user.password;
        // Compare the hashed pw to the request pw
        const matched = await bcrypt.compare(password, hashedDbPw);
        // If matched returns true, generate and verify JWTs
        if (matched) {
            // JWT Generation and Verification
            const token = jwt.sign(
                {
                    id: user._id,
                    role: user.roles,
                    isAdmin: user.isAdmin,
                },
                privateKey,
                { algorithm: "RS256", expiresIn: "5m" },
            );
            // const decoded = jwt.verify(token, publicKey, { algorithms: "RS256" });
            // debugger;
            res.cookie("token", token, {
                httpOnly: true,
                sameSite: "None",
                secure: true,
            });
            res.cookie("username", username);
            infoLog.info(`${user.username} logged in successfully`);
            console.log(`${user.username} logged in Successfully`);

            return res.status(200).json({ user: user.username });
        } else {
            return res.status(401).json(`Authentication for ${user.username} failed`);
        }
    } catch (error) {
        errorLog.error("error", error);
        return res.status(500).json("Error");
    }
};

export const loginCheck = async (req, res) => {
    // const isLoggedIn = false;
    try {
        console.log("LoginCheck Hit");
        // debugger;
        const cookie = req.cookies;
        if (cookie.token) {
            // If the token is invalid or expired, it throws an error. So, just catch it, log it, and log out the user
            const decoded = jwt.verify(cookie.token, publicKey, {
                algorithms: ["RS256"],
            });
            console.log("User currently logged in.");
            return res.status(200).json("User currently logged in.");
        } else {
            res.clearCookie("token");
            infoLog.info(`No token found`);
            return res.status(401).json(`No token found`);
        }
    } catch (mes) {
        res.clearCookie("token");
        infoLog.info(mes);
        res.status(401).json(`Token expired or invalid`);
    }
};

export const logout = async (req, res) => {
    const username = req.cookies("username");
    const token = req.cookies("token");
    res.clearCookie("token");
    return res.status(200).json(`User ${username} has been logged out.`);
};

export const deleteUser = async (req, res) => {
    try {
        // debugger;
        // const inputUsername = req.body.username;
        // const inputPW = req.body.password;
        const { username, password } = req.body;
        const user = await userCheck(req, res);
        const hashedDbPw = user.password;
        const matched = await bcrypt.compare(password, hashedDbPw);
        if (matched) {
            // JWT Generation and Verification
            const token = jwt.sign(
                {
                    id: user._id,
                    role: user.roles,
                    isAdmin: user.isAdmin,
                },
                privateKey,
                { algorithm: "RS256", expiresIn: "30m" },
            );
            const decoded = jwt.verify(token, publicKey, { algorithms: "RS256" });
            const deletedUser = await User.deleteOne({ username: user.username });
            infoLog.info(`User '${user.username}' deleted successfully`);
            return res
                .status(200)
                .json(`User '${user.username}' deleted successfully`);
        } else {
            return res
                .status(401)
                .json(`Authentication for '${user.username}' failed`);
        }
    } catch (error) {
        errorLog.error(error);
        return res.status(500).json(error);
    }
};

export const changeUsername = async (req, res) => {
    // debugger;
    const { username, password, newUsername } = req.body;
    try {
        const user = await userCheck(req, res);
        const hashedDbPw = user.password;
        const matched = await bcrypt.compare(password, hashedDbPw);
        if (matched) {
            const updatedUser = await User.findOneAndUpdate(
                { username: username },
                { $set: { username: newUsername } },
            );
            res.status(200).json({ OldUsername: username, NewUsername: newUsername });
        } else {
            return res
                .status(401)
                .json(`Authentication for '${user.username}' failed`);
        }
    } catch (error) {
        res.status(500).json(error);
    }
};
