import {
  getProjectsCategoryAssets,
  getProjectPosts,
  createNewProject,
} from "../controllers/projectsController.js";
import Router from "express";

const projectsRouter = Router();

projectsRouter.get("/projectsCategoryAssets", getProjectsCategoryAssets);
projectsRouter.get("/projectPosts", getProjectPosts);
projectsRouter.post("/createNewProject", createNewProject);

export default projectsRouter;
