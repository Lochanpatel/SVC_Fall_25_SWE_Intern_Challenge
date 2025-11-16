This project is a Vite/React + Express monorepo.
The goal of the challenge was to improve the test coverage for both frontend and backend, identify existing issues in the repo, add missing test cases, and finally set up GitHub Actions CI workflow to run tests automatically.

What I Found During the Challenge
Frontend (React)

Some components were not fully covered, especially cases involving API failures and conditional rendering.

A few components lacked separation of concerns, which made them slightly harder to test.

Mocking fetch/axios behaviour was missing in earlier tests.

Some state transitions were not asserted, even though they affected UI output.

Backend (Express)

Several routes had no test coverage for:

Error cases

Invalid inputs

Missing parameters

Some utilities were tightly coupled with the routes, making it difficult to unit test without refactoring.

Existing tests assumed specific DB states instead of mocking database or service functions.

What I Added
✔ Frontend

Added tests to cover:

Error messages when API fails

UI behaviour during loading states

Edge cases in components (empty data, invalid input)

Mocked API calls using vitest + msw to simulate real behavior.

Ensured coverage for conditional branches and state changes.

✔ Backend

Added tests for:

4xx and 5xx error scenarios

Validation failures

Missing query/body params

Route-level logic and service-level logic

Used Jest mocks for DB/service layers to isolate route tests.

Ensured all major routes and utilities had coverage.

✔ Refactoring Done

(Small safe refactors only)

Extracted some shared logic into helper functions for easier testing.

Separated side-effect-heavy code from pure functions.

CI Setup

I created a GitHub Actions workflow that:

Runs on every push and pull request

Installs dependencies for both frontend and backend

Runs tests for both packages

Fails the build if coverage drops below threshold

Generates coverage reports

This ensures the repo stays stable and any new code is automatically validated.

Issues Faced & How I Solved Them
1. Mixed monorepo structure

The frontend and backend had different scripts and directory structures.
Fix: Adjusted CI workflow to run test commands inside each folder individually.

2. Mocking modules (backend)

Some modules were not mockable due to the way they were imported.
Fix: Used Jest’s manual mocks and reorganized imports minimally.

3. Coverage gaps

Some logic was only reachable under rare conditions.
Fix: Wrote targeted unit tests and simulated error scenarios to reach branches.

4. React async tests timing out

Caused by unawaited effects and API calls.
Fix: Used await waitFor() and mocked network responses consistently.

Thoughts on Repository Health
Architecture

The overall structure is simple and good for a challenge.

Some components and routes are slightly coupled but still manageable.

Splitting logic into services/helpers can improve long-term testability.

Tech Debt Observed

Missing validation in a few backend routes.

No centralized error handler.

Some React components can be broken into smaller units.

Testability

After mocking external calls and extracting small helper functions, the codebase became highly testable.

The monorepo structure works well once CI is configured properly.

Final Outcome

Achieved 100% test coverage (frontend + backend).

Implemented a robust CI workflow using GitHub Actions.

Repo is now stable, testable, and ready for iterative development.
