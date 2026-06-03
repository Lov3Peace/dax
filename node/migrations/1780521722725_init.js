/**
 * @type {import('node-pg-migrate').ColumnDefinitions | undefined}
 */
export const shorthands = undefined;

/**
 * @param pgm {import('node-pg-migrate').MigrationBuilder}
 * @param run {() => void | undefined}
 * @returns {Promise<void> | void}
 */
export const up = (pgm) => {
  pgm.sql("CREATE SCHEMA IF NOT EXISTS projects;");
  pgm.sql(
    "ALTER DEFAULT PRIVILEGES IN SCHEMA projects GRANT ALL PRIVILEGES ON TABLES TO carbon_master",
  );
  pgm.sql("GRANT USAGE ON SCHEMA projects TO carbon_user");
  pgm.sql(
    "ALTER DEFAULT PRIVILEGES IN SCHEMA projects GRANT USAGE, SELECT, INSERT, DELETE, UPDATE ON TABLES TO carbon_user",
  );
  pgm.sql(
    "CREATE TABLE IF NOT EXISTS projects.project_categories (id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, category VARCHAR NOT NULL, description VARCHAR NOT NULL, image VARCHAR NOT NULL, route VARCHAR NOT NULL, timestamp TIMESTAMPTZ NOT NULL DEFAULT now());",
  );
  pgm.sql(
    "CREATE TABLE IF NOT EXISTS projects.posts (id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, username VARCHAR NOT NULL, title VARCHAR NOT NULL, category VARCHAR NOT NULL, description VARCHAR NOT NULL, acceptance_criteria VARCHAR NOT NULL, is_public BOOLEAN NOT NULL, is_group BOOLEAN NOT NULL, teammates text[], etc VARCHAR, roles_needed text[], timestamp TIMESTAMPTZ NOT NULL DEFAULT now(), images TEXT[])",
  );
};

/**
 * @param pgm {import('node-pg-migrate').MigrationBuilder}
 * @param run {() => void | undefined}
 * @returns {Promise<void> | void}
 */
export const down = (pgm) => {};
