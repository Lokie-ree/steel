# Ops

Vault-wide system configuration.

| Doc | Purpose |
|-----|---------|
| [[claude]] | Agent rules when steel is in the workspace |
| `drift-check.ps1` | Tier 1 sync scanner — run before any ISTE deploy |

## Skills (`.claude/skills/`)

| Skill | Trigger |
|-------|---------|
| `session-start` | "start session", "brief me", "where did we leave off" |
| `drift-check` | "check drift", "verify sync", "are the repos in sync" |

Spoke-specific agent rules live in each repo's `CLAUDE.md`, not here.
