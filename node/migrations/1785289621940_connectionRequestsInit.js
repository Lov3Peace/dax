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
	pgm.sql(
		"CREATE TABLE users.connection_requests (request_id BIGINT generated always as identity primary key, sender_username VARCHAR, receiver_username VARCHAR, status SMALLINT Default 0, timestamp TIMESTAMPTZ DEFAULT NOW(), CONSTRAINT unique_connection UNIQUE (sender_username,receiver_username));",
	);
};

/**
 * @param pgm {import('node-pg-migrate').MigrationBuilder}
 * @param run {() => void | undefined}
 * @returns {Promise<void> | void}
 */
export const down = (pgm) => { };
