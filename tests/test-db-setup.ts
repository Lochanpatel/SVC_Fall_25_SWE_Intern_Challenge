import { execSync } from "child_process";
import fs from "fs";
import path from "path";
import { Pool } from "pg";

export async function ensureDatabaseEnvironment() {
  console.log("🔧 Using CI PostgreSQL service. Skipping auto-install.");

  const host = process.env.PGHOST || "localhost";
  const port = process.env.PGPORT || "5432";
  const user = process.env.PGUSER || "test";
  const password = process.env.PGPASSWORD || "test";
  const db = process.env.PGDATABASE || "fairdatause_test";

  const conn = `postgresql://${user}:${password}@${host}:${port}/${db}`;

  process.env.DATABASE_URL = conn;
  process.env.TEST_DATABASE_URL = conn;

  console.log("📊 Database:", conn);

  try {
    execSync(`pg_isready -h ${host} -p ${port} -U ${user}`, {
      stdio: "inherit",
    });
  } catch (err) {
    console.error("❌ PostgreSQL not ready");
    throw err;
  }

  console.log("✅ PostgreSQL ready");
}

/**
 * Load schema from database-setup.sql
 */
export async function loadSchema(pool: Pool) {
  const schemaPath = path.join(__dirname, "database-setup.sql");

  if (!fs.existsSync(schemaPath)) {
    throw new Error("❌ Missing tests/database-setup.sql");
  }

  const sql = fs.readFileSync(schemaPath, "utf8");
  console.log("📦 Applying database schema...");

  await pool.query(sql);

  console.log("✅ Schema applied!");
}

export async function cleanupDatabaseEnvironment() {
  console.log("🧹 Skipping cleanup (CI uses ephemeral DB)");
}
