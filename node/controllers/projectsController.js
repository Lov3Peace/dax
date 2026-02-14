import mongoose from "mongoose";
import { minioClient } from "../clients/minio.js";
import { errorLog, infoLog } from "../log.js";
import ProjectCategories from "../storage/models/projectCategory.js";

// Update Project Categories List on Server Startup
export const updateProjectCategoriesCollection = async function() {
	const categories = await ProjectCategories.find({});
	const bucketStream = minioClient.listObjectsV2(
		"carbon-assets",
		"images",
		true,
	);
	bucketStream.on("data", async function(obj) {
		const fileExtReg = /\.\w+/;
		let category = obj.name
			.replace("-", " ")
			.replace("images/", "")
			.replace(fileExtReg, "");
		let capList = [];
		const catSplit = category.split(" ");
		catSplit.forEach(function(word) {
			const w = word.charAt(0).toUpperCase().concat(word.slice(1));
			capList.push(w);
		});
		let capWord;
		capList.forEach(function() {
			capWord = capList.join(" ");
		});
		const route = capWord.replace(" ", "-");
		// console.log(categories);
		if ((await ProjectCategories.find({ category: capWord })) < 1) {
			const newCategory = await ProjectCategories.create({
				category: capWord,
				description: " ",
				image: obj.name,
				route: route,
			});
			console.log(capWord);
		}
	});
};

// Get Project Posts
export const getProjectsCategoryAssets = async (req, res) => {
	// debugger;
	// *ModelName*.find({}) returns all objects in the collection
	const categories = await ProjectCategories.find({});
	if (!categories) {
		return res.status(404).json("No categories found");
	}
	return res.status(200).json(categories);
};

export const getProjectPosts = async function(req, res) {
	// const projectCategory = req.headers.category;
	const projectCategory = req.params.category + "-projects";
	console.log(`Project Category: ${projectCategory}`);
	if (!projectCategory) {
		return res.status(404).json("No category sent in header");
	}

	const collections = await mongoose.connection.db.listCollections().toArray();
	const collectionExists = collections.some((i) => i.name === projectCategory);

	if (collectionExists) {
		console.log(collections);
		const projectCollection =
			mongoose.connection.db.collection(projectCategory);
		const posts = await projectCollection.find({ public: true }).toArray();
		console.log(`Posts: ${posts}`);
		console.log(`Project Posts for ${projectCategory} Returned Successfully`);
		return res.status(200).json(posts);
	}
	return res.status(404).json(`Nothing returned for ${projectCategory}`);
};

// Create New Project Post
export const createNewProject = async (req, res) => {
	if (!req.body.pid) {
		return res.status(400).json("Invalid project");
	}
	let collectionName = req.body.category;
	try {
		collectionName = collectionName.toLowerCase().replaceAll(" ", "-");
		collectionName = collectionName + "-projects";
	} catch (e) {
		console.log(`Couldn't adjust category name: ${e}`);
	}
	let projectCollection;
	let reqProjectCategory;

	try {
		console.log(collectionName);
		// Find the collection in the DB that matches the category field in the body
		reqProjectCategory = mongoose.connection.db.collection({
			name: collectionName,
		}).collectionName;
		console.log(reqProjectCategory);
	} catch (e) {
		console.log(`Couldn't find collection in DB: ${e}`);
	}
	// If the collection doesn't exist, create one with the given schema
	if (!reqProjectCategory) {
		console.log("Project Category Doesn't Exist. Creating...");
		const projectPostSchema = new mongoose.Schema({
			pid: { type: String, required: true },
			user: { type: String, required: true },
			title: { type: String, required: true },
			category: { type: String, required: true },
			description: { type: String, required: true },
			acceptanceCriteria: { type: String, required: true },
			public: { type: Boolean, required: true },
			group: { type: Boolean, required: true },
			teammates: { type: Array, required: false },
			etc: { type: String, required: true },
			rolesNeeded: { type: String, required: false },
			timestamp: { type: String, required: true },
			images: { type: String, required: false },
		});
		try {
			projectCollection = mongoose.model(collectionName, projectPostSchema);
		} catch (e) {
			console.log(`Unable to instantiate model: ${e}`);
		}
	} else {
		console.log(`Project Category: ${collectionName} exists!`);
		try {
			projectCollection = mongoose.connection.db.collection(collectionName);
		} catch (e) {
			console.log(`Unable to find collection: ${e}`);
		}
	}
	const newProject = await projectCollection.insertOne({
		pid: req.body.pid,
		user: req.body.user,
		title: req.body.title,
		category: req.body.category,
		description: req.body.description,
		acceptanceCriteria: req.body.acceptanceCriteria,
		public: req.body.public,
		group: req.body.group,
		teammates: req.body.teammates,
		etc: req.body.etc,
		rolesNeeded: req.body.rolesNeeded,
		timestamp: req.body.timestamp,
		images: "",
	});
	return res.status(200).json(`Project ${req.body.title} Posted Successfully`);
};
