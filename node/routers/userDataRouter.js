import user from "../models/user";
import { Router } from "express";
import { getUserDashboardData } from "../controllers/userController.js";

const userRouter = Router();

userRouter.get("/getUserDashboardData", getUserDashboardData);
