import authCheck from "../auth/authCheck.js";
import user from "../storage/models/user.js";
import User from "../storage/models/user.js";

export const getUsers = async (req, res) => {
  console.log("Get Users Hit");
  const param = req.query.searchString;
  let users;
  if (param) {
    users = await User.find({ username: { $regex: param } }).limit(25);
    return res.status(200).json(users);
  } else {
    return res.status(400).json("Search cannot be empty!");
  }
  // console.log(`Users: ${users}`);
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
