import { Router } from "express";
import {
	getUserDashboardData,
	getUsers,
	getLocation,
	sendConnectionRequest,
	acceptConnection,
	rejectConnection,
} from "../controllers/userController.js";

const userDataRouter = Router();

userDataRouter.get("/getUserDashboardData", getUserDashboardData);
userDataRouter.get("/getUsers", getUsers);
userDataRouter.get("/getLocation", getLocation);
userDataRouter.post("connections/request", sendConnectionRequest);
userDataRouter.patch("/connections/:id/accept", acceptConnection);
userDataRouter.delete("/connections/:id/reject", rejectConnection);

export default userDataRouter;


