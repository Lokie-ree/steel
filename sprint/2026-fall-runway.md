# Sprint — Fall Runway

**Window:** 2026-07-17 → first day of school (mid-August; operator confirms exact date)
**Goal:** course-lab production-ready for students (done — live, 30/30, guarded); first EdgeEx-aligned build shipped; hub baseline reflects the post-ISTE identity — the teacher who builds with/for students, across all active repos.

**Assignment correction (2026-07-22):** the 2026–27 room is **two preps** — Algebra II and Algebra III on EdgeEx — not six. The infrastructure already built was sized for the larger workload, so the shrink is slack: fewer, deeper builds, gated on real student data ([[../wiki/decisions]] 2026-07-22).

Update this file at the **start and end** of each work session.

**North star:** Algebra II/III on EdgeEx (see [[../wiki/edge-ex-courses]]). Builds are the supplemental agile layer on top of the district curriculum — never a replacement. ~20 lessons overlap between the two courses: build once, serve both preps.

---

## Priority stack

| P | Repo | Why |
|---|------|-----|
| 1 | **course-lab** | ~~Execute `PLAN-course-lab-transformations-ptr`~~ — **shipped 2026-07-24 (PR #16)**, as specced: four rounds, two families, earned sandbox, live in production. What's left is not code: run it with real students. Pre-August plan set complete (PRs #10–#15). |
| 2 | **steel** | ~~Depth criteria doc~~ — **written 2026-07-24** ([[../wiki/depth-criteria]]): four signals off existing telemetry, two thresholds. The gate is now waiting on students, not on writing. |
| 3 | **portfolio** | ~~Parked branch `docs/dilations-card-copy`~~ — **closed 2026-07-24**: already merged upstream (PR #12), branch was stale locally. Dormant, clean on master. |
| — | **creative-lab** | **Live spoke, no fall build** — by ruling, not neglect ([[../wiki/decisions]] 2026-07-22). R3F/CSG stays a shipping capability; neither EdgeEx course has spatial content to aim it at. |
| — | **iste-26** | Dormant. Voice docs homed via PR #7 (2026-07-17); drift check clean. Touch only if something breaks. |
| — | **creative-lab-demos** | Dormant. Touch only if something breaks. |
| — | **project-studio-coach** | Dormant. Spoke stays registered; no sprint work. |

---

## Per-repo status

### course-lab — P1

- **Live git state:** `pwsh ops/repo-state.ps1`
- **Pre-August plan set COMPLETE** — six single-concern PRs, 2026-07-17 → 07-19: sink-hardening (#10), smoke-verify (#11), real roster codes (#12), deploy (#13), registry guard (#14), family coverage (#15). Live at `course-lab-two.vercel.app`, auto-deploy from `main`, 30/30 green, registry guard bites on a typo'd row. Randall assigns codes→names offline before student use.
- **Next:** execute `PLAN-course-lab-transformations-ptr`. Nothing in the plan needs a decision — dispatch it and hold the review gates.
- **`family-coverage.md`: do not rebuild.** The six-course grid did its job (surfaced gaps while there was lead time). Add one dated header note — assignment changed to Algebra II/III, other four columns are historical — and move on. Renovating it is bookkeeping.

### creative-lab — live spoke, no fall build

- **State:** M1–M3 stable; ISTE exhibit concluded; drift check clean
- **Ruling 2026-07-22:** no fall build targets R3F/CSG because neither EdgeEx course has spatial content. The spoke stays live and the capability stays shipping — this is a scope decision, not decay. See [[../wiki/decisions]].

### steel — P2

- **Complete this sprint:** `wiki/edge-ex-courses.md` (2026-07-17); `wiki/journey.md` + `archaeology/` + `wiki/patterns.md` + `initiatives/` + ratified verdicts (2026-07-18); stale ISTE-40d framing swept from live docs (2026-07-19); registry drift swept (PR #14, 2026-07-22); two-course rulings landed (2026-07-24)
- **Next:** nothing until the first class period — the gate is written and the vault is current
- **Not doing:** the Fable standards-mapping audit as originally scoped (29 units × 6 courses — dead with the shrink). Useful residue is one narrow question: do `systems-ptr` and `predict-test-reconcile` actually earn their standards citations? Shrink to that or leave it closed; don't run the original prompt out of momentum.

### portfolio — P3

- **State:** parked on `docs/dilations-card-copy`, clean, 0/0
- **Next:** finish the branch or delete it; no other work this sprint

### iste-26 — P5 (maintenance)

- **State:** clean on master; `iste-narrative.md` + `lab-guide-rubric.md` merged via PR #7 (2026-07-17)
- **Next:** nothing this sprint

---

## This week's suggested focus

1. ~~**Clear the drift verdict**~~ — done 2026-07-17: iste-26 docs homed (PR #7), drift check PASS
2. ~~**course-lab: pre-August plan set**~~ — done 2026-07-19, all six PRs (#10–#15)
3. ~~**Transformation explorer brainstorm**~~ — done 2026-07-19: spec + PLAN-course-lab-transformations-ptr shipped; home ruled course-lab (decisions log)
4. ~~**Land the two-course rulings in vault truth**~~ — done 2026-07-24: decisions log, initiative doc, this sprint doc
5. ~~**Execute `PLAN-course-lab-transformations-ptr`**~~ — done 2026-07-24 (PR #16), live in production
6. ~~**Depth criteria doc**~~ — done 2026-07-24 ([[../wiki/depth-criteria]]); read it once on the first real run's CSV
7. ~~**portfolio `docs/dilations-card-copy`**~~ — done 2026-07-24: already merged upstream, stale branch pruned

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
| 2026-07-22 | steel | Session started |
| 2026-07-22 | github-readme | Profile README rewritten for a builder audience around the Steel hub architecture (PR #1): three-facet frame replaces the ISTE two-arc framing, six-spoke diagram, course-lab + studio-coach added, lineage/patterns from the consolidation |
| 2026-07-22 | github-readme | Design layer shipped (PRs #2 → #3): bespoke header SVG from portfolio `tokens.ts` (light/dark via `<picture>`, mark = the A(1,1) B(4,2) C(2,4) fixture), two-design-systems panel making the Tier 3 never-unify rule visible, amber-themed mermaid. PR #2 was mis-based on the content branch and never reached `main` — #3 carried it across |
| 2026-07-22 | steel | Registry drift swept (PR #14): course-lab live URL in `projects/index`, two stale "(private)" labels. None are Tier 1 fields, so `drift-check.ps1` never saw them — the gap is that spoke-card metadata has no mechanical check |
| 2026-07-24 | steel | Session started |
| 2026-07-24 | course-lab | PLAN-course-lab-transformations-ptr executed (PR #16): `transformations-ptr` — three PTR rounds + trap-round reconcile, producer round, earned sandbox. Registry row failed the guard first; 31/31 + clean build; scripted-browser pass (Playwright fallback, extension down) on the exact 11-event sequence with silent sliders; live in production. Screenshots caught one real defect — the Plane clamped out-of-range y and drew a flat line along the frame — fixed to clipping in the same PR |
| 2026-07-24 | steel | Depth criteria written ([[../wiki/depth-criteria]]) before any student data exists, so the thresholds are judgment rather than post-hoc fitting: round-2 miss band 40–75%, a third of reconciles naming the mechanism, rounds 1/3 ≥ 70% against a low round 2, producer median 2–4 retries with ≤ 25% ghost path. Any one of four failure shapes sends build one back instead of starting build two |
| 2026-07-24 | steel | Two-course rulings landed in vault truth: `wiki/decisions.md` (R3F has no fall surface / creative-lab stays live; fewer-deeper + first-student-data-is-a-gate), `initiatives/edgeex-build-family.md` refreshed to the gated two-build slate, this sprint doc's goal line + priority stack + focus list de-staled |

| 2026-07-24 | portfolio | P3 closed: `docs/dilations-card-copy` was already merged upstream as PR #12 — the branch was stale locally, not unfinished. Synced master and pruned ten fully-merged local branches; portfolio is clean on master with no parked work |
| 2026-07-24 | course-lab | `beatId` dual-semantics note written on the schema (PR #17), closing a crumb outstanding across several sessions: constant phase marker on single-check stages vs. true discriminator where several checks share a roundId+guideState. Analysis groups by roundId+guideState+beatId, never beatId alone — which matters now that the depth criteria read producer retries off that log |

| 2026-07-24 | steel | **Client-side stays** ([[../wiki/decisions]]): course-lab keeps `localStorage` + memory fallback; NOT-DOING a backend. studio-coach's Convex was required by RAG and by plan-gating at the query projection — course-lab has no server-side logic to protect, and client-side buys no district data agreement, no auth surface, no PII off the Chromebook. Two named triggers reopen it: collection fails in a real class period, or a second teacher adopts course-lab |
| 2026-07-24 | steel | **Gate-blocking open item recorded** ([[../wiki/depth-criteria]] §OPEN): the four depth signals read across a class, but events live per-browser under `course-lab:events` and there is no written protocol for collecting ~40 Chromebooks. Named risk — on shared/wiped school profiles `localStorage` can be blocked, the memory fallback then loses the session silently at tab close, so the one dataset authorizing build two is the most exposed. Closeout = a written protocol plus one DEMO01 dry run; deliberately not designed this session |
| 2026-07-25 | steel | Session started |
| 2026-07-24 | steel | Derived-not-transcribed rule extended to tooling paths (`ops/claude.md` Documentation): the transformations-ptr plan carried a stale Playwright executable path while `~/.claude/CLAUDE.md` had it right — same failure mode as hand-typed git state. Paths get referenced from the convention, never pasted into a plan. No plan template exists, so the rule has one home. Executed plan docs left untouched as historical record |

---

## Explicitly out of scope (this sprint)

- ISTE 27/28 planning (deferred indefinitely, revisit winter)
- Guide-dependent pacing/assessment work — blocked until EdgeEx student/teacher guides release
- Monorepo / shared packages
- New studio-coach features (spoke stays registered, no sprint work)
- Post-ISTE portfolio System graph (still specced, still deferred)
- **Rebuilding `course-lab/family-coverage.md`** — one dated header note, not a renovation
- **The Fable standards-mapping audit as originally scoped** — 29 units × 6 courses died with the shrink; only the `systems-ptr` / `predict-test-reconcile` citation question survives
- **A third transformation family in transformations-ptr** — depth goes into student data, not features
