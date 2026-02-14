import { Client } from "pg";
import User from "../storage/models/user.js";
// Logger for info, debug, errors, etc.
import { errorLog, infoLog } from "../log.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { generateKeyPairSync } from "crypto";
import { privKey, pubKey } from "../auth/keygen.js";
import { v4 as uuidv4 } from "uuid";

// Check if user exists; reused so created function
const userCheck = async (req, res) => {
  const { username, password } = req.body;
  const user = await User.findOne({ username });
  if (!username || !password) {
    infoLog.info(`Username/password cannot be null`);
    res.status(400).json(`Must input username and password!`);
    return user;
  }
  if (!user) {
    infoLog.info(`User '${username}' not found`);
    res.status(404).json(`User '${username}' not found`);
    return user;
  }
  return user;
};

// 30 Day variable to reuse (value in ms)
const thirtyDays = 30 * 24 * 60 * 60 * 1000;

// Register new user
export const register = async (req, res) => {
  try {
    const { username, password } = req.body;
    const user = await User.findOne({ username });
    if (user) {
      return res
        .status(400)
        .json(`User already exists. Please enter a unique username.`);
    }
    const hashedPw = await bcrypt.hash(req.body.password, 10);
    const refreshToken = uuidv4();

    const newUser = await User.create({
      username: req.body.username,
      password: hashedPw,
      email: req.body.email,
      isAdmin: req.body.isAdmin,
      refreshToken: refreshToken,
    });

    const accessToken = jwt.sign(
      {
        _id: newUser._id,
        username: newUser.username,
        roles: newUser.roles,
        isAdmin: newUser.isAdmin,
      },
      privKey,
      { algorithm: "RS256", expiresIn: "10s" },
    );
    res.cookie("accessToken", accessToken, {
      httpOnly: true,
      sameSite: "None",
      secure: true,
      maxAge: 60,
    });

    res.cookie("refreshToken", refreshToken, {
      httpOnly: true,
      sameSite: "None",
      secure: true,
      maxAge: thirtyDays,
    });

    res.cookie("rememberMe", req.headers.rememberme, {
      httpOnly: true,
      sameSite: "None",
      secure: true,
      maxAge: thirtyDays,
    });

    res.setHeader("Authorization", accessToken);
    // Tries to save a newUser to the db and returns the
    // response in JSON format with the 201 status code.
    // If it fails then return status code of 500 and
    // the error in JSON format
    infoLog.info(`User ${newUser.username} Account Created Successfully`);
    return res
      .status(201)
      .json({ username: newUser.username, accessToken: accessToken });
  } catch (error) {
    errorLog.error("error", error);
    return res.status(500).json(error);
  }
};

// Log user in
export const login = async (req, res) => {
  try {
    console.log("Login Endpoint Hit!");
    const { username, password } = req.body;
    const rememberMe = req.headers.rememberme;

    const user = await userCheck(req, res);
    if (user) {
      // Retrieve the hashed pw in the DB
      const hashedDbPw = user.password;
      // Compare the hashed pw to the request pw
      const matched = await bcrypt.compare(password, hashedDbPw);
      // If matched returns true, generate and verify JWTs
      if (matched) {
        // JWT Generation and Verification
        const accessToken = jwt.sign(
          {
            _id: user._id,
            username: user.username,
            roles: user.roles,
            isAdmin: user.isAdmin,
          },
          privKey,
          { algorithm: "RS256", expiresIn: "1m" },
        );
        // debugger;
        const newRefreshToken = uuidv4();
        await User.findOneAndUpdate(
          { username: username },
          { $set: { refreshToken: newRefreshToken } },
          { new: true },
        );
        // const decoded = jwt.verify(token, pubKey, { algorithms: "RS256" });

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

        res.cookie("rememberMe", rememberMe, {
          httpOnly: true,
          sameSite: "None",
          secure: true,
          maxAge: thirtyDays,
        });
        infoLog.info(`${user.username} logged in successfully`);
        console.log(`${user.username} logged in Successfully`);

        res.setHeader("Authorization", accessToken);

        return res.status(200).json({ username: user.username });
      } else {
        infoLog.info(`Invalid username / password - try again.`);
        console.log(`Invalid username / password - try again.`);
        return res.status(401).json(`Invalid username / password - try again.`);
      }
    }
  } catch (error) {
    errorLog.error("error", error);
    return res.status(500).json(`Error: ${error} `);
  }
};

// Log user out
export const logout = async (req, res) => {
  try {
    const cookies = req.cookies;
    res.clearCookie("accessToken", {
      httpOnly: true,
      sameSite: "None",
      secure: true,
    });
    res.clearCookie("refreshToken", {
      httpOnly: true,
      sameSite: "None",
      secure: true,
    });
    res.clearCookie("rememberMe", {
      httpOnly: true, // match httpOnly
      secure: true, // match secure
      sameSite: "Strict", // match sameSite
    });
    return res.status(200).json(`User has been logged out.`);
  } catch (error) {
    errorLog.error(`Unable to log out: ${error} `);
    console.log(`Unable to log out: ${error} `);
    return res.status(500).json(`Unable to log out - try again later.`);
  }
};

// Delete user account
export const deleteUser = async (req, res) => {
  try {
    // const inputUsername = req.body.username;
    // const inputPW = req.body.password;
    const { username, password } = req.body;
    const user = await userCheck(req, res);
    const hashedDbPw = user.password;
    const matched = await bcrypt.compare(password, hashedDbPw);
    if (matched) {
      // JWT Generation and Verification
      const decoded = jwt.verify(accessToken, pubKey, { algorithms: "RS256" });
      const deletedUser = await User.deleteOne({ username: user.username });
      infoLog.info(`User '${user.username}' deleted successfully`);
      return res
        .status(200)
        .json(`User '${user.username}' deleted successfully`);
    } else {
      return res
        .status(401)
        .json(`Authentication for '${user.username}' failed`);
    }
  } catch (error) {
    errorLog.error(error);
    return res.status(500).json(error);
  }
};

// Change username
export const changeUsername = async (req, res) => {
  const { username, password, newUsername } = req.body;
  try {
    const user = await userCheck(req, res);
    const hashedDbPw = user.password;
    const matched = await bcrypt.compare(password, hashedDbPw);
    if (matched) {
      const updatedUser = await User.findOneAndUpdate(
        { username: username },
        { $set: { username: newUsername } },
      );
      res.status(200).json({ OldUsername: username, NewUsername: newUsername });
    } else {
      return res
        .status(401)
        .json(`Authentication for '${user.username}' failed`);
    }
  } catch (error) {
    res.status(500).json(error);
  }
};

export const pgLogin = async (req, res) => {};
