---
name: session-start
description: Use at the start of any work session in this vault or any spoke repo. Activates when the user says "start session", "session start", "what's the status", "brief me", "where did we leave off", or opens a new work session. Surfaces today's sprint priorities and runs the Tier 1 drift check.
version: 1.0.0
---

# Session Start

Orients every session from the shared hub state. Run before touching any spoke repo.

## Steps

0. **Anchor the spoke** — if today's focus is a spoke repo, add its directory to the session workspace (`/add-dir C:/Users/rplap/OneDrive/Desktop/personal/<spoke>`) before any other command. Paths: `index.md` → Local paths. Skipping this costs a `cd` on every shell call and blinds file search to the spoke.

1. **Read sprint status**
   - Read `C:\Users\rplap\OneDrive\Desktop\steel\sprint\2026-iste-40d.md`
   - Extract: priority stack, per-repo status, blockers, and "this week's suggested focus"

2. **Check live repo state + drift**
   - Execute: `pwsh C:\Users\rplap\OneDrive\Desktop\steel\ops\drift-check.ps1` (runs the git preflight first, then both drift stages)
   - From the preflight table, note each spoke's branch / ahead / behind / dirty (this is **live** state — trust it over the hand-typed sprint status)
   - Note the dynamic pass/fail counts and the verdict line

3. **Output briefing** — exactly this format, no more:

```
SESSION BRIEF — <today's date>
Days to ISTE: <days remaining until 2026-06-28>

PRIORITY STACK
  P1 iste-26     <one-line status from sprint doc>
  P2 portfolio   <one-line status from sprint doc>
  P3 creative-lab  <one-line status from sprint doc>
  P4 creative-lab-demos  <one-line status from sprint doc>
  P5 course-lab  <one-line status from sprint doc, or "not in sprint doc yet" if absent>

GIT    <repo:branch ±ahead/behind dirty?> for any spoke needing attention, else "all clean & current"
DRIFT  <pass> pass / <fail> fail  <"— all clear" if 0 fail and verdict is a pass; if UNVERIFIED, say so and name the behind/dirty spoke; else list each FAIL>

FOCUS TODAY
  <copy "This week's suggested focus" items verbatim, numbered>
```

4. **Update the session log** in `sprint/2026-iste-40d.md`
   - Add a row to the Session log table: `| <date> | <repo or "steel"> | Session started |`
   - Only add the row — do not change anything else in the sprint doc

## Notes

- If drift check has failures, flag them before the Focus section and do not proceed to spoke work until the user acknowledges
- Days to ISTE: subtract today's date from 2026-06-28
- Do not summarize or paraphrase sprint content — copy status lines verbatim
