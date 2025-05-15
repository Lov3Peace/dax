import user from "../models/user.js";

const createUser = async (req, res) => {
    const newUser = new user({
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

export default createUser;