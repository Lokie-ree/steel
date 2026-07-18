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
| 5 | **iste-26** | Maintenance only: two untracked docs (`iste-narrative.md`, `lab-guide-rubric.md`) — commit to repo or move into steel; this is what's holding drift-check at UNVERIFIED. |
| 6 | **creative-lab-demos** | Dormant. Touch only if something breaks. |

---

## Per-repo status

### course-lab — P1

- **Live git state:** `pwsh ops/repo-state.ps1`
- **Done recently:** Session 2 merged (telemetry spine wired across all 12 files / 29 units); five pre-August plan docs landed in steel
- **Next:** land `feat/sink-hardening`, then run PLAN-course-lab-smoke-verify; roster codes are still placeholders (`TEST01`/`TEST02`) — real codes before student use; deploy surface decision before August

### creative-lab — P2

- **Done recently:** M1–M3 stable; ISTE exhibit concluded
- **Next:** brainstorm the transformation explorer against [[../wiki/edge-ex-courses]] — scope whether it lives as one module or a family; decide creative-lab vs course-lab home (stack boundary: R3F stays in creative-lab)

### steel — P3

- **Done recently:** `wiki/edge-ex-courses.md` distilled from the six EdgeEx PDFs (2026-07-17)
- **Next:** journey doc (June 2024 → now: React/Next beginnings, EdCoachAi, Pelican AI, SpedSync, 2026 builds — GitHub archaeology); sweep index/wiki for stale ISTE-sprint framing

### portfolio — P4

- **State:** parked on `docs/dilations-card-copy`, clean, 0/0
- **Next:** finish the branch or delete it; no other work this sprint

### iste-26 — P5 (maintenance)

- **State:** dirty — two untracked docs only
- **Next:** decide home for `iste-narrative.md` + `lab-guide-rubric.md`, then re-run drift check to clear UNVERIFIED

---

## This week's suggested focus

1. **Clear the drift verdict** — home the two untracked iste-26 docs; re-run `pwsh ops/drift-check.ps1` to a clean PASS
2. **course-lab: land sink-hardening** — it's the open feature branch; then smoke-verify per plan
3. **Ship the baseline branch** — `docs/edge-ex-baseline` (edge-ex reference + this sprint doc) to PR
4. **Transformation explorer brainstorm** — one session, output is a scoped plan, not code

---

## Session log

| Date | Repo | What happened |
|------|------|---------------|
| 2026-07-17 | steel | Sprint opened. EdgeEx PDFs ingested → wiki/edge-ex-courses.md; ISTE-40d sprint archived |

---

## Explicitly out of scope (this sprint)

- ISTE 27/28 planning (deferred indefinitely, revisit winter)
- Guide-dependent pacing/assessment work — blocked until EdgeEx student/teacher guides release
- Monorepo / shared packages
- New studio-coach features (spoke stays registered, no sprint work)
- Post-ISTE portfolio System graph (still specced, still deferred)
