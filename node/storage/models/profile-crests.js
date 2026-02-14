import mongoose from "mongoose";

const profileCrestsSchema = new mongoose.Schema({
		// category: { type: String, required: true },
		rank: {type: String, required: true },
		image: { type: String, required: true },
});
// creating mongoose.model() in database.
//
export default mongoose.model("profileCrests" , profileCrestsSchema);
