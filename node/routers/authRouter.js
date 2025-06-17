import Router from "express";
import {
    createUser,
    deleteUser,
    loginUser,
    updateUser
} from "../controllers/authController.js";
const authRouter = Router();

authRouter.post("/register", createUser);

authRouter.delete("/deleteUser", deleteUser);

authRouter.get("/login", loginUser);

authRouter.put('/updateUser', updateUser);

export default authRouter;

