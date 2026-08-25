import { Router } from "express";
import {
	getUserDashboardData,
	getUsers,
	getLocation,
} from "../controllers/userController.js";

const userDataRouter = Router();

userDataRouter.get("/getUserDashboardData", getUserDashboardData);
userDataRouter.get("/getUsers", getUsers);
userDataRouter.get("/getLocation", getLocation);
export default userDataRouter;


