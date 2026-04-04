# Code Style

- Follow dominant language conventions (JS: camelCase, Python: snake_case, etc.)
- Forbidden: backward-compat hacks, alias re-exports, redundant naming, silently swallowed errors
- Delete all unused code, imports, variables, functions, files
- Single responsibility, keep it short, prefer pure functions
- Comments explain WHY, never WHAT
- Replace, don't deprecate — when changing something, replace it fully. Never create NewX alongside OldX.
- All errors must surface to the user with actionable context. Never catch-and-ignore.
- Clean up: remove temporary files, test databases, build artifacts before completing a task.
- Prefer immutability — create new objects, don't mutate existing ones
- Functions under 50 lines, files under 800 lines, nesting under 4 levels
- Validate input at system boundaries — never trust external data
