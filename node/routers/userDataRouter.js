import { Router } from "express";
import { getUserDashboardData } from "../controllers/userController.js";

const userDataRouter = Router();

userDataRouter.get("/getUserDashboardData", getUserDashboardData);

export default userDataRouter;
