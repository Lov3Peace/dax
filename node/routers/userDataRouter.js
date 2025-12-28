import { Router } from "express";
import {
  getUserDashboardData,
  getUsers,
} from "../controllers/userController.js";

const userDataRouter = Router();

userDataRouter.get("/getUserDashboardData", getUserDashboardData);
userDataRouter.get("/getUsers", getUsers);

export default userDataRouter;
