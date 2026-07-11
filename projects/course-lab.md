# course-lab

**GitHub:** [Lokie-ree/course-lab](https://github.com/Lokie-ree/course-lab) (private)
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/course-lab`
**Live:** — (not deployed; production surface decided before August)
**Branch:** `main` (default; feature-branch only, never commit to main)
**Agent entry:** `README.md` → `docs/course-lab-founding-spec.md`

## Role

Production module library for the 2026–27 six-course room (Math Essentials → BRCC dual-enrollment college algebra). PTR / Bind-and-Justify / Assume-Fit-Reflect interaction families — ten standalone modules plus two multi-module remediation suites (~9,000 lines, 29 pedagogical units). Hosts the measurement spine (`LabEvent` telemetry). Not an ISTE surface.

## Stack

React 18 · JSX/SVG · Vite · Vitest. **Stack boundary (hard rule):** `three`, `@react-three/*`, and `gsap` never appear in this repo's `package.json` — R3F work lives in creative-lab. A violation means the boundary leaked: stop and review.

## Commands

```bash
npm install && npm run dev   # Vite dev server + module picker
npm test                     # Vitest (telemetry spine)
npm run build
```

## Key paths

| What | Where |
| --------------- | ------------------------------------- |
| Module library | `src/modules/` (12 files; the two Remediation files are suites) |
| Measurement spine | `src/lib/telemetry.ts` (+ colocated tests) |
| Module picker | `src/App.jsx` (moduleId registry) |
| Founding spec | `docs/course-lab-founding-spec.md` — rulings + spine spec + review gates |

## Sync obligations

None in Tier 1 — course-lab is not an ISTE surface and shares no synced fields. The spine's `LabEvent` schema is shared **by contract** with creative-lab instrumentation (founding spec §4); change it in the spec first.

## Status (2026-07-11)

- Session 1 migration merged (PR #1): artifacts in `src/modules/`, `MODULE_VERSION` per file, Vite scaffold, `telemetry.ts` landed unwired
- **Session 2 merged 2026-07-10** (PRs #5–#9): telemetry provider + StartGate `studentCode` prompt + roster validation + CSV export, then emit wiring across all 12 files / 29 pedagogical units at internal grain (7 PTR modules, 3 non-PTR standalones, algebra suite, geometry suite) — tests 10/10, build clean
- **Open, not code:** (1) in-browser smoke verification of the wired spine has not been run — see `docs/superpowers/plans/PLAN-course-lab-smoke-verify.md`; (2) roster codes in `src/lib/roster.ts` are placeholders (`TEST01`/`TEST02`) — Randall must swap in real codes before student use; (3) deployment surface decided before August (operator decision, not blocking)
