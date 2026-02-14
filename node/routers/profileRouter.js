// import { Router } from "express";
import { getProfileCrestAssets } from "../controllers/profileController.js";
import { Router } from "express";


const profileRouter = Router();

profileRouter.get("/profileCrestAssets", getProfileCrestAssets);

export default profileRouter;
