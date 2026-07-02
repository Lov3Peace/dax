import User from "../storage/models/user.js";
// Logger for info, debug, errors, etc.
import { logger } from "../log.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { generateKeyPairSync } from "crypto";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { privKey, pubKey } from "./keygen.js";

const authCheck = async (req, res, next) => {
  const rememberMe = req.headers.rememberme;
  const username = req.body.username;
  try {
    console.log("LoginCheck Hit");
    const cookies = req.cookies;
    if (cookies.token) {
      // If the token is invalid or expired, it throws an error. So, just catch it, log it, and log out the user
      const decoded = jwt.verify(cookies.token, pubKey, {
        algorithms: ["RS256"],
      });
      console.log("User currently logged in.");
      next();
      // return res.status(200).json("Token currently valid.");
    } else {
      // res.clearCookie("token");
      // res.clearCookie("username");
      logger.info(`No token found`);
      return res.status(401).json(`No token found`);
    }
  } catch (error) {
    if (error.message.includes("expired") && rememberMe == "true") {
      const user = User.findOne({ username });
      if (user) {
        const refreshToken = jwt.sign(
          {
            _id: user._id,
            username: user.username,
            role: user.roles,
            isAdmin: user.isAdmin,
            rememberMe: user.rememberMe,
          },
          privKey,
          { algorithm: "RS256", expiresIn: "1m" },
        );
        next();
      }
    } else {
      res.clearCookie("token");
      res.clearCookie("username");
      logger.info(error);
      res.status(401).json(`Token expired or invalid`);
    }
  }
};

export default authCheck;
