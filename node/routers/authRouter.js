import Router from "express";
import createUser from "../controllers/authController.js";
import deleteUser from "../controllers/authController.js";
const authRouter = Router();

authRouter.post('/register', createUser)

authRouter.delete('delete_user', deleteUser);

// authRouter.get('/login', loginUser);

// authRouter.put('/update', updateUser);



export default authRouter;