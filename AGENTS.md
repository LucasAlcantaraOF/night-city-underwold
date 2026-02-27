# Agent Guide (NCU)

This repository is a Cyberpunk 2077 mod using:
- Lua via Cyber Engine Tweaks (CET)
- RedScript for engine hooks
- Optional Phone Extension Framework integration

If you are an agent making changes, follow this guide.

## Repository Layout
- `bin/x64/plugins/cyber_engine_tweaks/mods/NCU/` Lua entry point and modules
- `r6/scripts/NCU/` RedScript hooks and integrations
- `docs/` contributor documentation (install steps, player instructions)
- `archive/pc/mod/` (future) packed assets, not present yet

## Build / Lint / Test Commands
No automated build, lint, or test commands are defined in this repo.
There is no `package.json`, `pyproject.toml`, `go.mod`, etc.

Use manual validation:
- Launch Cyberpunk 2077 with CET installed
- Open the CET console and look for NCU init logs
- Verify that contacts or notifications appear as expected

### Single Test Equivalent (Manual)
There is no unit test framework.
To verify a single behavior:
1. Edit the specific Lua or RedScript behavior
2. Launch the game and load a save
3. Trigger the behavior in-game (or via phone UI)
4. Confirm logs in CET console

If you add a build or test system, update this file.

## Code Style Guidelines

### General
- Keep file paths aligned with the Cyberpunk 2077 mod layout.
- Preserve existing Portuguese strings and tone; avoid rewriting dialog text.
- Prefer small modules in Lua under `modules/` and a single entry in `init.lua`.
- Avoid introducing new dependencies without updating docs.
- Keep runtime behavior deterministic; avoid random output in intro flows.
- Prefer additive changes over heavy refactors unless requested.

### Lua (CET)
- Use `NCU` as the top-level namespace table.
- Use `:` for methods that operate on a table instance.
- Keep indentation consistent with existing files (4 spaces).
- Table keys:
  - snake_case for data objects (example: `car_fixer`)
  - camelCase for local variables (example: `modulesToLoad`)
- Functions:
  - PascalCase for core methods on `NCU` (example: `LoadDatabase`)
  - camelCase for local helpers in modules (example: `SendInGameNotification`)
- Logging:
  - Prefix with `[NCU]` or `[NCU:ModuleName]`.
  - Use `print()` for CET console output.
- Module pattern:
  - Export a table and return it at the end of the file.
  - Provide `init(ncuCore)` when the module needs startup work.
  - Guard `ncuCore` access when it can be nil.
- Error handling:
  - Use `pcall` around calls that can fail due to missing systems.
  - Return boolean success where appropriate.
- Data persistence:
  - `database.json` is loaded and saved via `NCU:LoadDatabase()`.
  - Only write when data is a table and encoding succeeds.
  - Keep the relative path `data/database.json` stable.
  - Avoid writing from high-frequency callbacks (onDraw, per-frame).

### RedScript
- Keep module declarations consistent (example: `module NCU.Phone`).
- Use `PascalCase` for classes and `camelCase` for local variables.
- Keep method signatures concise and explicit.
- Use persistent fields only for data that must survive save/load.
- Use `IsDefined()` checks before using references from systems.
- Follow existing wrapping patterns:
  - `@wrapMethod(NewHudPhoneGameController)`
  - `@addField(NewHudPhoneGameController)`
- Avoid renaming persistent fields once shipped; it breaks save state.
- Keep contact hashes stable; changing them breaks phone history.
- Call Phone Extension APIs only when the system instance is defined.

### Imports
- Only import what you use.
- Keep RedScript imports grouped at the top of the file.
- Avoid circular Lua `require` calls between modules.
- Do not introduce wildcard-style imports in RedScript.

### Naming and Structure
- Contact data:
  - Unique hashes for each contact (avoid collisions).
  - Contact IDs and avatars should be stable.
- Keep UI strings short for preview snippets.
- Keep mission and reputation logic isolated to their module.
- Use descriptive module names (example: `contacts`, `missions`).
- Keep new systems in their own module file; avoid giant monolith files.

### Formatting
- Prefer single responsibility functions.
- Keep lines reasonably short for readability in CET console.
- Avoid trailing whitespace.
- Use blank lines to separate logical sections.
- Keep RedScript braces and semicolons consistent with existing files.

### Error Handling and Fallbacks
- Provide a fallback when optional frameworks are missing.
- Example: Phone Extension missing should fall back to CET console or HUD notification.
- Make errors descriptive but not spammy.
- Use `pcall` in Lua when calling engine APIs that can be nil.
- Avoid throwing errors during `onInit`; log and continue when possible.

### Localization and Tone
- Keep Portuguese and slang as-is; do not sanitize dialog without request.
- Preserve emojis or special symbols already present in strings.
- If you add new strings, match the existing tone and voice.

### Data Files
- Store mod data under `bin/x64/plugins/cyber_engine_tweaks/mods/NCU/data/`.
- Keep JSON small and structured; avoid deeply nested arrays unless needed.
- Update both load and save logic if the schema changes.

### Runtime Integration
- CET entry point is `init.lua`; keep it lightweight and stable.
- Register new modules in the `modulesToLoad` list.
- RedScript hooks should be minimal and focused on engine integration.
- Phone Extension is optional; always provide a safe fallback path.

## Cursor / Copilot Rules
No Cursor rules found in `.cursor/rules/` or `.cursorrules`.
No Copilot rules found in `.github/copilot-instructions.md`.

## Suggested Manual Validation Checklist
Use this when you touch core behavior:
- Game starts without CET errors
- `[NCU]` init logs appear in CET console
- `database.json` loads and saves without error
- Phone notifications appear if Phone Extension is installed
- Fallback notifications appear if Phone Extension is missing

## Notes for Agents
- Do not remove existing dialog or tone without explicit request.
- Avoid heavy refactors unless asked.
- Keep save persistence stable (do not rename persistent fields).
- If you add a new module, register it in `init.lua`.
- If you add new assets, update `docs/INSTALAÇÃO.md`.
