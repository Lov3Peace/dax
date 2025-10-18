import mongoose from "mongoose";

const projectPostSchema = new mongoose.Schema({
    title: { type: String, required: true },
    timestamp: { type: String, required: true },
    images: { type: Image, required: false },
    members: { type: Array, required: true },

});

export default mongoose.model("projectPost", projectPostSchema);
