# Sprint — Fall Runway

**Window:** 2026-07-17 → first day of school (mid-August; operator confirms exact date)
**Goal:** course-lab production-ready for students; first EdgeEx-aligned build underway; hub baseline reflects the post-ISTE identity — the teacher who builds with/for students, across all active repos.

Update this file at the **start and end** of each work session.

**North star:** Algebra II/III on EdgeEx (see [[../wiki/edge-ex-courses]]). Builds are the supplemental agile layer on top of the district curriculum — never a replacement. ~20 lessons overlap between the two courses: build once, serve both preps.

---

## Priority stack

| P | Repo | Why |
|---|------|-----|
| 1 | **course-lab** | Production for the 2026–27 room. Finish the pre-August plan set: sink-hardening (in flight on `feat/sink-hardening`) → smoke-verify → deploy → roster swap → registry guard → family coverage. Plans in `docs/superpowers/plans/`. |
| 2 | **creative-lab** | First EdgeEx-aligned build: **function transformation explorer** (`F-BF.B.3` — cited by ~10 lessons in both courses; highest reuse). Planning/brainstorm first, not code-first. |
| 3 | **steel** | Baseline docs: edge-ex reference (done), journey/archaeology doc (2024→now, pending), retire stale ISTE-40d framing in index/wiki where it reads as current. |
| 4 | **portfolio** | Parked branch `docs/dilations-card-copy` — finish or fold it. Otherwise dormant. |
| 5 | **iste-26** | Maintenance only. Voice docs homed via PR #7 (2026-07-17); drift check clean. Dormant unless something breaks. |
| 6 | **creative-lab-demos** | Dormant. Touch only if something breaks. |

---

## Per-repo status

### course-lab — P1

- **Live git state:** `pwsh ops/repo-state.ps1`
- **Done recently:** sink-hardening merged (PR #10, 2026-07-17); **smoke-verify PASS (PR #11)**; **real roster codes merged (PR #12, 2026-07-18)** — guard tests prevent placeholder regression
- **Next:** deploy surface decision (next plan in the set); Randall assigns codes→names offline before student use

### creative-lab — P2

- **Done recently:** M1–M3 stable; ISTE exhibit concluded
- **Next:** brainstorm the transformation explorer against [[../wiki/edge-ex-courses]] — scope whether it lives as one module or a family; decide creative-lab vs course-lab home (stack boundary: R3F stays in creative-lab)

### steel — P3

- **Done recently:** `wiki/edge-ex-courses.md` distilled from the six EdgeEx PDFs (2026-07-17); **journey doc done 2026-07-18** (`wiki/journey.md`, from the full 17-repo consolidation — plus `archaeology/`, `wiki/patterns.md`, `initiatives/`, and ratified verdicts in `wiki/decisions.md`)
- **Stale-framing sweep done 2026-07-19:** index.md (north-star line, sprint link, drift policy), ops/claude.md (session protocol, drift heading), sync-registry.md (policy line) — historical docs (archive/, old specs/plans) deliberately untouched. **Steel P3 fully complete.**

### portfolio — P4

- **State:** parked on `docs/dilations-card-copy`, clean, 0/0
- **Next:** finish the branch or delete it; no other work this sprint

### iste-26 — P5 (maintenance)

- **State:** clean on master; `iste-narrative.md` + `lab-guide-rubric.md` merged via PR #7 (2026-07-17)
- **Next:** nothing this sprint

---

## This week's suggested focus

1. ~~**Clear the drift verdict**~~ — done 2026-07-17: iste-26 docs homed (PR #7), drift check PASS
2. ~~**course-lab: land sink-hardening**~~ — done 2026-07-17 (PR #10); next is smoke-verify per plan
3. **Ship the baseline branch** — `docs/edge-ex-baseline` (edge-ex reference + this sprint doc) to PR
4. ~~**Transformation explorer brainstorm**~~ — done 2026-07-19: spec + PLAN-course-lab-transformations-ptr shipped; home ruled course-lab (decisions log)

---

## Session log

| Date | Repo | What happened |
|------|------|---------------|
| 2026-07-17 | steel | Sprint opened. EdgeEx PDFs ingested → wiki/edge-ex-courses.md; ISTE-40d sprint archived |
| 2026-07-17 | steel | Session started |
| 2026-07-17 | iste-26 | Voice docs (`iste-narrative.md`, `lab-guide-rubric.md`) committed + merged via PR #7; drift check now a clean PASS |
| 2026-07-17 | course-lab | `feat/sink-hardening` landed (PR #10): 13/13 tests, build clean, plan step-8 manual pass replayed via scripted Playwright; merged local branches pruned |
| 2026-07-18 | steel | Session started |
| 2026-07-18 | steel | Portfolio consolidation: 17-repo archaeology (`archaeology/`), verdicts ratified (Pelican spine absorbed; portfolio stays the door; nine bulk rulings), `wiki/journey.md` + `wiki/patterns.md` written, five initiative docs opened (`initiatives/`) |
| 2026-07-18 | course-lab | PLAN-course-lab-smoke-verify executed via scripted Playwright (Chrome extension down — fallback recipe): PASS, zero defects, report merged (PR #11) |
| 2026-07-18 | course-lab | PLAN-course-lab-roster-swap executed: 40 real codes + DEMO01, guard tests red→green, browser-verified, merged (PR #12) |
| 2026-07-18 | course-lab | PLAN-course-lab-deploy executed: live at course-lab-two.vercel.app (Vercel CLI, git-connected for auto-deploy), production loop verified with DEMO01, README URL merged (PR #13) |
| 2026-07-18 | course-lab | PLAN-course-lab-registry-guard executed: 14 wiring-contract tests, fail-first + guard-bite proven, 30/30 green, merged (PR #14) |
| 2026-07-19 | course-lab | PLAN-course-lab-family-coverage executed: 29-unit inventory + six-course grid merged (PR #15) — pre-August plan set COMPLETE; operator judgment cells open |
| 2026-07-19 | steel | Transformation explorer brainstormed to spec + plan (2 reviewer passes); home ruled course-lab; P2 planning item closed |
| 2026-07-19 | steel | Wrap-up: stale ISTE framing swept from live docs (P3 complete); vault shipped current for mentor review 2026-07-20 |

---

## Explicitly out of scope (this sprint)

- ISTE 27/28 planning (deferred indefinitely, revisit winter)
- Guide-dependent pacing/assessment work — blocked until EdgeEx student/teacher guides release
- Monorepo / shared packages
- New studio-coach features (spoke stays registered, no sprint work)
- Post-ISTE portfolio System graph (still specced, still deferred)
