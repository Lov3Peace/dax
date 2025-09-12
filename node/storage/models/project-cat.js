import mongoose from "mongoose";

const projectCategoriesSchema = new mongoose.Schema({
  category: { type: String, required: true },
  description: { type: String, required: true },
  image: { type: String, required: true },
});
// doing mongoose.model() creates the collection in the database as soon as
// the server is restarted (it will make the name all lowercase in the db and
// add an 's' at the end lol)
export default mongoose.model("projectCategories", projectCategoriesSchema);
