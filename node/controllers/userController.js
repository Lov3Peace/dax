import { authCheck } from "../auth/authCheck";
import User from "../models/user";

export const getUserDashboardData = async (req, res) => {
    console.log("trying to fetch user data...");
    debugger;
    const username = req.cookies.username;

    if (username) {
        const user = await User.findOne({ username });

        return res.status(200).json({
            username: user.username,
        });
    }
    return res.status(404).json("User not found");
};
