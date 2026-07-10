---
name: drift-check
description: Use when the user asks to "check drift", "run drift check", "verify sync", "check Tier 1", "are the repos in sync", or before any ISTE deploy. Scans every spoke registered in index.md's Local paths table for Tier 1 field alignment against sync-registry.md.
version: 1.0.0
---

# Drift Check

Runs the Tier 1 scan across every registered spoke (from `index.md` → Local paths; git preflight covers all five, Stage 2 conformance targets the three curriculum spokes) and surfaces any mismatches.

## Steps

1. **Run the script** (it runs the git preflight first, then two stages)
   ```
   pwsh C:\Users\rplap\OneDrive\Desktop\steel\ops\drift-check.ps1
   ```

2. **Read the verdict line** (the script computes pass/fail dynamically — there is no fixed total)
   - `all Tier 1 fields aligned` (exit 0) → no action needed
   - `UNVERIFIED` (exit 2) → a spoke is **behind origin or dirty**. The reading is not trustworthy. Tell the user which spoke (from the preflight table) and that they must pull/commit before a clean verdict is possible. Do not report a pass.
   - non-zero fail count (exit 1) → real drift; go to step 3

3. **For each FAIL**
   - **Stage 1 (bundle freshness):** the spoke's `.hub/module-facts.json` is stale → run `ops/build-context.ps1` and commit the regenerated `.hub/` in that spoke
   - **Stage 2 (code conformance):** identify the canonical value from `C:\Users\rplap\OneDrive\Desktop\steel\wiki\module-facts.md`, state which other spokes in `sync-registry.md` share it, then ask: "Fix all failing spokes now, or note for later?"

## What the two stages cover

- **Stage 1 — freshness:** each spoke's `.hub/module-facts.json` hash matches the vault's canonical `wiki/module-facts.md` (detects "forgot to regenerate the bundle").
- **Stage 2 — conformance:** module display names, standards strings, iste-26 hash routes, the ISTE event name, and **cross-referenced** deploy URLs (a repo's own URL is not checked — a site doesn't hardcode its own origin).

Triangle coordinates are carried in the `.hub` bundle (covered by Stage 1), not substring-matched in source. Tier 2 (narrative) and Tier 3 (intentionally different) are out of scope — see `sync-registry.md`.
