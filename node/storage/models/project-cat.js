import mongoose from "mongoose";

const projectCatSchema = new mongoose.Schema({
    category: { type: String, required: true },
    subHeading: { type: String, required: false },
    image: { type: Image, required: false }
});

const projectPostSchema = new mongoose.Schema({
    category: { type: String, required: true },
    description: { type: String, required: true },
    images: { type: Image, required: false }
});
const projectsSchemalList = []
projectsSchemaList.push(mongoose.model("projectsCatSchema", projectPostSchema));

export default projectsSchemalList;
