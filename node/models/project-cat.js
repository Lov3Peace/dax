import mongoose from "mongoose";

const projectCatSchema = new mongoose.Schema({
    category: { type: String, required: true },
    subHeading: { type: String, required: false },
    image: { type: Image, required: false }
});

export default mongoose.model("projectCat", projectCatSchema);