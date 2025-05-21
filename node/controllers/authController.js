import User from "../models/user.js";
import CryptoJS from "crypto-js";
import { errorLog, infoLog } from "../log.js";
// Logger for info, debug, errors, etc.
const createUser = async (req, res) => {
    // Creates a 'newUser' object and sets it equal to a 
    // new instance of the 'User' model that we imported above 
    // (the 'new' keyword is creating the new instance of the model
    // which gives us more control over what we do with the model)
    const newUser = new User({
        username: req.body.username,
        password: CryptoJS.AES.encrypt(req.body.password, process.env.SECRET).toString(),
        isAdmin: req.body.isAdmin
    });
    try {
        // Tries to save a newUser to the db and returns the 
        // response in JSON format with the 201 status code.
        // If it fails then return status code of 500 and 
        // the error in JSON format
        const savedUser = await newUser.save();
        res.status(201).json(savedUser);
        infoLog.info(`User ${savedUser.username} Account Created Successfully`);
    } catch (error) {
        res.status(500).json(error);
        errorLog.error('error', error);
    }
}

const deleteUser = async (req, res) => {
    try {
        User.deleteOne({ username: req.body.username })
        res.status(200).json(deletedUser);
    } catch (error) {

        res.status(500).json(error);

    }
}

export default [createUser, deleteUser];