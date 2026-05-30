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
- **drift-check** — runs `ops/drift-check.ps1` and surfaces any Tier 1 mismatches with fix guidance

Invoke via the Skill tool or by name in conversation.

## Git

- Never commit in `steel` unless the user asks
- Spoke repos: follow each repo's `CLAUDE.md` git workflow (feature branches, no direct commits to main/master)
