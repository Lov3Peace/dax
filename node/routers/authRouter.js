import Router from "express";
import { createUser, deleteUser } from "../controllers/authController.js";
const authRouter = Router();

authRouter.post('/register', createUser)

authRouter.delete('/deleteUser', deleteUser);

// authRouter.get('/login', loginUser);

// authRouter.put('/update', updateUser);



export default authRouter;