# creative-lab-demos

**GitHub:** [Lokie-ree/creative-lab-demos](https://github.com/Lokie-ree/creative-lab-demos)  
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/creative-lab-demos`  
**Live:** [creative-lab-demos.vercel.app](https://creative-lab-demos.vercel.app)  
**Branch:** `main`  
**Agent entry:** `CLAUDE.md`

## Role

Standalone interactives outside the M1–M3 curriculum arc. Currently: **Cross-Section Explorer** (CSE) only.

Featured on portfolio Live Demo section — not in System grid rows.

## Stack

React Router v7 (SPA, SSR off) · R3F · CSG · Rapier (lazy) · GSAP · Tailwind 4 · amber tokens (`app/tokens.ts`)

## Commands

```bash
pnpm install && pnpm dev
pnpm build && pnpm typecheck
pnpm test
```

## Key paths

| What | Where |
|------|-------|
| Main route | `app/routes/home.tsx` |
| State | `app/hooks/useDemoReducer.ts` |
| Classifier | `app/utils/classifyShape.ts` |
| Architecture | `demos/cross-section-explorer/ARCHITECTURE.md` |
| PRD / UX spec | `demos/cross-section-explorer/` |

## Sync obligations

Portfolio `CrossSectionPreview` is a **separate reimplementation** — visual parity matters for the door experience, not code sharing. If CSE completion thresholds or connection copy change, check portfolio preview behavior separately.

## Status (2026-05-19)

- CSE + physics mode stable on main
- Last activity ~7 days ago — lowest ISTE sprint priority unless exhibit demo needs fixes
