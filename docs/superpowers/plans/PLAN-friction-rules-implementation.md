# PLAN-friction-rules-implementation

**Repo(s):** none (user-level file) + `steel` (hub docs)
**Source spec:** `steel/docs/superpowers/specs/2026-07-07-friction-rules-design.md` — read it first; this plan only sequences it.
**Status of source:** R1+R5 are ratified (memory `git-workflow-convention`, ratified 2026-07-09). R2+R4 carry spec status "Draft → awaiting review" — Step 3 is GATED on Randall's approval.
**Verified starting state (2026-07-11):** `~/.claude/CLAUDE.md` exists and is **0 bytes** (spec step 1 never executed). `steel/ops/claude.md` contains neither the "Git state is derived" subsection nor the "Documentation" section. `steel/sprint/2026-iste-40d.md` still contains hand-typed git state (e.g. line 28: "local master behind origin/master — needs `git pull`").

## Goal

Execute the three unimplemented steps of the friction-rules spec so no future session re-derives the git/doc conventions by being corrected.

## Steps (in order)

### Step 1 — Write `~/.claude/CLAUDE.md` (no repo, no branch, no gate)

Copy the fenced markdown block from the spec's "R1 + R5" section (spec lines 48–65) into `C:\Users\rplap\.claude\CLAUDE.md` verbatim, as the file's full content. The file is empty today; this is a create, not a merge.

**Edge case:** if the file is non-empty when you start, STOP and report — someone wrote it between audit and execution; do not overwrite.

### Step 2 — Steel branch for hub-doc edits

`steel` currently has 4 uncommitted changes unrelated to this plan (`.claude/skills/session-start/SKILL.md`, `docs/superpowers/plans/2026-05-30-hub-context-pipeline.md`, `ops/claude.md`, untracked `docs/superpowers/specs/2026-07-07-friction-rules-design.md`). Those are finished work awaiting commit — they belong to this same friction/founding-rules effort. On a new branch (e.g. `docs/friction-rules-landing`), commit them FIRST as their own commit(s), then apply Steps 3–4 as separate commits.

**Steel commit authorization:** the vault rule is "never commit in steel unless the user asks." Executing this plan on Randall's dispatch counts as the ask for THIS plan's files only.

### Step 3 — GATED: add R2 + R4 to `ops/claude.md`

Ask Randall one question before this step: "R2 (derived git state) and R4 (extend-don't-create) are still marked awaiting review in the spec — apply them?" If yes:

- Add the spec's "Git state is derived, never transcribed" block as a subsection under `## Git` in `ops/claude.md` (spec lines 79–86).
- Add the spec's `## Documentation` section (spec lines 98–106).

If no: skip Step 4 too (it implements R2's cleanup) and note both as declined in the PR description.

### Step 4 — Sprint-doc cleanup (depends on Step 3 = yes)

In `sprint/2026-iste-40d.md`, remove hand-typed git-state prose from the per-repo status sections (the "Branch:", "Blocker: local master behind origin" style lines) and add one pointer line: `Live git state: pwsh ops/repo-state.ps1`. Do NOT otherwise rewrite the sprint doc — its post-ISTE replacement is Randall's design decision, out of scope here.

### Step 5 — PR

Single PR on `steel` (`master` base), self-merge allowed. Title: `docs(ops): land friction rules + founding clauses`.

## Acceptance criteria (from the spec, verbatim where possible)

- `~/.claude/CLAUDE.md` exists with the superpowers worktree override as its first bold statement.
- (If Step 3 approved) `ops/claude.md` contains the derived-git-state rule and the Documentation section.
- (If Step 3 approved) `sprint/2026-iste-40d.md` contains no prose git state.
- `session-start/SKILL.md` step 0 (already-written, uncommitted) is committed unchanged — do not extend it; R3 was reviewed separately.
- Steel working tree is clean afterward except files other plans own.
