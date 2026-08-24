---
name: drift-check
description: Use when the user asks to "check drift", "run drift check", "verify sync", "check Tier 1", or "are the repos in sync". Runs the git preflight across every spoke in index.md's Local paths table, then checks source conformance across the three dormant geometry spokes against sync-registry.md.
version: 2.0.0
---

# Drift Check

Git preflight across every registered spoke (from `index.md` → Local paths), then a
source-conformance scan of the three geometry spokes.

## Steps

1. **Run the script** (git preflight first, then conformance)
   ```
   pwsh C:\Users\rplap\OneDrive\Desktop\steel\ops\drift-check.ps1
   ```

2. **Read the verdict line** (pass/fail is computed dynamically — there is no fixed total)
   - `all Tier 1 fields aligned (dormant spokes)` (exit 0) → no action needed
   - `UNVERIFIED` (exit 2) → a spoke is **behind origin or dirty**. The reading is not
     trustworthy. Name the spoke (from the preflight table), say they must pull/commit
     before a clean verdict is possible, and do **not** report a pass.
   - non-zero fail count (exit 1) → real drift; go to step 3

3. **For each FAIL** — find the canonical value in
   `C:\Users\rplap\OneDrive\Desktop\steel\wiki\module-facts.md`, name which other spokes
   in `sync-registry.md` share it, then ask: "Fix all failing spokes now, or note for later?"

## What it covers

Module display names, standards strings, iste-26 hash routes, the ISTE event name, and
**cross-referenced** deploy URLs (a repo's own URL is not checked — a site doesn't
hardcode its own origin), across `creative-lab`, `iste-26`, and `portfolio`.

## What it does not cover — say this when reporting a PASS

- **course-lab.** The one live product has no cross-repo surface and is deliberately
  outside the registry. A PASS is not a statement about it.
- **Vault-internal metadata** — spoke-card fields, `projects/` URLs, status labels.
  That is what actually drifted in July (PR #14) and no check sees it.
- **Triangle coordinates.** They used to ride in the `.hub` bundle; that pipeline was
  removed 2026-07-26 and coords are now registry-documented but not machine-checked.
- Tier 2 (narrative) and Tier 3 (intentionally different) — see `sync-registry.md`.

**Frame the result honestly.** All three checked repos are dormant by ruling
([[../../../wiki/decisions]] 2026-07-22). A green verdict is a regression tripwire on frozen
code — real, cheap, and not a signal about current work. Do not lead a briefing with it.
