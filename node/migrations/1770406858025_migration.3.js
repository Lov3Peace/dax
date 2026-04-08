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
    `ALTER TABLE software_development_projects.software_development_posts ALTER COLUMN images SET DEFAULT '{https://assets.crbn.cx/carbon-assets/images/software_development.jpg}'::text[];
`,
  );
  pgm.sql(
    `ALTER TABLE construction_projects.construction_posts ALTER COLUMN images SET DEFAULT '{https://assets.crbn.cx/carbon-assets/images/construction.jpg}'::text[];
`,
  );
  pgm.sql(
    `ALTER TABLE fashion_projects.fashion_posts ALTER COLUMN images SET DEFAULT '{https://assets.crbn.cx/carbon-assets/images/fashion.webp}'::text[];
`,
  );
  pgm.sql(
    `ALTER TABLE manufacturing_projects.manufacturing_posts ALTER COLUMN images SET DEFAULT '{https://assets.crbn.cx/carbon-assets/images/manufacturing.jpg}'::text[];
`,
  );
  pgm.sql(
    `UPDATE software_development_projects.software_development_posts SET images = DEFAULT`,
  );
  pgm.sql(
    `UPDATE construction_projects.construction_posts SET images = DEFAULT`,
  );
  pgm.sql(`UPDATE fashion_projects.fashion_posts SET images = DEFAULT`);
  pgm.sql(
    `UPDATE manufacturing_projects.manufacturing_posts SET images = DEFAULT`,
  );
};

/**
 * @param pgm {import('node-pg-migrate').MigrationBuilder}
 * @param run {() => void | undefined}
 * @returns {Promise<void> | void}
 */
export const down = (pgm) => {};
