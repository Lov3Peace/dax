import mongoose from "mongoose";

const projectCategoriesSchema = new mongoose.Schema({
  category: { type: String, required: true },
  description: { type: String, required: true },
  image: { type: String, required: true },
});

export default mongoose.model("projectCategorie", projectCategoriesSchema);
