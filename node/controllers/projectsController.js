import mongoose from "mongoose";
import { minioClient } from "../clients/minio.js";
import { io, pgClient } from "../server.js";
import { logger } from "../log.js";
import ProjectCategories from "../storage/models/projectCategory.js";
import format from "pg-format";
import categoriesJson from "../storage/models/projectCategories.json" with { type: "json" };

// Update Project Categories List on Server Startup
export const updateProjectCategoriesCollection = async function() {
	// const categories = await ProjectCategories.find({});
	const bucketStream = minioClient.listObjectsV2(
		"carbon-assets",
		"images",
		true,
	);
	// Get blobs from minio bucket for category name, image path, and route
	bucketStream.on("data", async function(obj) {
		// Create category name value using file name
		const fileExtReg = /\.\w+/;
		let category = obj.name.replace("images/", "").replace(fileExtReg, "");
		let capList = [];
		const catSplit = category.split("_");
		catSplit.forEach(function(word) {
			const w = word.charAt(0).toUpperCase().concat(word.slice(1));
			capList.push(w);
		});
		let capitalWordSpaced;
		capList.forEach(() => (capitalWordSpaced = capList.join(" ")));

		// Table value setup
		const capitalWordWithUnderscores = capitalWordSpaced.replace(" ", "_");
		category = capitalWordSpaced;
		const route = capitalWordWithUnderscores;

		try {
			// Begin SQL Transaction
			await pgClient.query("BEGIN");
			// Check if schema and table exist before querying
			const schemaTableCheck = await pgClient.query(
				"select 1 FROM INFORMATION_SCHEMA.tables where table_schema = 'projects' and table_name = 'categories'",
			);
			if (schemaTableCheck.rowCount === 0) {
				console.log("Schema projects.categories has not been created yet!");
				await pgClient.query("ROLLBACK");
			}

			// Query to get list of categories
			const categories = await pgClient.query(
				`select category from projects.categories`,
			);
			// Name of schema and table to check for and create in db
			const schemaName = "projects";
			const tableName = "categories";

			// Check if category is in projects.categories
			const categoryCheck = categories.rows.some(
				(row) => row.category === category,
			);

			// If schema not in db then insert row in project categories table, create schema, and corresponding table
			if (!categoryCheck) {
				// Insert row into projects.categories
				const insertQuery = format(
					`INSERT INTO %I.%I ( category, description, image, route) VALUES ( $1, $2, $3, $4) `,
					schemaName,
					tableName,
				);
				await pgClient.query(insertQuery, [
					category,
					"DESCRIPTION",
					obj.name,
					route,
				]);
				const newCategoryCheck = await pgClient.query(
					`select category from projects.categories where category = '${category}'`,
				);
				if (newCategoryCheck.rowCount === 1) {
					console.log(`Inserted Successfully for ${category}`);
					logger.info(`Inserted Successfully for ${category}`);
				} else {
					console.log(`Error Inserting Row for ${category}`);
					logger.error(`Error Inserting Row for ${category}`);
				}
				// End SQL Transaction
			}
			await pgClient.query("COMMIT");
		} catch (e) {
			await pgClient.query("ROLLBACK");
			console.log("Transaction Failed and Rolled Back: ", e);
		}
	});
};

// Get Project Posts
export const getProjectsCategoryAssets = async (req, res) => {
	// *ModelName*.find({}) returns all objects in the collection
	// const categories = await ProjectCategories.find({});
	try {
		let categories = await pgClient.query(`select * from projects.categories`);
		categories = categories.rows;
		console.log(categories);
		if (!categories) {
			return res.status(404).json("No categories found");
		}
		return res.status(200).json(categories);
	} catch (e) {
		console.log("Error: ", e);
		return res.status(500).json({ error: e });
	}
};

export const getProjectPosts = async function(req, res) {
	const projectCategory = req.params.category.replaceAll("_", " ");
	try {
		// const projectCategory = req.headers.category;
		const schemaName = "projects";
		const tableName = "posts";
		console.log(`Project Category: ${projectCategory}`);
		if (!projectCategory) {
			return res.status(404).json("No category sent in header");
		}

		try {
			await pgClient.query("BEGIN");

			const posts = await pgClient.query(
				format(
					`SELECT username, title, category, description, acceptance_criteria, is_public, is_group, teammates, etc, roles_needed, timestamp, to_char(timestamp,'FMMonth, DD FMHH12:MI AM') as display_timestamp, images FROM %I.%I WHERE category = '${projectCategory}' AND timestamp < now() AND is_public = true ORDER BY timestamp DESC LIMIT 20`,

					schemaName,
					tableName,
				),
			);
			await pgClient.query("COMMIT");
			return res.status(200).json(posts.rows);
		} catch (e) {
			console.log("Unable to read from DB. Rolling Back...");
			logger.error(
				`There was an error retrieving posts for ${projectCategory}: ${e}`,
			);
			await pgClient.query("ROLLBACK");
			return res
				.status(400)
				.json(`There was an error retrieving posts for ${projectCategory}`);
		}
	} catch (e) {
		console.log("Error: ", e);
		logger.error(
			`There was an error retrieving posts for ${projectCategory}: ${e}`,
		);
		return res
			.status(500)
			.json(`There was an error retrieving posts for ${projectCategory}`);
	}
};

