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

## Status (2026-07-09)

- Session 1 migration merged (PR #1): artifacts in `src/modules/`, `MODULE_VERSION` per file, Vite scaffold, `telemetry.ts` landed **unwired** — tests 6/6, build clean
- Next: Session 2 = emit wiring + `studentCode` UX, gated on founding spec §8 (suite grain, reveal_earned per module, CSV shape)
