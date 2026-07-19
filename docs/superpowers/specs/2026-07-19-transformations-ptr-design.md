# transformations-ptr — Design

**Date:** 2026-07-19 · **Status:** Approved (operator, this session)
**Repo ruling:** **course-lab** (settles sprint P2's home question — no R3F in a 2D graph tool; production room, live URL, StartGate/roster/telemetry already verified). creative-lab considered and rejected: dormant ISTE-exhibit surface, no student gate, animation gain achievable with CSS transitions.
**Standard:** `F-BF.B.3` — effects of `f(x)+k`, `k·f(x)`, `f(kx)`, `f(x+k)`; cited by ~10 lessons in both EdgeEx courses (steel `wiki/edge-ex-courses.md`). First fall-relevant: Algebra II U2, Algebra III U4.
**Initiative:** steel `initiatives/edgeex-build-family.md` — this is the family's first build.

## Decisions ratified (operator, 2026-07-19)

1. **Pedagogy:** PTR rounds → earned sandbox. Predictions committed in writing before the graph moves; completing the rounds unlocks a free-play slider sandbox (earned-reveal principle).
2. **v1 families:** quadratic + absolute value, defined as data (`{ id, label, f, domain }`) so later families (radicals, exp/log, trig) append without restructuring.
3. **Approach A:** one standalone course-lab module, `transformations-ptr`, one registry row.

## Round structure (roundIds append-only, parameter-coupled)

| Round | roundId | Content | Purpose |
|---|---|---|---|
| 1 | `vshift-quad-plus3` | Predict where `f(x)+3` puts the parabola (choice up/down/left/right + why-textarea, locked before graph moves) | Baseline PTR rhythm |
| 2 | `hshift-quad-plus2` | `f(x+2)` — the trap: most pick "right", it goes left | The module's pedagogical heart; reconcile prose required |
| 3 | `stretch-reflect-abs` | `-2·f(x)` on **absolute value** | Family switch proves rules generalize beyond parabolas |
| 4 | `producer-abs-n1-h2-k3` | **Fixed** target (single-scenario convention, §4.2): `-1·f(x+2)+3` on absolute value; student enters `a/h/k`, check adjudicates exact param equality. Unlimited retries with coach redirect; "I'm stuck — move on anyway" ghost path after a miss (house convention); every commit emits `check` match/miss | Producer stage, house convention |

**Sandbox (post-completion):** sliders `a/h/k` (native `<input type="range">`), family toggle, live re-plot with original as dashed ghost. Unlock is the earned reveal.

## Telemetry (spec §4 compliance)

- `MODULE_VERSION = "1.0.0"`; `TELEMETRY_ENTRY = { roundId: "vshift-quad-plus3", guideState: "predict" }` (StartGate emits entry `round_enter`).
- Per-round `round_enter` from advance handlers; `check` + match/miss at each commit; `complete` at recap. **`next` and `reset` are structurally zero in this module** — every phase transition already carries a distinct event (`round_enter`/`check`/`complete`/`reveal_earned`); do not add them. Emits only in named handlers (§4.4).
- **`reveal_earned` fires at first sandbox entry** — when the student *uses* the unlocked reveal, per the 2026-07-09 commit-gated ruling — not at the unlock moment (which would collide with `complete` at recap). Sandbox-phase events carry `roundId: "sandbox-free-play"`, `guideState: "sandbox"`; entry is the only sandbox emit.
- Sandbox slider motion emits **nothing** (drag-telemetry NOT-DOING).
- Registry row in `src/App.jsx` `MODULES`; the registry guard (PR #14) enforces the contract automatically.

## Interaction & visuals

Reuse the QuadraticsPTR house kit wholesale: SVG `Plane` curve-plotter (extended to a negative-y range for reflections), choice buttons, Coach/verified-praise, tokens/typography, `useSessionReport` + CopyResults. Transformation move-moment = CSS transition on the plotted polyline. No new dependencies.

## Scope fences

- **Out (v1):** radical/exp/log/trig families; `f(kx)` horizontal-stretch round (degenerate without trig — deferred with the trig family); drag-the-curve interaction; any backend/dashboard.
- **AI-ban compliance (both syllabi):** the tool never generates answers; it adjudicates committed predictions only.

## Verification & landing

- `npm test` (registry guard covers wiring); scripted-browser pass on the module's full loop (house habit; Playwright fallback recipe if extension down).
- Append one row to `docs/family-coverage.md` (✔ Algebra II, ✔ Algebra III; ☐ elsewhere) — append-update, no v2 fork.
- Ships via ordered single-concern PRs on a feature branch; auto-deploys to the production URL on merge.
- `MODULE_VERSION` bumps per §4.6 on any pedagogically meaningful change thereafter.
