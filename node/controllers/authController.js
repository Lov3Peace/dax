import user from "../models/user.js";

const createUser = async (req, res) => {
    const newUserObj = new createUserModel({
        username: req.body.username,
        password: req.body.password,
    });
    try {
        const savedUser = await newUser.save();
        res.status(201).json(savedUser);
    } catch (error) {
        // console.log(error);
        res.status(500).json(error);
    }
}

const deleteUser = async (req, res) => {
    const deletedUserObj = new deleteUserModel({
        username: req.body.username,
        password: req.body.password
    });
    try {
        const deletedUser = await deletedUserObj.deleteOne();
        res.status(200).json(deletedUser);
    } catch (error) {
        res.status(500).json(error);

    }
}

export default [createUser, deleteUser];