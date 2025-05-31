import mongoose from "mongoose";

const projectPostSchema = new mongoose.Schema({
    user: { type: String, required: true },
    title: { type: String, required: true },
    content: { type: String, required: true },
    timestamp: { type: String, required: true },
    images: { type: Image, required: false }
});

export default mongoose.model("projectPost", projectPostSchema);