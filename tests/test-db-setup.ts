// tests/test-db-setup.ts
import { execSync } from "child_process";

export async function ensureDatabaseEnvironment() {
  console.log("🔧 Using CI PostgreSQL service. Skipping auto-install.");

  // Environment variables from GitHub Actions service
  const host = process.env.PGHOST || "localhost";
  const port = process.env.PGPORT || "5432";
  const user = process.env.PGUSER || "test";
  const password = process.env.PGPASSWORD || "test";
  const db = process.env.PGDATABASE || "fairdatause_test";

  // Build connection URL
  const connectionString = `postgresql://${user}:${password}@${host}:${port}/${db}`;

  process.env.DATABASE_URL = connectionString;
  process.env.TEST_DATABASE_URL = connectionString;

  console.log("📊 Test database:", connectionString);

  try {
    execSync(`pg_isready -h ${host} -p ${port} -U ${user}`, {
      stdio: "inherit",
    });
  } catch (e) {
    console.error("❌ PostgreSQL is not ready.");
    throw e;
  }

  console.log("✅ PostgreSQL is ready.");
}

export async function cleanupDatabaseEnvironment() {
  console.log("🧹 Skipping cleanup — CI database is ephemeral.");
}
