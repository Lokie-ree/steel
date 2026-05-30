# iste-26

**GitHub:** [Lokie-ree/iste-26](https://github.com/Lokie-ree/iste-26)  
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/iste-26`  
**Live:** [iste-26.vercel.app](https://iste-26.vercel.app)  
**Branch:** `feat/hash-router-and-nav-polish` (active) · default `master`  
**Agent entry:** `CLAUDE.md`

## Role

Print-style lab guide viewer for IVLA STEM Club. Teacher sections + student discovery logs. ISTE LIVE 2026 presentation surface.

## Stack

React 19 · TypeScript · Vite · Tailwind 4 · shadcn/ui · `--lab-*` tokens (separate from shadcn semantic palette inside guides)

## Commands

```bash
pnpm install && pnpm dev
pnpm build && pnpm typecheck && pnpm lint
```

## Key paths

| What | Where |
|------|-------|
| Lab guides | `src/components/lab-guides/` (RigidMotions, Dilations, PythagoreanTheorem) |
| Lab primitives | `src/components/lab-guides/labPrimitives.tsx` |
| Tokens | `src/lib/labTokens.ts`, `src/index.css` |
| Pedagogy refs | `docs/PHILOSOPHY.md`, `docs/PRODUCT.md` |

## Hash routes

- `#rigid-motions`
- `#dilations`
- `#pythagorean-theorem`

## Sync obligations

Lab guides reference `creative-lab-five.vercel.app` in multiple places. Module names and standards must match [[../wiki/module-facts]] and portfolio System grid.

## Status (2026-05-19)

- All three guides rendering; hash router landed (c27f742)
- **Uncommitted:** deleted `.claude/skills/module-planning-pipeline/` files — resolve before next commit (restore or commit deletion intentionally)
