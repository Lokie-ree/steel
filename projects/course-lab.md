# course-lab

**GitHub:** [Lokie-ree/course-lab](https://github.com/Lokie-ree/course-lab) (public)
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/course-lab`
**Live:** <https://course-lab-two.vercel.app> (Vercel; deployed 2026-07-18, auto-deploys from `main`)
**Branch:** `main` (default; feature-branch only, never commit to main)
**Agent entry:** `README.md` → `docs/course-lab-founding-spec.md`

## Role

Production module library for the 2026–27 room — **Algebra II and Algebra III on EdgeEx** ([[../wiki/decisions]] 2026-07-22; the six-course framing is historical). PTR / Bind-and-Justify / Assume-Fit-Reflect interaction families — eleven standalone modules plus two multi-module remediation suites (30 pedagogical units). Hosts the measurement spine (`LabEvent` telemetry). Not an ISTE surface.

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
| Module library | `src/modules/` (13 files; the two Remediation files are suites) |
| Measurement spine | `src/lib/telemetry.ts` (+ colocated tests) |
| Module picker | `src/App.jsx` (moduleId registry) |
| Founding spec | `docs/course-lab-founding-spec.md` — rulings + spine spec + review gates |

## Sync obligations

None in Tier 1 — course-lab is not an ISTE surface and shares no synced fields. The spine's `LabEvent` schema is shared **by contract** with creative-lab instrumentation (founding spec §4); change it in the spec first.

## Status (2026-07-24)

- Session 1 migration merged (PR #1): artifacts in `src/modules/`, `MODULE_VERSION` per file, Vite scaffold, `telemetry.ts` landed unwired
- **Session 2 merged 2026-07-10** (PRs #5–#9): telemetry provider + StartGate `studentCode` prompt + roster validation + CSV export, then emit wiring across all 12 files / 29 pedagogical units at internal grain (7 PTR modules, 3 non-PTR standalones, algebra suite, geometry suite) — tests 10/10, build clean
- **Smoke-verify PASS 2026-07-18** (PR #11, `docs/smoke-test-2026-07.md`); **real roster codes landed 2026-07-18** (PR #12: 40 codes + DEMO01, placeholder guard tests) — Randall assigns codes→names offline
- **Deployed to Vercel 2026-07-18** (PR #13 recorded the URL; git-connected, auto-deploys from `main`); production loop verified end-to-end with DEMO01
- **Registry guard merged 2026-07-18** (PR #14: 14 wiring-contract tests); **family-coverage scaffold landed 2026-07-19** (PR #15, `docs/family-coverage.md`) — judgment cells open
- **`transformations-ptr` shipped 2026-07-24** (PR #16): `F-BF.B.3` — three PTR rounds (round 2 is the trap: `f(x + 2)` goes left, reconcile prose mandatory), producer round on a fixed `−1·f(x+2)+3` target, earned slider sandbox. 31/31, scripted-browser pass on the exact 11-event sequence, live in production. First build of the EdgeEx family ([[../initiatives/edgeex-build-family]])
- **Open, operator-only:** school-network check of the URL from a school device before August (district filters may block `*.vercel.app` — fix is a custom domain, surface it, don't improvise); family-coverage ☐ cells (the four non-EdgeEx columns are historical as of 2026-07-24)
- **Architecture ruling 2026-07-24:** stays client-side (`localStorage` + memory fallback). **NOT-DOING a backend** — reopens only if collection fails in a real class period or a second teacher adopts course-lab ([[../wiki/decisions]])
- **Gate-blocking open item:** no written protocol for collecting events off ~40 Chromebooks; storage-blocked profiles lose sessions silently ([[../wiki/depth-criteria]] §OPEN). Closeout = written protocol + one DEMO01 dry run
- **Next:** run `transformations-ptr` with real students, then read it against [[../wiki/depth-criteria]] — that gate, not the calendar, decides whether build two starts. The collection protocol has to exist first
