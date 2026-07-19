# aida (Pelican AI)

**Identity:** "Pelican AI — Navigate AI with Confidence": coaching assistant for Louisiana K-12 educators generating Louisiana-aligned prompts for use in any AI tool (deliberately platform-agnostic: *not* another ChatGPT). Sep 23 2025 → Jan 13 2026, **331 commits, 141 PRs** — the largest and most sustained build in the portfolio. Final state: live beta ("Conversational Prompt Coach" at `/coach`), beta-signup + email pipeline in place, then paused when the 2026 course-lab/classroom pivot took over. The three vision morphs are visible in the history: (1) **voice assistant** (Sep 25: voice chat webhook fixes), (2) **RAG alignment scorecard** (removed Dec 2025 — `convex/rag.ts:4-5` "Alignment scorecard features removed, see git history to restore"), (3) **prompt-first conversational coach** (Dec 18 "prompt-first redesign" → Jan launch polish).

**Stack:** React 19 + Vite 6, React Router v7, Tailwind v4 + shadcn, Better Auth (`@convex-dev/better-auth` — deliberate move off Clerk), Convex with the full component ecosystem: `@convex-dev/rag`, `@convex-dev/agent`, `@convex-dev/workflow`. OpenAI GPT-5.1 + text-embedding-3-small. Resend email. Vitest (incl. browser config).

**Patterns worth keeping:**
- **Real RAG with namespace-per-domain design** — `convex/rag.ts`: Louisiana Student Standards + Louisiana Educator Rubric split into six namespaces (`louisiana_rubric_instruction` w/ 12 indicators, planning, environment, professionalism, system, coaching), typed contentType filters (`rubric_indicator` / `rubric_summary` / `rubric_explanation` / `coaching_questions`), doc-comment query cookbook. The portfolio's only true retrieval system, and it's well-architected.
- **Corpus ingestion scripts as first-class functions** — `convex/ingestStandards.ts`, `ingestRubric.ts`, `ingestLeaderHandbook.ts`, plus `ragCleanup.ts`. Repeatable corpus lifecycle, not one-off seeding.
- **Convex Agent + RAG composition** — `convex/promptCoach.ts`: `@convex-dev/agent` wired to the RAG instance, profile-context injection, smart-default prompt generation.
- **Heuristic-before-LLM title generation** — `promptCoach.ts:18-65`: regex-extract standard codes / grade+subject before falling back to truncation. Zero-cost where an LLM call is the reflex.
- **Dated design→implementation plan docs** — `docs/plans/2025-12-17-authenticated-layout-{design,implementation}.md`: the superpowers spec/plan workflow, self-adopted before steel formalized it.
- Auto-save-on-copy prompts library; beta-signup + Resend email events (`betaSignup.ts`, `email.ts`, `emailEvents.ts`).

**Dead ends & lessons:**
- Voice interface abandoned early (webhook fragility, scope) — morph #1 cost the hackathon window.
- Alignment scorecard built then removed for beta simplicity — morph #2; the "What We Are NOT" README section is the scar tissue turned into clarity.
- The meta-lesson the README states outright: the product converged on *coaching the teacher's use of AI* rather than replacing tools — same philosophy course-lab now applies to students.

**Verdict candidate:** ~~revive-or-absorb~~ → **absorb the spine (ratified 2026-07-18)** — Pelican-as-product closes for now; the RAG/ingestion/agent architecture becomes the canonical teacher-facing AI pattern and the Louisiana corpus stays revivable. See [[../wiki/decisions]].
