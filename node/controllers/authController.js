import User from "../storage/models/user.js";
// Logger for info, debug, errors, etc.
import { errorLog, infoLog } from "../log.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { generateKeyPairSync } from "crypto";
import { privKey, pubKey } from "../auth/keygen.js";

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

const thirtyDays = 30 * 24 * 60 * 60 * 1000;

export const register = async (req, res) => {
  debugger;
  try {
    const { username, password } = req.body;
    const user = await User.findOne({ username });
    if (user) {
      return res
        .status(400)
        .json(`User already exists. Please enter a unique username.`);
    }
    const hashedPw = await bcrypt.hash(req.body.password, 10);
    // const newUser = new User({
    //   username: req.body.username,
    //   password: hashedPw,
    //   email: req.body.email,
    //   isAdmin: req.body.isAdmin,
    //   rememberMe: req.body.rememberme,
    // });
    // await newUser.save();
    const newUser = await User.create({
      username: req.body.username,
      password: hashedPw,
      email: req.body.email,
      isAdmin: req.body.isAdmin,
      rememberMe: req.body.rememberme,
    });

    const token = jwt.sign(
      {
        _id: newUser._id,
        username: newUser.username,
        roles: newUser.roles,
        isAdmin: newUser.isAdmin,
        rememberMe: newUser.rememberMe,
      },
      privKey,
      { algorithm: "RS256", expiresIn: "1m" },
    );
    res.cookie("token", token, {
      httpOnly: true,
      sameSite: "None",
      secure: true,
      maxAge: "60000",
    });
    res.cookie("username", username, {
      httpOnly: true,
      sameSite: "None",
      secure: true,
      maxAge: "60000",
    });
    res.cookie("rememberMe", req.body.rememberMe, {
      httpOnly: true,
      sameSite: "None",
      secure: true,
      maxAge: `${thirtyDays}`,
    });

    res.setHeader("Authorization", token);
    // Tries to save a newUser to the db and returns the
    // response in JSON format with the 201 status code.
    // If it fails then return status code of 500 and
    // the error in JSON format
    infoLog.info(`User ${newUser.username} Account Created Successfully`);
    return res.status(201).json({ username: newUser.username, token: token });
  } catch (error) {
    errorLog.error("error", error);
    return res.status(500).json(error);
  }
};

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
        const token = jwt.sign(
          {
            _id: user._id,
            username: user.username,
            roles: user.roles,
            isAdmin: user.isAdmin,
            rememberMe: user.rememberMe,
          },
          privKey,
          { algorithm: "RS256", expiresIn: "1m" },
        );
        // const decoded = jwt.verify(token, pubKey, { algorithms: "RS256" });

        res.cookie("token", token, {
          httpOnly: true,
          sameSite: "None",
          secure: true,
          maxAge: "60000",
        });
        res.cookie("username", username, {
          httpOnly: true,
          sameSite: "None",
          secure: true,
          maxAge: "60000",
        });
        res.cookie("rememberMe", rememberMe, {
          httpOnly: true,
          sameSite: "None",
          secure: true,
          maxAge: `${thirtyDays}`,
        });
        infoLog.info(`${user.username} logged in successfully`);
        console.log(`${user.username} logged in Successfully`);

        res.setHeader("Authorization", token);

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

export const logout = async (req, res) => {
  try {
    console.log("trying to log out");
    const cookies = req.cookies;
    const username = cookies.username;
    res.clearCookie("token", {
      httpOnly: true,
      sameSite: "None",
      secure: true,
    });
    res.clearCookie("rememberMe", {
      httpOnly: true, // match httpOnly
      secure: true, // match secure
      sameSite: "Strict", // match sameSite
    });
    console.log(username);
    return res.status(200).json(`User ${username} has been logged out.`);
  } catch (error) {
    errorLog.error(`Unable to log out: ${error} `);
    console.log(`Unable to log out: ${error} `);
    return res.status(500).json(`Unable to log out - try again later.`);
  }
};

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
      const decoded = jwt.verify(token, pubKey, { algorithms: "RS256" });
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
