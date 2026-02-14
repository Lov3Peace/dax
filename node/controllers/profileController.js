import { minioClient } from "../clients/minio.js";
import { errorLog, infoLog } from "../log.js";
import ProfileCrests from "../storage/models/profile-crests.js";

export const getProfileCrestAssets = async (req, res) => {
  // debugger;
  // *ModelName*.find({}) returns all objects in the collection
  const crests = await ProfileCrests.find({});
  if (!crests) {
    return res.status(404).json("No crests found");
  }
  return res.status(200).json(crests);
};

export const updateProfileCrestsCollection = async function () {
  const crests = await ProfileCrests.find({});
  const bucketStream = minioClient.listObjectsV2(
    "carbon-assets",
    "crests",
    true,
  );
  bucketStream.on("data", async function (obj) {
    const fileExtReg = /\.\w+/;
    let rank = obj.name
      // .replace("-", " ")
      .replace("crests/", "")
      .replace(fileExtReg, "");
    let capList = [];
    const catSplit = rank.split(" ");
    catSplit.forEach(function (word) {
      const w = word.charAt(0).toUpperCase().concat(word.slice(1));
      capList.push(w);
    });
    let capWord;
    capList.forEach(function () {
      capWord = capList.join(" ");
    });
    // console.log(crests);
    if ((await ProfileCrests.find({ rank: capWord })) < 1) {
      const newCrest = await ProfileCrests.create({
        rank: capWord,
        image: obj.name,
      });
      // console.log(capWord);
    }
  });
};
