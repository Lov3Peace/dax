import {
  getProjectsCategoryAssets,
  getProjectPosts,
  createNewProject,
  getProjectFeed,
} from "../controllers/projectsController.js";
import Router from "express";

const projectsRouter = Router();

projectsRouter.get("/projectsCategoryAssets", getProjectsCategoryAssets);
projectsRouter.get("/projectPosts/:category", getProjectPosts);
projectsRouter.post("/createNewProject", createNewProject);
projectsRouter.get("/projectFeed", getProjectFeed);

export default projectsRouter;
