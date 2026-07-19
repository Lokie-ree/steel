# project-studio-coach

**Identity:** AI coach that teaches students to scope a vague, oversized idea into a finishable project, then writes what they learned back into a living archetype library for the next student. Built for Mr. L's voluntary ungraded high-school club; pedagogical thesis is ISTE+ASCD *AI-Ready Graduate* Learner 1.1 (*the student does the focusing*). Founded 2026-07 per steel's ratified conventions (.gitattributes, main, single bootstrap commit); full prototype merged as PR #1 (2026-07-17). **Current-era active vision**, admitted as a hub spoke 2026-07-17.
**Stack:** Convex with the full component ecosystem — Agent, Workflow, RAG, Rate Limiter, Aggregate, Persistent Text Streaming, crons; OpenAI via Vercel AI SDK (server-side only); Vite + React TS.
**Patterns worth keeping:**
- **Pedagogy enforced structurally, not by prompt** — archetype plan fields are withheld at the query layer (`convex/archetypes.ts` explicit-pick projection + return validator: `archetypes:search` *cannot* return them); the only door is a logged reveal at defined rungs. Guardrails as schema, not vibes — the strongest AI-safety pattern in the portfolio.
- **Durable stage machine** — `projects.stage` pointer mirrored by a Workflow parking on `awaitEvent` between Spark → Expand → Narrow → Shape → Checkpoint → Export; agent-persisted streaming deltas make reloads lossless (`convex/workflows.ts`, `convex/agent.ts`).
- **Teacher-gated write-back / living library** — completed projects draft contributions (remix prompt, before/after scope cut, hazard hit, actual-vs-estimated time) into a review queue; nothing enters the library unapproved (`convex/writeback.ts`).
- **Persona playtest harness** — 4-persona scripted CLI playtests with transcripts + evaluation report (`docs/playtests/2026-07-15-*.md`); adversarial findings fixed in named commits. QA method worth reusing on every agentic build.
- **Docs-as-corpus pipeline** — `docs/*.md` → `scripts/sync-knowledge.mjs` → `convex/knowledge/*.ts` → RAG ingestion; same markdown-is-canonical shape as steel's build-context and portfolio-markdown-site's sync.
- Direct aida inheritance: RAG + Agent + ingestion lifecycle, matured (rate limits, usage tracking, streaming).
**Dead ends & lessons:** None yet — honest-limitations section (no auth, club-scale identity) is deliberate scope, not debt.
**Verdict candidate:** **keep (already active)** — this is where the aida RAG/agent lineage currently lives for the student-facing side; initiative doc should define its next slice (auth pickup per `docs/auth-notes.md`, club pilot readiness).
