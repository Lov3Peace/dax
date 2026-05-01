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

export const getLocation = async (req, res) => {
  try {
    let ip = req.ip;
    // for local testing
    if (ip === "::1" || ip === "127.0.0.1") {
      ip = "8.8.8.8"; // test only
    }
    console.log("IP: ", ip);
    if (!ip) {
      return res.status(404).json("Sorry, no location data available");
    }
    // Fetch location details from ipApi
    let locationRes = await fetch(
      "https://api.ipapi.com/api/check?access_key=5b20163bd553535fc71b6addd2ab130c",
    );

    locationRes = await locationRes.json();

    return res.status(200).json({
      latitude: locationRes.latitude,
      longitude: locationRes.longitude,
    });
  } catch (e) {
    return res.status(500).json("Error: ", e);
  }
};
