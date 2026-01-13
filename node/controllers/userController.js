import authCheck from "../auth/authCheck.js";
import user from "../storage/models/user.js";
import User from "../storage/models/user.js";

export const getUsers = async (req, res) => {
  console.log("Get Users Hit");
  const param = req.query.searchString;
  const users = await User.find({ username: { $regex: param } });
  // console.log(`Users: ${users}`);
  return res.status(200).json(users);
};

export const getUserDashboardData = async (req, res) => {
  console.log("trying to fetch user data...");
  const username = req.cookies.username;

  if (username) {
    const user = await User.findOne({ username });

    return res.status(200).json({
      username: user.username,
    });
  }
  return res.status(404).json("User not found");
};
