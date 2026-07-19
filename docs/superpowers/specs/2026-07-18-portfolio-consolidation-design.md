# Portfolio Consolidation — Design

**Date:** 2026-07-18
**Status:** Approved (operator, this session)
**Gap this doc fills:** no existing vault doc plans the whole-portfolio retrospective (2024→now) or the forward initiative set; the sprint names the journey doc as pending but nothing scopes it.

## Context

Thirteen GitHub repos plus local-only strategy repos span three eras: the AI-for-teachers lineage (edcoachai → pelican-ai-strategy/aida → sped-sync), the ISTE 26 arc (creative-lab, iste-26, portfolio, creative-lab-demos), and the current production era (course-lab, project-studio-coach). Architecture and patterns from the legacy tier were never harvested; their visions never received explicit rulings. This effort mines everything, rules on each lineage, and cuts forward planning docs — all before the 2026-27 school year consumes the calendar.

## Decisions already ratified (this session)

1. **Output shape:** planning docs under the single active sprint (Fall Runway). No queued sprint docs; future sprints get cut from `initiatives/`.
2. **Mining scope:** every local repo plus a fresh `sped-sync` clone. No stone unturned, including unmentioned repos (stoic-scholar, sanity-ai-portfolio, portfolio-markdown-site, github-readme, iste-outreach-tracker, ts-google-automation, coding-playground-vanilla).
3. **Verdicts + harvest:** each legacy vision gets a ruling — **absorb** (ideas fold into a current repo), **revive** (own initiative doc), or **close** (harvested and retired) — recorded in `wiki/decisions.md`.
4. **Hybrid mining (Approach A):** judgment-critical repos read inline by the session agent; secondary tier via parallel Explore agents; ISTE-arc spokes distilled from existing vault docs, not re-mined.

## Deliverables & layout

| Artifact | Location | Gap it fills |
|---|---|---|
| Dossiers, one per mined repo (~15, short, fixed format) | `archaeology/` + `archaeology/index.md` | Nothing covers the pre-hub repos |
| Journey narrative, June 2024 → now | `wiki/journey.md` | Sprint P3 pending item |
| Pattern harvest | `wiki/patterns.md` | Wiki holds facts, not architecture patterns |
| Lineage verdicts | append to `wiki/decisions.md` | Extends existing rulings log |
| 4-5 forward initiative docs | `initiatives/` + `initiatives/index.md` | `sprint/` holds only the active window |

Vault `index.md` map gains rows for `archaeology/` and `initiatives/`.

## Mining plan

- **Inline deep-read (session agent), in order:** edcoachai, pelican-ai-strategy, aida, sped-sync (clone to `personal/` first), project-studio-coach, course-lab (light — vault already documents it).
- **Explore agent A:** stoic-scholar, sanity-ai-portfolio, portfolio-markdown-site, github-readme.
- **Explore agent B:** ts-google-automation, coding-playground-vanilla, iste-outreach-tracker.
- **From vault docs only:** creative-lab, iste-26, portfolio, creative-lab-demos.

**Dossier format (fixed):** Identity (what it was, when, final state) → Stack → Patterns worth keeping (with file refs) → Dead ends & lessons → Verdict candidate + evidence. One page maximum per repo; dossiers are written to disk immediately after each read so context churn cannot lose them.

## Verdict process

After all dossiers exist: the agent proposes absorb/revive/close per lineage with evidence; the operator ratifies via question rounds. Ratified verdicts are appended to `wiki/decisions.md` with date and evidence links. Initiative docs are cut only from surviving verdicts.

## Synthesis rules

- `wiki/journey.md`: narrative from dossiers + git history; per-lineage arc, not per-repo listing.
- `wiki/patterns.md`: admits only patterns with ≥2 occurrences across repos **or** a named forward use in a current initiative. Harvest, not museum.
- Initiative docs: expected candidates are EdgeEx build family, course-lab production runway, project-studio-coach, AI-for-teachers lineage successor, public identity/portfolio — final list ratified after verdicts. Each doc: vision, current state, harvested inputs (links to dossiers/patterns), first sprint-sized slice.

## Shipping

Operator authorized commits in steel for this effort (2026-07-18). Ordered single-concern PRs on feature branches:

1. `docs/portfolio-consolidation` — this spec
2. archaeology dossiers + index
3. `wiki/journey.md`
4. `wiki/patterns.md` + decisions appends
5. `initiatives/` set + vault index rows

Checkpoint commit per doc. Sprint doc gets session-log rows and the P3 journey item ticked at close.

## Out of scope

- Any product code changes in any spoke
- Monorepo / shared-package extraction (still explicitly out of sprint scope)
- Reviving any legacy deployment (verdicts rule on visions, not on redeploying old apps)

## Success criteria

- Every repo in the inventory has a dossier
- Every legacy lineage has a ratified verdict in `wiki/decisions.md`
- `wiki/journey.md` satisfies the sprint P3 item
- 4-5 initiative docs exist, each with a first sprint-sized slice
- All shipped as ordered PRs; drift check still passes
