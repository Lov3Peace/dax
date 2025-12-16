import { minioClient } from "../clients/minio.js";
import { errorLog, infoLog } from "../log.js";
import ProjectCategories from "../storage/models/projectCategory.js";
import projectPost from "../storage/models/projectPost.js";

export const updateProjectCategoriesCollection = async function () {
  const categories = await ProjectCategories.find({});
  const bucketStream = minioClient.listObjectsV2(
    "carbon-assets",
    "images",
    true,
  );
  bucketStream.on("data", async function (obj) {
    const fileExtReg = /\.\w+/;
    let category = obj.name
      .replace("-", " ")
      .replace("images/", "")
      .replace(fileExtReg, "");
    let capList = [];
    const catSplit = category.split(" ");
    catSplit.forEach(function (word) {
      const w = word.charAt(0).toUpperCase().concat(word.slice(1));
      capList.push(w);
    });
    let capWord;
    capList.forEach(function () {
      capWord = capList.join(" ");
    });
    const route = capWord.replace(" ", "-");
    // console.log(categories);
    if ((await ProjectCategories.find({ category: capWord })) < 1) {
      const newCategory = await ProjectCategories.create({
        category: capWord,
        description: " ",
        image: obj.name,
        route: route,
      });
      console.log(capWord);
    }
  });
};

export const getProjectsCategoryAssets = async (req, res) => {
  // debugger;
  // *ModelName*.find({}) returns all objects in the collection
  const categories = await ProjectCategories.find({});
  if (!categories) {
    return res.status(404).json("No categories found");
  }
  return res.status(200).json(categories);
};

export const getProjectPosts = async function (req, res) {
  const projectCategory = req.headers.category;
  if (!projectCategory) {
    return res.status(404).json("No category sent in header");
  }

  const projectCollection = Project;
};

export const createNewProject = async (req, res) => {
  console.log(req.body);
  console.log(req.body.pid);

  if (!req.body.pid) {
    return res.status(400).json("Invalid project");
  }
  const newProject = await projectPost.create({
    pid: req.body.pid,
    title: req.body.title,
    category: req.body.category,
    description: req.body.description,
    acceptanceCriteria: req.body.acceptanceCriteria,
    public: req.body.public,
    group: req.body.group,
    teammates: req.body.teammates,
    etc: req.body.etc,
    rolesNeeded: req.body.rolesNeeded,
    timestamp: req.body.timestamp,
    images: "",
  });
  return res.status(200).json("Project Posted Successfully");
};
