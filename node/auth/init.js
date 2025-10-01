import { errorLog, infoLog } from "../log.js";
import jwt from "jsonwebtoken";
import { privKey, pubKey } from "./keygen.js";
import User from "../storage/models/user.js";
import { v4 as uuidv4 } from "uuid";

const thirtyDays = 30 * 24 * 60 * 60 * 1000;

export const initLoginCheck = async (req, res, next) => {
  console.log("Init Hit");
  debugger;
  try {
    const refreshToken = req.cookies.refreshToken;
    const rememberMe = req.cookies.rememberMe;
    if (!refreshToken) {
      console.log("Token didn't load or got erased");
      accessToken = "noToken";
    }
    const newRefreshToken = uuidv4();
    const user = await User.findOneAndUpdate(
      { refreshToken: refreshToken },
      { $set: { refreshToken: newRefreshToken } },
      { projection: { username: 1, refreshToken: 1 } },
    );
    //decoded.user_id and get the data from db call and put in res
    // const userID = decoded._id;
    if (!user) {
      return res.status(404).json("User not found");
    }
    if (user && rememberMe == "true") {
      const accessToken = jwt.sign(
        {
          id: user._id,
          username: user.username,
          refreshToken: newRefreshToken,
          role: user.roles,
          isAdmin: user.isAdmin,
        },
        privKey,
        { algorithm: "RS256", expiresIn: "1m" },
      );

      res.setHeader("Authorization", accessToken);
      res.cookie("accessToken", accessToken, {
        httpOnly: true,
        sameSite: "None",
        secure: true,
        maxAge: 9000,
      });
      res.cookie("refreshToken", newRefreshToken, {
        httpOnly: true,
        sameSite: "None",
        secure: true,
        maxAge: thirtyDays,
      });

      return res.status(200).json({
        message: "Valid access token found - login successful",
        username: user.username,
        rememberMe: rememberMe,
      });
    } else {
      infoLog.info("User not found or Remember Me not active");
      return res.status(401).json("User not found or Remember Me not active");
    }
  } catch (error) {
    // if (error.message.includes("expired")) {
    const refreshTokenCookie = req.cookies.refreshToken;
    const userDbRefreshToken = User.findOne({
      refreshToken: refreshTokenCookie,
    });

    if (userDbRefreshToken && req.cookies.rememberMe == "true") {
      const accessToken = jwt.sign(
        {
          id: userDbRefreshToken._id,
          username: userDbRefreshToken.username,
          role: userDbRefreshToken.roles,
          isAdmin: userDbRefreshToken.isAdmin,
        },
        privKey,
        { algorithm: "RS256", expiresIn: "1m" },
      );
      res.cookie("accessToken", accessToken, {
        httpOnly: true,
        sameSite: "None",
        secure: true,
        maxAge: 90000,
      });

      const refreshToken = User.updateOne(
        { username: userDbRefreshToken.username },
        { refreshToken: uuidv4() },
      );
      res.cookie("refreshToken", refreshToken, {
        httpOnly: true,
        sameSite: "None",
        secure: true,
        maxAge: thirtyDays,
      });
      console.log("Successfully generated refresh token");
      return res.status(200).json("Refresh token generated - login successful");
    }
    // }
    console.log(`Error: ${error}`);
    errorLog.error(error);
    res.status(401).json(`Token expired or invalid`);
  }
};
