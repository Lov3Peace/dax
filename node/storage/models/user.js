import mongoose from "mongoose";
import { v4 as uuidv4 } from "uuid";

const userSchema = new mongoose.Schema({
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true, unique: false },
  refreshToken: { type: String, required: true, unique: true },
  email: { type: String, required: true, unique: true },
  isAdmin: { type: Boolean, required: true, default: false },
  roles: { type: Array, required: true, default: [] },
  skills: { type: Array },
  // profile: {type: String, required: true, default: ''}
});

export default mongoose.model("user", userSchema);
