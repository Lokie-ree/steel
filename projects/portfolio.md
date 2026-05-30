# portfolio

**GitHub:** [Lokie-ree/portfolio](https://github.com/Lokie-ree/portfolio)  
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/portfolio`  
**Live:** [randalllapointjr.dev](https://randalllapointjr.dev)  
**Branch:** `feat/pre-iste-refinements` (active) · default `master`  
**Agent entry:** `CLAUDE.md`

## Role

Professional portfolio — "the door." Experience before explanation. Two-act page structure. ISTE educator stop-walking mandate.

## Stack

React 19 · TypeScript · Vite · R3F · GSAP · Tailwind 4 · warm amber `oklch` tokens (`src/tokens.ts`)

**Note:** Different visual system from creative-lab Eurorack — intentional, not drift.

## Commands

```bash
pnpm install && pnpm run dev    # :5173
pnpm run build                  # runs scripts/gen-og.mjs first
pnpm run lint
```

## Key paths

| What | Where |
|------|-------|
| All sections | `src/App.tsx` (monolith — no router) |
| System grid data | `SYSTEM_ROWS` in `App.tsx` |
| R3F previews | `src/components/*Preview.tsx` |
| Creative direction | `docs/CREATIVE_DIRECTION.md` |
| Ecosystem spec | `docs/superpowers/specs/2026-04-12-creative-direction-extension-design.md` |

## Sync obligations

`SYSTEM_ROWS` module names, standards, and hrefs must match [[../wiki/module-facts]]. Live Demo CTA → creative-lab-demos.vercel.app.

## Status (2026-05-19)

- Deployed at randalllapointjr.dev
- **Uncommitted changes:** `App.tsx`, `StatStrip.tsx`, `index.css`, `main.tsx` on `feat/pre-iste-refinements`
- Pre-ISTE scope mostly complete; post-ISTE System graph specced but deferred
