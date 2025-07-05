import Router from "express";
import {
    changeUsername,
    deleteUser,
    loginCheck,
    login,
    logout,
    register,
} from "../controllers/authController.js";
const authRouter = Router();

authRouter.post("/register", register);

authRouter.delete("/deleteUser", deleteUser);

authRouter.post("/login", login);

authRouter.get("/loginCheck", loginCheck);

authRouter.patch("/changeUsername", changeUsername);

authRouter.post("/logout", logout);

export default authRouter;
