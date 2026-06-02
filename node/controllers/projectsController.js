import mongoose from "mongoose";
import { minioClient } from "../clients/minio.js";
import { pgClient } from "../server.js";
import { errorLog, infoLog } from "../log.js";
import ProjectCategories from "../storage/models/projectCategory.js";
import format from "pg-format";

// Update Project Categories List on Server Startup
export const updateProjectCategoriesCollection = async function () {
  // const categories = await ProjectCategories.find({});
  const bucketStream = minioClient.listObjectsV2(
    "carbon-assets",
    "images",
    true,
  );
  // Get blobs from minio bucket for category name, image path, and route
  bucketStream.on("data", async function (obj) {
    // Create category name value using file name
    const fileExtReg = /\.\w+/;
    let category = obj.name.replace("images/", "").replace(fileExtReg, "");
    let capList = [];
    const catSplit = category.split("_");
    catSplit.forEach(function (word) {
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
        "select 1 FROM INFORMATION_SCHEMA.tables where table_schema = 'projects' and table_name = 'posts'",
      );
      if (schemaTableCheck.rowCount === 0) {
        console.log("Schema or table has not been created yet!");
        await pgClient.query("ROLLBACK");
        return;
      }
      // Query to get list of categories
      const categories = await pgClient.query(
        `select category from projects.project_categories`,
      );
      // Name of schema and table to check for and create in db
      const schemaName = "projects";
      const tableName = "project_categories";

      // Check if category is in projects.project_categories
      const categoryCheck = categories.rows.some(
        (row) => row.category === category,
      );

      // If schema not in db then insert row in project categories table, create schema, and corresponding table
      if (!categoryCheck) {
        // Insert row into projects.project_categories
        await pgClient.query(
          `INSERT INTO projects.project_categories ( category, description, image, route) VALUES ( $1, $2, $3, $4) `,
          [category, "DESCRIPTION", obj.name, route],
        );
        console.log(`Inserted Successfully for ${category}`);
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
    let categories = await pgClient.query(
      `select * from projects.project_categories`,
    );
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

export const getProjectPosts = async function (req, res) {
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
      errorLog.error(
        `There was an error retrieving posts for ${projectCategory}: ${e}`,
      );
      await pgClient.query("ROLLBACK");
      return res
        .status(400)
        .json(`There was an error retrieving posts for ${projectCategory}`);
    }
  } catch (e) {
    console.log("Error: ", e);
    errorLog.error(
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

  const schemaName = "projects";
  const tableName = "posts";
  const columns = Object.keys(req.body);
  const values = Object.values(req.body);
  let valuePlaceholders = [];

  for (let i = 1; i <= values.length; i++) {
    const placeHolder = `$${i}`;
    valuePlaceholders.push(placeHolder);
  }

  console.log("COLUMNS: ", columns);
  console.log("VALUES: ", values);
  console.log("PLACEHOLDERS: ", valuePlaceholders);

  try {
    await pgClient.query("BEGIN");
    const categoryTable = await pgClient.query(
      format(
        `INSERT INTO %I.%I (${columns}) VALUES (${valuePlaceholders})`,
        schemaName,
        tableName,
      ),
      values,
    );
    await pgClient.query("COMMIT");
    console.log(`Project ${req.body.title} Posted Successfully`);
  } catch (e) {
    await pgClient.query("ROLLBACK");
    console.log("Could not insert into table: ", e);
    return res.status(400).json("Could not insert into database");
  }

  return res.status(201).json(`Project ${req.body.title} Posted Successfully`);
};
