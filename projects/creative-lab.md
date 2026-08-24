# creative-lab

**GitHub:** [Lokie-ree/creative-lab](https://github.com/Lokie-ree/creative-lab)  
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/creative-lab`  
**Live:** [creative-lab-five.vercel.app](https://creative-lab-five.vercel.app)  
**Branch:** `main` (default)  
**Agent entry:** `CLAUDE.md`

## Role

Canonical interactive product. Grade 8 Geometry modules M1–M3 complete. IVLA STEM Club student-facing framing.

## Stack

React 19 · TypeScript · Vite · R3F · GSAP · Tailwind 4 · shadcn/ui · Eurorack `--lab-*` tokens

## Commands

```bash
pnpm install && pnpm dev    # :5173
pnpm build && pnpm lint
pnpm vitest run             # tests
```

## Key paths

| What            | Where                                                        |
| --------------- | ------------------------------------------------------------ |
| Module registry | `src/config/modules.ts`                                      |
| Design tokens   | `src/lib/colors.ts`, `src/index.css`                         |
| M1 architecture | `src/components/modules/rigid-motions/ARCHITECTURE.md`       |
| M2 architecture | `src/components/modules/dilations/ARCHITECTURE.md`           |
| M3 architecture | `src/components/modules/pythagorean-theorem/ARCHITECTURE.md` |
| Pedagogy        | `docs/philosophy.md`, `docs/product.md`                      |
| Doc index       | `docs/README.md`                                             |
|                 |                                                              |

## Sync obligations

If you change module names, standards strings, triangle coordinates, or the live URL → update [[../sync-registry]] spokes: iste-26, portfolio.

## Status

*Newest on top.*

- (2026-08-03) The 2026-07-22 ruling was **reopened on a verbal claim and re-closed by the v2 schedule inside the same session**: live spoke, no fall build. No geometry on the schedule, no spatial content in Algebra II. Second-door routing (a direct-to-sandbox entry point on an existing module) is the only in-scope extension raised — **held**, pending whether M1/M2/M3 sandbox state stands alone or depends on state accumulated in preceding phases ([[../wiki/decisions]] D-2026-08-03c). A routing PR on a repo with no fall build has no runway consequence; it is not a reason to open one.
- (2026-05-19) M1–M3: all 4 phases complete
- Recent: navigation flatten (Hero → ModulePicker → Module, #65)
- Outstanding polish: see `CLAUDE.md` § Outstanding Work
