import Router from "express";
import {
    changeUsername,
    deleteUser,
    login,
    logout,
    register,
} from "../controllers/authController.js";
import { initLoginCheck } from "../auth/init.js";
import { authCheck } from "../auth/authCheck.js";
const authRouter = Router();

authRouter.get("/", initLoginCheck);

authRouter.post("/register", register);

authRouter.delete("/deleteUser", authCheck, deleteUser);

authRouter.post("/login", login);

authRouter.patch("/changeUsername", authCheck, changeUsername);

authRouter.post("/logout", logout);

export default authRouter;
