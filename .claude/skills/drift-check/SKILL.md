---
name: drift-check
description: Use when the user asks to "check drift", "run drift check", "verify sync", "check Tier 1", "are the repos in sync", or before any ISTE deploy. Scans all four spoke repos for Tier 1 field alignment against sync-registry.md.
version: 1.0.0
---

# Drift Check

Runs the Tier 1 scan across all four spoke repos and surfaces any mismatches.

## Steps

1. **Run the script**
   ```
   pwsh C:\Users\rplap\OneDrive\Desktop\steel\ops\drift-check.ps1
   ```

2. **If all 27 checks pass**
   - Output: `Drift check: 27/27 passing — all Tier 1 fields aligned.`
   - No further action needed

3. **If any check fails**
   - List each failing check with its file path and expected pattern
   - For each failure, identify the canonical value from `C:\Users\rplap\OneDrive\Desktop\steel\wiki\module-facts.md`
   - State which other spokes in `sync-registry.md` also need the same fix
   - Ask the user: "Fix all failing spokes now, or note for later?"

## Scope

This script covers Tier 1 only (user-facing fields that must be identical):
- Module display names across creative-lab, iste-26, portfolio
- Standards strings in iste-26 and portfolio
- ISTE event string in all three lab guides
- Deploy URLs and hash route hrefs in iste-26 and portfolio
- Hash route definitions in iste-26 App.tsx

Tier 2 (narrative copy) and Tier 3 (intentionally different) are out of scope.
See `C:\Users\rplap\OneDrive\Desktop\steel\sync-registry.md` for the full tier breakdown.
