import {
  getProjectsCategoryAssets,
  getProjectPosts,
} from "../controllers/projectsController.js";
import Router from "express";

const projectsRouter = Router();

projectsRouter.get("/projectsCategoryAssets", getProjectsCategoryAssets);
projectsRouter.get("/projectPosts", getProjectPosts);

export default projectsRouter;
