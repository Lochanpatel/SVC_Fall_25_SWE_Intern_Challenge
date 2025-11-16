import { execSync } from "child_process";

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

export async function cleanupDatabaseEnvironment() {
  console.log("🧹 Skipping cleanup (CI uses ephemeral DB)");
}
