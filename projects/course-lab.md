# course-lab

**GitHub:** [Lokie-ree/course-lab](https://github.com/Lokie-ree/course-lab) (private)
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/course-lab`
**Live:** <https://course-lab-two.vercel.app> (Vercel; deployed 2026-07-18, auto-deploys from `main`)
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
- **Smoke-verify PASS 2026-07-18** (PR #11, `docs/smoke-test-2026-07.md`); **real roster codes landed 2026-07-18** (PR #12: 40 codes + DEMO01, placeholder guard tests) — Randall assigns codes→names offline
- **Deployed to Vercel 2026-07-18** (PR #13 recorded the URL; git-connected, auto-deploys from `main`); production loop verified end-to-end with DEMO01
- **Registry guard merged 2026-07-18** (PR #14: 14 wiring-contract tests); **family-coverage scaffold landed 2026-07-19** (PR #15, `docs/family-coverage.md`) — judgment cells open
- **Open, operator-only:** school-network check of the URL from a school device before August (district filters may block `*.vercel.app` — fix is a custom domain, surface it, don't improvise); family-coverage ☐ cells + COURSE-5/6 names
