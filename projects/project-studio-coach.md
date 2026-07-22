# project-studio-coach

**GitHub:** [Lokie-ree/project-studio-coach](https://github.com/Lokie-ree/project-studio-coach) (public — source only; the standing no-auth warning below is about deployment, not visibility)
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/project-studio-coach`
**Live:** — (not deployed; **standing warning:** no auth — do not deploy beyond the trusted club)
**Branch:** `main` (default; feature-branch only, never commit to main)
**Agent entry:** `CLAUDE.md` (ground truth) → `README.md` → `docs/`

## Role

AI coach that teaches students to scope a vague, oversized idea into a project they can finish, then writes what they learned back into a living, teacher-gated archetype library. Built for the voluntary, ungraded high-school club. Pedagogical thesis: ISTE+ASCD *Profile of an AI-Ready Graduate*, Learner 1.1 — the **student** does the focusing; the coach withholds the library's pre-written plans until the student's own plan exists. Not an ISTE-arc surface; workflow-governance spoke (P6).

## Stack

Convex backend (Agent, Workflow, RAG, Rate Limiter, Aggregate, Persistent Text Streaming) · OpenAI via Vercel AI SDK — all model calls server-side in Convex actions; **this repo never calls the Anthropic API** · Vite + React + TypeScript frontend. `OPENAI_API_KEY` is managed in the Convex dashboard environment (active as of 2026-07-17).

## Commands

```bash
npm install && npm run dev   # Vite :5173 + convex dev watcher
npm run typecheck            # both TS projects
npx convex run seed:run      # teacher + 24 archetypes + RAG ingest
node scripts/verify-ui.mjs   # Playwright walk of student + teacher flows
```

## Sync obligations

None — not an ISTE surface, no Tier 1 fields.

## Status (2026-07-17)

- Admitted to STEEL as sixth spoke; 13 pre-admission commits (1 bootstrap + 12 build) grandfathered (conventions apply from admission forward). The merged branch carried 15 commits total: the 13 above plus 2 admission-day commits (README key-status fix, `.gitattributes`) made under convention — so `git rev-list --count` on PR #1's merged branch reads 15, not 13.
- Prototype complete on `main`; coach behavior playtested via 4-persona CLI harness
- **No authentication** — identity is "pick your name"; teacher screen is an unauthenticated route. Hard stop on deploying beyond the trusted club.
