import { minioClient } from "../clients/minio.js";
import { errorLog, infoLog } from "../log.js";
import ProjectCategories from "../storage/models/project-cat.js";

export const getProjectsCategoryAssets = async (req, res) => {
  // debugger;
  const categories = await ProjectCategories.find({});
  console.log(categories);

  if (!categories) {
    return res.status(404).json("No categories found");
  } else {
    let catResObj = [];
    categories.forEach(function (obj) {
      const cat = obj.category;
      catResObj.push({ cat: obj });
    });
    return res.status(200).json(categories);
  }

  // const imgList = [
  //   "george-oliver-IkDeiIRVy_U-unsplash.jpg",
  //   "construction-project.jpg",
  //   "software-development.jpg",
  // ];
  // const imgUrlList = [];
  //
  // imgList.forEach(async function (img, i) {
  //   const objUrl = await minioClient.presignedGetObject(
  //     "carbon-assets",
  //     "images/".concat(img),
  //     10,
  //   );
  //
  //   if (objUrl) {
  //     imgUrlList.push(objUrl);
  //     console.log("Image Retrieved Successfully:", objUrl);
  //   }
  // });
  // if (imgUrlList.length < 1) {
  //   return res.status(400).json("Empty List Returned");
  // } else {
  //   infoLog.info("URLs Returned:", imgUrlList);
  //   return res.status(200).json({ urls: imgUrlList });
  // }
};
