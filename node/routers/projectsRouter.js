import { getProjectsCategoryAssets } from "../controllers/projectsController.js";
import Router from "express";

const projectsRouter = Router();

projectsRouter.get("/projectsCategoryAssets", getProjectsCategoryAssets);

export default projectsRouter;
