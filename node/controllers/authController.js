import User from "../models/user.js";
import { errorLog, infoLog } from "../log.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { generateKeyPairSync } from "crypto";
// Logger for info, debug, errors, etc.

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
    // Creates a 'newUser' object and sets it equal to a
    // new instance of the 'User' model that we imported above
    // (the 'new' keyword is creating the new instance of the model
    // which gives us more control over what we do with the model)

    try {
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
        debugger;
        const { username, password } = req.body;
        const user = userCheck();
        // Retrieve the hashed pw in the DB
        const hashedDbPw = await user.password;
        // Compare the hashed pw to the request pw
        const matched = await bcrypt.compare(password, hashedDbPw);
        // If matched returns true, generate and verify JWTs
        if (matched) {
            // JWT Generation and Verification
            const { privateKey, publicKey } = generateKeyPairSync("rsa", {
                modulusLength: 4096,
                privateKeyEncoding: { type: 'pkcs8', format: 'pem' },
                publicKeyEncoding: { type: 'spki', format: 'pem' },
            });
            const token = jwt.sign({
                id: user._id,
                role: user.roles,
                isAdmin: user.isAdmin
            },
                privateKey,
                { algorithm: 'RS256', expiresIn: '30m' }
            );
            const decoded = jwt.verify(token, publicKey, { algorithms: "RS256" });

            infoLog.info(`${user.username} logged in successfully`);
            console.log(`${user.username} logged in Successfully`);

            return res.status(200).json({ user: user.username, token });
        } else {
            return res.status(401).json(`Authentication for ${user.username} failed`);
        }
    } catch (error) {
        errorLog.error("error", error);
        return res.s
    }
};

export const deleteUser = async (req, res) => {
    try {
        // debugger;
        // const inputUsername = req.body.username;
        // const inputPW = req.body.password;
        const { username, password } = req.body;
        const hashedDbPw = user.password;
        const matched = await bcrypt.compare(password, hashedDbPw);
        if (matched) {
            // JWT Generation and Verification
            const { privateKey, publicKey } = generateKeyPairSync("rsa", {
                modulusLength: 4096,
                privateKeyEncoding: { type: 'pkcs8', format: 'pem' },
                publicKeyEncoding: { type: 'spki', format: 'pem' },
            });
            const token = jwt.sign({
                id: user._id,
                role: user.roles,
                isAdmin: user.isAdmin
            },
                privateKey,
                { algorithm: 'RS256', expiresIn: '30m' }
            );
            const decoded = jwt.verify(token, publicKey, { algorithms: "RS256" })
            const deletedUser = await User.deleteOne({ username: user.username });
            infoLog.info(`User '${user.username}' deleted successfully`);
            return res.status(200).json(`User '${user.username}' deleted successfully`);
        } else {
            return res.status(401).json(`Authentication for '${user.username}' failed`);
        }
    } catch (error) {
        errorLog.error(error);
        return res.status(500).json(error);
    }
};

export const updateUser = async (req, res) => {
    // debugger;
    const { username, password, newUsername } = req.body;
    const user = await User.findOne({ username: username });
    if (!username || !password) {
        infoLog.info(`Username/password cannot be null`);
        return res.status(400).json(`Must input username and password!`);
    }
    if (!user) {
        infoLog.info(`User '${username}' not found`);
        return res.status(404).json(`User '${username}' not found`);
    }
    try {
        const hashedDbPw = user.password;
        const matched = await bcrypt.compare(password, hashedDbPw);
        if (matched) {
            const updatedUser = await User.findOneAndUpdate({ username: username }, { $set: { username: newUsername } });
            res.status(200).json({ OldUsername: username, NewUsername: newUsername });
        } else {
            return res.status(401).json(`Authentication for '${user.username}' failed`);
        }
    }
    catch (error) {
        res.status(500).json(error);
    }
};
