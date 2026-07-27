# Ops

Vault-wide system configuration.

| Doc | Purpose |
|-----|---------|
| [[claude]] | Agent rules when steel is in the workspace |
| `repo-state.ps1` | Live git state for every registered spoke — the derived-not-transcribed source |
| `drift-check.ps1` | Conformance check across the three dormant geometry spokes (preflight + source match) |
| `lib/HubContext.psm1` | Pure parse/compare functions behind both scripts (Pester-tested in `tests/`) |

## Skills (`.claude/skills/`)

| Skill | Trigger |
|-------|---------|
| `session-start` | "start session", "brief me", "where did we leave off" |
| `drift-check` | "check drift", "verify sync", "are the repos in sync" |

Spoke-specific agent rules live in each repo's `CLAUDE.md`, not here.

## Removed 2026-07-26

`build-context.ps1`, the `.hub/` bundle format, its `build-context` skill, and
drift-check's Stage 1. The pipeline generated grade-8-geometry facts into six repos —
two of which have no geometry — and **never ran in a single spoke**: every drift check
since it was written reported `SKIP (.hub not installed)` six times out of six. It was
built for a fan-out that ended with the conference. Git history holds it if a real
fan-out ever reappears.
