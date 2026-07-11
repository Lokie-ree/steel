# Friction Rules Codification — Design

**Date:** 2026-07-07
**Operator:** Randall LaPoint, Jr. (solo)
**Status:** Draft → awaiting review
**Source:** Session-transcript friction audit, 2026-07-07 (see Corpus below)

---

## Problem

A transcript audit of 26+ analyzed sessions (2026-04-29 → 2026-05-30) clustered every manual correction into friction categories. Five clusters traced to ≥2 real incidents. Four of the five rules are codified by this spec; the fifth (session-start tooling preflight) is deliberately held for its own review. Every rule below exists because the convention it states was corrected by hand at least twice — each correction a pipeline leak.

## Corpus & caveat

Evidence: raw transcripts of the vault-pipeline sessions (`abdadbf3`, `e8a8896b`, `3e1d281d`) plus two `/insights` datasets (reports of 2026-05-28 and 2026-06-14, overlapping windows — identically-worded examples counted as one incident).

> **⚠ The entire corpus predates course-lab.** These rules harden the old 4-spoke workflow (creative-lab, creative-lab-demos, iste-26, portfolio). The course-lab migration has produced zero transcript evidence and needs its own audit once it has session history.

## Goal

Codify four rules at the correct altitude so no future session has to be manually corrected for a violation:

| Rule | Destination | Why that altitude |
|------|-------------|-------------------|
| R1 — Git workflow (incl. superpowers override) | **User-level** `~/.claude/CLAUDE.md` | Applies to every repo including course-lab and future spokes; loaded in every session regardless of workspace; survives spoke CLAUDE.md drift |
| R5 — Branch-first checkpointing | Same user-level block as R1 | It is a git-workflow behavior; belongs with the convention it extends |
| R2 — No hand-transcribed git state | `ops/claude.md` (hub agent rules) | The stale-state failure lives in vault docs (sprint doc, session logs) |
| R4 — Extend-don't-create docs | `ops/claude.md` (hub agent rules) | Doc-generation decisions are coordinated from the hub |

## Non-goals

- **R3 (session-start tooling preflight) — held.** It modifies an executable skill and deserves its own spec and review. Nothing in this spec touches `session-start/SKILL.md`.
- Propagating git rules via the `.hub/context.md` template. Deferred until the course-lab migration is reviewed — the pipeline's spoke rollout is itself still pending, and R1 at user level already covers every session.
- Permission allowlist (`.claude/settings.json`) and any scope-drift rule — both below the 2-incident evidence bar (SPECULATIVE in the audit).
- Any change to `drift-check.ps1`, `repo-state.ps1`, `build-context.ps1`, or `HubContext.psm1`.

---

## R1 + R5 — User-level `~/.claude/CLAUDE.md`

**Evidence:** (a) direct push to master, corrected to GH PR flow; (b) all commits bundled on one branch, corrected to ordered PRs; (c) unwanted git worktree whose stash dropped the `DilationsModulePlanning` view from `App.tsx`; (d) a 500 error and a usage limit each erased a session's uncommitted work.

**Root cause:** The user's convention was unwritten at any level Claude always loads, while superpowers execution skills carry an *opposing written default* (`subagent-driven-development` marks `using-git-worktrees` as REQUIRED). Where the user's rules are silent, the loudest written instruction wins. Separately, treating branch-and-commit as the *shipping* step meant interruptions reverted sessions to zero.

**The file** (`~/.claude/CLAUDE.md` is currently empty; this becomes its full content):

```markdown
# Git Workflow — applies to every repo

**These rules OVERRIDE any skill's git defaults — including superpowers
skills that mark git worktrees as REQUIRED. Never create a git worktree;
execute plans on an in-place feature branch.**

- Feature-branch only. Never commit to or push master/main directly.
- One concern per PR. Ship related concerns as separate, ordered PRs
  (feature work first, polish after).
- Branch-first: create the feature branch before the first edit.
- Checkpoint commits: commit at every verified step (tests green, task
  complete) — never batch commits for the end of the session. An
  interrupted session must lose at most one step.

A repo's own CLAUDE.md may tighten these rules (e.g., the steel vault
forbids committing unless asked); the tighter rule wins.
```

**Design notes:**
- The superpowers override is the headline (first bold paragraph) because the worktree incident is the only cluster where a *written* instruction actively opposed the user — silence isn't enough; the override must outrank the skill's REQUIRED.
- The final precedence line resolves the one real conflict: steel's "never commit unless the user asks" would otherwise collide with branch-first/checkpoint commits. Tighter-rule-wins keeps the vault's discipline intact.

## R2 — No hand-transcribed git state (`ops/claude.md`)

**Evidence:** (a) sprint doc presented P1/P2 blockers as open; both were already merged on GitHub ("Both are already taken care of through github"). (b) Sprint doc's hand-typed "iste-26 local master behind origin" was disproven by the first live `repo-state.ps1` run — the repo was dirty, not behind.

**Root cause:** Git state transcribed into markdown is stale at read time by construction. The tooling fix already shipped (`repo-state.ps1`, commits `4b97de9`/`45bc39e`); this rule prevents the *authoring* regression.

**Addition to `ops/claude.md`** (new subsection under `## Git`):

```markdown
### Git state is derived, never transcribed

Never write git state (branch, ahead/behind, dirty, "needs pull") into
the sprint doc, session logs, or project cards as prose. State those
facts only as output of `ops/repo-state.ps1`, run at read time. If a doc
contains hand-typed git state, treat it as unverified and re-derive.
```

**One-time cleanup:** strip the existing hand-typed git-state lines from `sprint/2026-iste-40d.md` per-repo status sections (e.g., iste-26's "Blocker: local master behind origin — needs `git pull`") and replace with a single pointer: "Live git state: `pwsh ops/repo-state.ps1`."

## R4 — Extend, don't create (`ops/claude.md`)

**Evidence:** Two documentation sessions (per both insights reports independently) where the correct outcome was declining to write module guides that duplicated ARCHITECTURE.md and the iste-26 guides — rated very helpful despite "not achieved."

**Root cause:** No standing rule makes the duplication audit anyone's job; each session re-derives the conclusion, and the good outcome depends on the model volunteering pushback rather than complying.

**Addition to `ops/claude.md`** (new section):

```markdown
## Documentation

Extend, don't create. Before generating any new doc or guide, audit
ARCHITECTURE.md, the iste-26 guides, and the vault wiki for overlap. If
existing coverage is even partial, extend the existing file or recommend
deferral. A new file must state, in one sentence, the gap no existing
doc covers.
```

---

## Implementation steps

1. Write `~/.claude/CLAUDE.md` with the R1+R5 block (file is empty today; this is a create, not a merge).
2. Add the R2 subsection and R4 section to `ops/claude.md`.
3. Cleanup pass on `sprint/2026-iste-40d.md`: remove hand-typed git-state lines, add the repo-state pointer.
4. No commits in steel without explicit ask (existing vault rule). The user-level file is outside any repo.

## Acceptance criteria

- `~/.claude/CLAUDE.md` exists with the superpowers override as its first bold statement.
- `ops/claude.md` contains the derived-git-state rule and the Documentation section.
- `sprint/2026-iste-40d.md` contains no prose git state.
- `session-start/SKILL.md` is untouched (R3 held).
- Every rule in this spec traces to ≥2 incidents in the 2026-07-07 audit; nothing speculative was codified.
