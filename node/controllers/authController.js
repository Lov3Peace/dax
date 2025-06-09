import User from "../models/user.js";
import CryptoJS from "crypto-js";
import { errorLog, infoLog } from "../log.js";
import bcrypt from 'bcrypt';
// Logger for info, debug, errors, etc.
export const createUser = async (req, res) => {
    // Creates a 'newUser' object and sets it equal to a 
    // new instance of the 'User' model that we imported above 
    // (the 'new' keyword is creating the new instance of the model
    // which gives us more control over what we do with the model)

    try {
        const hashedPw = await bcrypt.hash(req.body.password, 20);
        const newUser = new User({
            username: req.body.username,
            password: hashedPw,
            isAdmin: req.body.isAdmin
        });
        // Tries to save a newUser to the db and returns the 
        // response in JSON format with the 201 status code.
        // If it fails then return status code of 500 and 
        // the error in JSON format
        const savedUser = await newUser.save();
        res.status(201).json(savedUser);
        infoLog.info(`User ${savedUser.username} Account Created Successfully`);
    } catch (error) {
        res.status(500).json(error);
        console.log(error);
        errorLog.error('error', error);
    }
};

export const loginUser = async (req, res) => {
    try {
        bcrypt.compare(req.body.username, hash, function(err, result) {
            // result == true
        });
        bcrypt.compare(someOtherPlaintextPassword, hash, function(err, result) {
            // result == false
        });
    }
    catch {
    }
}
export const deleteUser = async (req, res) => {
    try {
        const deletedUser = User.deleteOne({ username: req.body.username });
        console.log(req.body.username);
        res.status(200).json(deletedUser);
    } catch (error) {
        errorLog.error(error);
        res.status(500).json(error);

    }
};
