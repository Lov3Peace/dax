import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
	username: { type: String, required: true, unique: true },
	password: { type: String, required: true, unique: false },
	email: { type: String, required: true, unique: true },
	isAdmin: { type: Boolean, required: true, default: false },
	skills: { type: Array },
	// profile: {type: String, required: true, default: ''}
});

export default mongoose.model("user", userSchema);

