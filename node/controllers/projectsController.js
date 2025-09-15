import { minioClient } from "../clients/minio.js";
import { errorLog, infoLog } from "../log.js";
import ProjectCategories from "../storage/models/project-cat.js";

export const getProjectsCategoryAssets = async (req, res) => {
  // debugger;
  // *ModelName*.find({}) returns all objects in the collection
  const categories = await ProjectCategories.find({});
  console.log(categories);

  if (!categories) {
    return res.status(404).json("No categories found");
  }
  return res.status(200).json(categories);
};

export const updateProjectCategoriesCollection = async function () {
  const bucketStream = minioClient.listObjectsV2(
    "carbon-assets",
    "images",
    true,
  );
  bucketStream.on("data", function (obj) {
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
    capList.forEach(function (word) {
      capWord = capList.join(" ");
    });
    console.log(capWord);
  });
};
