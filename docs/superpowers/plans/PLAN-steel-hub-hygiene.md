# PLAN-steel-hub-hygiene

**Repo:** `steel` (the vault). Steel commit authorization: executing this plan on Randall's dispatch is the "ask" for these files only. One branch, e.g. `docs/hub-hygiene`, one PR.
**Run AFTER** PLAN-friction-rules-implementation (it commits the currently-dirty working tree; this plan assumes a clean tree).

## Goal

Fix the hub records that are provably stale or missing — mechanical corrections only. The post-ISTE sprint's *content* (new priorities, new window) is Randall's design decision and is NOT this plan.

## Items

### 1 — Append the triangle ruling to `wiki/decisions.md`

`wiki/decisions.md` is the append-only cross-repo ruling log; it currently holds ONE entry (course-lab housing). The M2≡M3 triangle ruling — "M2 and M3 intentionally share A(1,1) B(4,2) C(2,4); not drift" — is recorded only in memory notes and `sync-registry.md`'s table, and the course-lab founding spec §7 names "triangle ruling → wiki/decisions.md" as an open closeout item. Append one row in the existing table format (Date | Ruling | Why | Where it binds): date it 2026-05-30 (when the pipeline encoded it — `HubContext` tests treat M2≡M3 as intentional, per the plan's deviation table), bind it to `sync-registry.md` + `wiki/module-facts.md`. Do not edit the existing entry.

### 2 — Dedupe the sprint session log

`sprint/2026-iste-40d.md` session-log table has duplicate rows ("2026-05-26 | steel | Session started" twice — lines ~68–69). Founding spec §7 names this. Remove the duplicate row only; leave the rest of the log.

### 3 — Refresh the course-lab project card status block

`projects/course-lab.md` "Status (2026-07-09)" still ends at "Next: Session 2 = emit wiring…". Session 2 merged 2026-07-10 (course-lab PRs #5–#9; verify with `git -C <course-lab> log --oneline -10` — derive, don't transcribe from this plan). Update the Status block: Session 2 merged; tests 10/10; remaining = smoke verification (see PLAN-course-lab-smoke-verify), roster-code swap (operator), deployment decision (operator). Date-stamp the block.

### 4 — Retire the four-spoke phrasing in stale spots (verify-first)

The 2026-07-09 registration updated the five known surfaces. Sweep for stragglers: `grep -rn "four spokes\|4 spokes\|four repos" --include="*.md" .` (exclude `agentic-os/`, `docs/superpowers/`). Fix only genuine current-state statements; leave historical/session-log text alone. If zero hits, say so in the PR body.

### 5 — Sprint doc: post-ISTE banner (not a rewrite)

Add one line under the `# Sprint — ISTE 40 Days` heading: `> **Window closed** — ISTE LIVE 2026 has concluded (June 28 – July 1). This doc is historical; the next sprint doc is pending an operator planning session.` Do not delete or restructure anything else; the replacement sprint is Randall's call. (Skip this item if Randall's planning session has already produced a new sprint doc by execution time.)

## Acceptance criteria

- `wiki/decisions.md` has exactly 2 entries, table intact, first entry byte-identical.
- No duplicate session-log rows.
- course-lab card status reflects merged Session 2 and names the three open operator items.
- Grep in PR body proves the four-spoke sweep ran.
- Sprint doc byte-identical except the banner (and any PLAN-friction-rules Step-4 edits that landed first).
