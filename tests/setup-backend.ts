import { beforeAll, afterAll, beforeEach, afterEach } from "vitest";
import { Pool } from "pg";
import { setupServer } from "msw/node";
import { http, HttpResponse } from "msw";

import {
  ensureDatabaseEnvironment,
  cleanupDatabaseEnvironment,
} from "./test-db-setup";

let pool: Pool | null = null;

export const mockServer = setupServer(
  http.post("https://www.reddit.com/api/v1/access_token", () => {
    return HttpResponse.json({
      access_token: "mock_token",
      expires_in: 3600,
      token_type: "bearer",
    });
  }),

  http.get("https://oauth.reddit.com/user/:username/about", ({ params }) => {
    const good = ["testuser", "validuser", "reddituser", "austrie"];
    if (good.includes(params.username as string)) {
      return HttpResponse.json({
        kind: "t2",
        data: { name: params.username },
      });
    }
    return new HttpResponse(null, { status: 404 });
  })
);

beforeAll(async () => {
  console.log("🚀 Setting up backend tests...");
  await ensureDatabaseEnvironment();

  pool = new Pool({
    connectionString: process.env.TEST_DATABASE_URL,
  });

  mockServer.listen({ onUnhandledRequest: "bypass" });

  process.env.NODE_ENV = "test";
  process.env.PING_MESSAGE = "test ping";
  console.log("✅ Backend tests ready");
});

afterAll(async () => {
  mockServer.close();
  if (pool) await pool.end();
  await cleanupDatabaseEnvironment();
  console.log("🧹 Backend cleaned");
});

beforeEach(() => mockServer.resetHandlers());

afterEach(async () => {
  if (!pool) return;
  try {
    await pool.query("DELETE FROM contractors");
    await pool.query("DELETE FROM users");
  } catch (e) {
    console.log("⚠ Error cleaning test data:", e);
  }
});
