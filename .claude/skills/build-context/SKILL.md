---
name: build-context
description: Use when the user says "regenerate the bundle", "rebuild .hub", "push facts to repos", "update the spoke context", or after editing wiki/module-facts.md. Regenerates each spoke's .hub/ bundle from the canonical vault facts.
version: 1.0.0
---

# Build Context

Regenerates the `.hub/` bundle (`module-facts.json` + `context.md`) in every spoke from the canonical `wiki/module-facts.md`. One direction only: vault → repos. Never edits repo code; never commits inside spokes.

## Steps

1. **Run the generator**
   ```
   pwsh C:\Users\rplap\OneDrive\Desktop\steel\ops\build-context.ps1
   ```

2. **If it stops at the preflight** (`Some spokes are behind/dirty`)
   - Name which spokes (from the preflight table) are behind origin or dirty
   - Ask the user to pull/commit those first, or to re-run with `-Force` if they accept writing onto the current state
   - Do not pass `-Force` yourself without the user's say-so

3. **After it writes**
   - For each spoke, show `git -C <spoke path> diff --stat .hub` so the user sees what changed
   - Remind the user to commit `.hub/` **inside each spoke repo** (on that repo's branch, per its own CLAUDE.md git workflow) — the generator deliberately does not commit for them

## Rules

- Never hand-edit `.hub/` — it is generated. To change values, edit `wiki/module-facts.md` and regenerate.
- Output is deterministic: re-running without a facts change produces no diff (except the generated-on date).
- After regenerating, run `ops/drift-check.ps1` — Stage 1 should report every installed spoke's bundle as current.
