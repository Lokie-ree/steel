# Steel — Vault Agent Rules

Instructions for AI agents when `steel` is in the workspace (Obsidian or Cursor multi-root).

## Role

`steel` is the **hub**. Repos under `personal/` are **spokes**. Do not implement product code in `steel` unless explicitly asked to edit hub docs.

## Session protocol

1. Read `index.md` at vault root
2. Read `sprint/2026-iste-40d.md` for current priorities
3. If the task touches cross-repo facts, read `sync-registry.md` and `wiki/module-facts.md`
4. Switch context to the correct spoke repo before editing TS/TSX/CSS

## Research boundary

These files are **research-only** — useful for ISTE conversations, not for driving code changes:

- `iste-narrative.md`
- `iste-alignment-findings.md`

Do not copy research prose into repo READMEs or user-facing copy without explicit user approval.

## Dual-pane workflow

- **Obsidian:** planning, sprint updates, sync-registry maintenance, session notes
- **Cursor:** implementation in the active spoke repo (`CLAUDE.md` in that repo is the implementation contract)

When both are open, hub docs win for *what to work on*; spoke `CLAUDE.md` wins for *how to implement*.

## Navigation (index highway)

Before reading many files, check folder `index.md` files:

- `projects/index.md` — spoke cards
- `wiki/` — distilled facts (not full architecture copies)

Do not recursively list the vault. Snake through indices.

## Drift policy (through ISTE)

- **Do not** propose monorepos, shared npm packages, or token unification unless the user asks
- **Do** flag when an edit changes a field in `sync-registry.md`
- **Do** list which other spokes need the same change

## Skills

Two skills live in `.claude/skills/` and are available in any Claude Code session with `steel` in the workspace:

- **session-start** — reads sprint status, runs drift check, outputs a structured briefing, logs the session
- **drift-check** — runs `ops/drift-check.ps1`: git preflight, then Stage 1 (bundle freshness) + Stage 2 (code conformance), with fix guidance
- **build-context** — runs `ops/build-context.ps1` to regenerate each spoke's `.hub/` bundle from `wiki/module-facts.md` (vault → repos, one direction)

Invoke via the Skill tool or by name in conversation.

The pipeline: `wiki/module-facts.md` is canonical → `build-context` generates `<spoke>/.hub/module-facts.json` (code imports it) + `.hub/context.md` (agent reads it) → `drift-check` validates every spoke against that one artifact. Pure logic lives in `ops/lib/HubContext.psm1` (Pester-tested in `ops/tests/`). Never hand-edit `.hub/`.

## Git

- Never commit in `steel` unless the user asks
- Spoke repos: follow each repo's `CLAUDE.md` git workflow (feature branches, no direct commits to main/master)
- **Founding a new repo** (ratified 2026-07-09, from the course-lab init):
  - Default branch is `main` (steel stays `master`; do not retrofit existing repos)
  - The bootstrap root commit — README, `.gitignore`, `.gitattributes`, docs only — may land on `main`. This is the one named exception to feature-branch-only; everything after it lands via ordered single-concern PRs
  - Root commit includes `.gitattributes` with `* text=auto` (kills LF/CRLF warning noise and phantom diffs on Windows)
  - Solo PRs are self-merged, with a merge commit titled `Merge: …`
  - New repos start **private**; public is a deliberate later choice

### Git state is derived, never transcribed

Never write git state (branch, ahead/behind, dirty, "needs pull") into
the sprint doc, session logs, or project cards as prose. State those
facts only as output of `ops/repo-state.ps1`, run at read time. If a doc
contains hand-typed git state, treat it as unverified and re-derive.

## Documentation

Extend, don't create. Before generating any new doc or guide, audit
ARCHITECTURE.md, the iste-26 guides, and the vault wiki for overlap. If
existing coverage is even partial, extend the existing file or recommend
deferral. A new file must state, in one sentence, the gap no existing
doc covers.

> **Audit note (2026-07-07):** the friction-rule audit (`docs/superpowers/specs/2026-07-07-friction-rules-design.md`) used transcripts that all predate course-lab — it hardened the old 4-spoke workflow; the course-lab migration still needs its own review.