// Create New Project Post
export const createNewProject = async (req, res) => {
	let category = req.body.category;
	if (!category) {
		return res.status(400).json("Invalid project");
	}

	let body = req.body;
	const schemaName = "projects";
	const tableName = "posts";
	const columns = Object.keys(body);
	let values = [];
	let valuesPlaceholders = [];
	for (let i = 1; i < Object.keys(body).length + 1; i++) {
		valuesPlaceholders.push(`$${i}`);
	}
	console.log(valuesPlaceholders);

	// Check if Default Image is Needed
	if (!body.images || (Array.isArray(body.images) && body.images.length < 1)) {
		console.log("No Images List Sent");
		for (const cat in categoriesJson) {
			if (body.category == cat) {
				body.images = [categoriesJson[cat]];
			}
		}
	}

	if (
		!body.teammates ||
		(Array.isArray(body.teammates) && body.teammates.length < 1)
	) {
		console.log("No Teammates List Sent");
	}

	if (
		!body.roles_needed ||
		(Array.isArray(body.roles_needed) && body.roles_needed.length < 1)
	) {
		console.log("No Roles Needed List Sent");
	}
	values = Object.values(body);
	console.log("Values After Images Check: ", values);

	try {
		const insertQuery = format(
			`INSERT INTO %I.%I (${columns}) VALUES (${valuesPlaceholders})`,
			schemaName,
			tableName,
		);
		console.log("Insert Query: ", insertQuery);
		await pgClient.query("BEGIN");
		await pgClient.query(insertQuery, values);
		await pgClient.query("COMMIT");
		console.log(`Project ${req.body.title} Posted Successfully`);
	} catch (e) {
		await pgClient.query("ROLLBACK");
		console.log("Could not insert into table: ", e);
		return res.status(400).json("Could not insert into database");
	}

	return res.status(201).json({
		message: `Project ${req.body.title} Posted Successfully`,
		error: "",
	});
};

// Join Room for Project Feed by PID
export const joinProjectRoom = (socket) => {
	socket.on("joinProjectRoom", (pid) => {
		socket.join(pid.toString());
		console.log(`Socket ${socket.id} Joined Room Successfully`);
		socket.emit("roomJoined");
	});
};

// Create Project Feed Post Based on PID
export const createProjectFeedPost = async (socket) => {
	socket.on("createProjectFeedPost", async (reqBody, ack) => {
		console.log("Creating Post for Socket ID: ", socket.id);
		const username = reqBody["username"];
		const pid = reqBody["pid"];
		const content = reqBody["content"];
		const event_type = reqBody["event_type"];

		await pgClient.query("BEGIN");
		// Insert New Post and Return It to Update Feed on Front End
		let newPost = await pgClient.query(
			format(
				`INSERT INTO %I.%I (pid, username, event_type, content) VALUES ($1, $2, $3, $4) RETURNING username, timestamp, to_char(timestamp, 'FMMonth, DD FMHH12:MI AM') as display_timestamp, content`,
				"projects",
				"feeds",
			),
			[pid, username, event_type, content],
		);
		newPost = newPost.rows[0];
		console.log("Feed: ", newPost);

		await pgClient.query("COMMIT");

		console.log(`Emitting feedUpdate to Room: ${pid}...`);
		ack();
		// Emit to Specific Room
		io.to(pid.toString()).emit("feedUpdate", newPost);
	});
};

// Retrieve Project Feed by PID
export const getProjectFeed = (socket) => {
	socket.on("getProjectFeed", async (pid) => {
		// Join Room for PID

		console.log("Socket ID for getProjectFeed: ", socket.id, pid);
		console.log(`Retrieving Project Feed for PID: ${pid}`);
		// Query DB for Posts Based on PID
		await pgClient.query("BEGIN");
		const feed = await pgClient.query(
			format(
				`SELECT username, timestamp, to_char(timestamp,'FMMonth, DD FMHH12:MI AM') as display_timestamp, content from %I.%I where pid = $1 ORDER BY timestamp DESC LIMIT 20`,
				"projects",
				"feeds",
			),
			[pid],
		);
		// console.log("Feed: ", feed.rows);

		await pgClient.query("COMMIT");
		socket.emit("feedResponse", feed.rows);
	});
};
