# PLAN-portfolio-m3-standards-landing

**Repo:** `portfolio` (`C:/Users/rplap/OneDrive/Desktop/personal/portfolio`)
**Verified starting state (2026-07-11):** working tree has ONE uncommitted modified file, `src/App.tsx`, sitting directly on `master` (violates branch-first). The diff contains two independent changes:

1. **M3 standards string** on the Pythagorean Theorem `ModuleCard`: `8.G.B.7–8` → `8.G.B.6–8`. This is a Tier 1 sync field, and the change is a drift FIX: canonical `steel/wiki/module-facts.md` line 18 says M3 = `8.G.B.6–8`, and iste-26's guide already shows B.6/B.7/B.8 badges (`src/components/lab-guides/PythagoreanTheorem.tsx:23`). Portfolio was the last surface behind canon.
2. **M2 Dilations card description** extended with a sentence about order/non-commutativity. This is Tier 2 narrative (manual review, not auto-sync).

## Goal

Land the stranded fix per git convention — feature branch, one concern per PR, ordered — without losing either change.

## Steps

1. From `master` (do NOT discard the working-tree change), create branch `fix/m3-standards-tier1`.
2. Stage ONLY the standards hunk: `git add -p src/App.tsx` — take the hunk changing `8.G.B.7–8` to `8.G.B.6–8`, leave the description hunk unstaged. Commit: `fix: M3 standards string to canonical 8.G.B.6–8 (Tier 1 sync)`.
3. PR #1 → master, body cites `steel/wiki/module-facts.md` as canon. Self-merge allowed.
4. Create branch `docs/dilations-card-copy` from updated master; commit the remaining description hunk: `docs: extend Dilations card description (order matters)`. PR #2 body must flag: "Tier 2 narrative change, uncommitted provenance unknown — Randall glance requested before merge." Do not self-merge PR #2 without that glance.
5. After PR #1 merges and Vercel deploys, verify live: `randalllapointjr.dev` Pythagorean card shows `8.G.B.6–8`.
6. Cross-check the other Tier 1 surfaces did not regress: iste-26 guide badges (B.6, B.7, B.8) and `steel/wiki/module-facts.md:18` unchanged. (creative-lab's `src/config/modules.ts` carries no standards strings — nothing to sync there; standards live in its ARCHITECTURE docs, which correctly state 8.G.B.7–8 as the *implemented* standards with B.6 covered via visual proof. That wording difference is documented intent, not drift — see `steel/iste-alignment-findings.md` Section 1.)

## Edge cases

- If `git add -p` splits the hunks awkwardly (they're ~8 lines apart, should split cleanly), use `git add -e` on the file.
- If the live site already shows B.6–8 before you start, someone landed this differently — stop and re-derive state with `git log`/`git status` before acting.
- The sync-registry rule ("update every spoke in the same session") is satisfied by verification here, not edits — the other spokes are already at canon.

## Acceptance criteria

- `portfolio` working tree clean; `master` contains both changes via two merged, ordered PRs.
- Live portfolio card reads `8.G.B.6–8 · Grade 8 Geometry`.
- `pwsh steel/ops/drift-check.ps1` Stage 2 reports no M3-standards mismatch for portfolio (Stage 1 will SKIP with ".hub not installed" — expected, not a failure).
