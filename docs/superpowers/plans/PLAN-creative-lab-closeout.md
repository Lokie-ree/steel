# PLAN-creative-lab-closeout

**Repo:** `creative-lab` (`C:/Users/rplap/OneDrive/Desktop/personal/creative-lab`)
**Source list:** `course-lab/docs/course-lab-founding-spec.md` §7 ("creative-lab closeout list") + audit findings 2026-07-11.
**Verified starting state (2026-07-11):** repo is checked out on LOCAL-ONLY branch `fix/skill-seam-hardening`, 1 commit (`d765790`, 2026-07-07) ahead of `main`, never pushed (no `origin/fix/skill-seam-hardening`). Working tree clean. Full test suite on this branch: 424/424 passing (verified today).

## Goal

Close out the stranded post-M3 hygiene items: land the skill-layer commit, delete the documented orphan, remove the vestigial field. Three ordered, single-concern PRs.

## PR 1 — land `fix/skill-seam-hardening`

The commit tracks `.claude/skills/` in git (a `.gitignore` exception) and applies seam fixes from the M3 pipeline audit — including repointing module-planning-pipeline's dead exemplar (`DilationsModulePlanning.tsx` does not exist in this repo) to `docs/modules/dilations/` artifacts.

1. `git push -u origin fix/skill-seam-hardening`
2. PR → `main`, self-merge allowed. Until this merges, every fresh-from-main session sees NO tracked skills — this PR unblocks the skills-drift work, so it goes first.

## PR 2 — delete orphaned `scene/math.ts`

`src/components/modules/rigid-motions/scene/math.ts` exports `snapToGrid`, imported nowhere. `rigid-motions/ARCHITECTURE.md` (the "Orphaned file" callout after the File Structure tree, ~line 71) documents it as safe to delete — the design settled on free-drag, not snap.

1. Branch `chore/delete-orphaned-scene-math` from updated `main`.
2. Confirm zero imports: search `from './math'`, `from '../scene/math'`, `snapToGrid` across `src/` — expect hits only in the file itself (and possibly the ARCHITECTURE.md callout).
3. Delete the file AND remove the now-false "Orphaned file" callout from ARCHITECTURE.md in the same commit (the doc note exists only to describe the orphan).
4. `pnpm build` and `pnpm vitest run` green (424 tests). PR, self-merge.

## PR 3 — remove vestigial `color` field

`CLAUDE.md` "Vestigial `color` field in `courses.ts`" (lines ~227–228): CS course still carries `color: '#a855f7'` (off-palette purple), no longer used in rendering.

1. Branch `chore/remove-vestigial-course-color`.
2. Find `courses.ts` (src/config/). Confirm the `color` field is read nowhere (`grep -rn "\.color" src/` filtered to Course usages). If ANY live read exists, stop and report instead of deleting.
3. Remove the field from the `Course` type and all course entries; update the CLAUDE.md "Vestigial" paragraph (delete it — it describes work now done).
4. `pnpm build` + tests green. PR, self-merge.

## Explicitly NOT in this plan

- The steel-side closeout items from the same §7 list (triangle ruling → `wiki/decisions.md`, sprint-log duplicate rows) — see PLAN-steel-hub-hygiene.
- "Sibling-skill repointing" (iste-26's divergent module-planning-pipeline copy) — design decision, see the audit report; do not touch iste-26.
- RM-04 / PED-01 — separate plan (PLAN-rigid-motions-rm04-ped01).
- Anything from CLAUDE.md "Feature ideas" or the performance audit — out of scope.

## Acceptance criteria

- `main` contains all three merges; local branch list has no unmerged work; working tree clean on `main`.
- `.claude/skills/` visible in `git ls-files` on main.
- `scene/math.ts` gone; no ARCHITECTURE.md reference to it; 424/424 tests still green.
- No `color:` field on Course entries; build green.
