---
name: session-start
description: Use at the start of any work session in this vault or any spoke repo. Activates when the user says "start session", "session start", "what's the status", "brief me", or opens a new work session. Surfaces the current sprint's priorities and runs the Tier 1 drift check. If the user is resuming prior intent ("where did we leave off", "let's continue"), the global handoff skill leads and invokes this one for hub status — this skill reads sprint state, not handoff notes.
version: 1.1.0
---

# Session Start

Orients every session from the shared hub state. Run before touching any spoke repo.

## Steps

0. **Anchor the spoke** — if today's focus is a spoke repo, add its directory to the session workspace (`/add-dir C:/Users/rplap/OneDrive/Desktop/personal/<spoke>`) before any other command. Paths: `index.md` → Local paths. Skipping this costs a `cd` on every shell call and blinds file search to the spoke.

1. **Resolve the current sprint** — read `sprint/index.md` and open the sprint doc it lists as current. Never hardcode a sprint filename; sprints rotate and this skill outlives them.
   - **Active sprint** (no closed banner, window end date in the future): extract the priority stack, per-repo status, blockers, and suggested focus — from the doc, verbatim.
   - **Between sprints** (the doc carries a "Window closed" banner, its window end date has passed, or the index lists none): do not resurrect the dead priority stack or countdown. The briefing must say the hub is between sprints and what the closed doc says comes next.

2. **Check live repo state + drift**
   - Execute: `pwsh C:\Users\rplap\OneDrive\Desktop\steel\ops\drift-check.ps1` (runs the git preflight first, then both drift stages)
   - From the preflight table, note each spoke's branch / ahead / behind / dirty — this is **live** state; trust it over any hand-typed sprint status
   - Note the dynamic pass/fail counts and the verdict line

3. **Output briefing** — exactly one of these two formats, no more:

   **Active sprint:**

```
SESSION BRIEF — <today's date>
<only if the sprint doc declares a deadline: "Days to <event>: <days remaining>">

PRIORITY STACK
  <one line per repo — order, labels, and status copied verbatim from the sprint doc's priority stack>

GIT    <repo:branch ±ahead/behind dirty?> for any spoke needing attention, else "all clean & current"
DRIFT  <pass> pass / <fail> fail  <"— all clear" if 0 fail and verdict is a pass; if UNVERIFIED, say so and name the behind/dirty spoke; else list each FAIL>

FOCUS TODAY
  <copy the sprint doc's suggested-focus items verbatim, numbered>
```

   **Between sprints** (same GIT/DRIFT lines, priorities replaced):

```
SESSION BRIEF — <today's date>
No active sprint — <closed sprint name> ended <window end date>; next sprint doc pending.

GIT    <as above>
DRIFT  <as above>

FOCUS TODAY
  1. If this session is for planning: draft the next sprint doc in sprint/ and update sprint/index.md
  2. Otherwise: name the repo the user came to work on and proceed via its project card
```

4. **Update the session log** — append `| <date> | <repo or "steel"> | Session started |` to the **active** sprint doc's Session log table. Only add the row — change nothing else. Between sprints, skip this step and say so in the briefing: a closed sprint doc is historical and must not be written to.

## Notes

- If the drift check has failures, flag them before the Focus section and do not proceed to spoke work until the user acknowledges
- Do not summarize or paraphrase sprint content — copy status lines verbatim
- All deadline math comes from the sprint doc's own window/deadline fields, never from dates baked into this file
