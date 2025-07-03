import Router from "express";
import {
    changeUsername,
    createUser,
    deleteUser,
    loginCheck,
    loginUser,
    logout,
} from "../controllers/authController.js";
const authRouter = Router();

authRouter.post("/register", createUser);

authRouter.delete("/deleteUser", deleteUser);

authRouter.post("/login", loginUser);

authRouter.get("/loginCheck", loginCheck);

authRouter.patch("/changeUsername", changeUsername);

authRouter.post("/logout", logout);

export default authRouter;
