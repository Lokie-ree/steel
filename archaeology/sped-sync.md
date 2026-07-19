# sped-sync

**Identity:** Special-education management PWA — IEP/LEP/504 lifecycle: collaborative IEP editing, progress monitoring, compliance tracking, AI chat. Prompted by a SPED teacher's frustration with fragmented systems. Jul 22 → Aug 5 2025, **8 commits (~2 weeks)** — an intense docs-first spike that stopped at prototype stage. Second Convex project (after edcoachai).
**Stack:** Vite + React 18 TS, shadcn, Convex with **`@convex-dev/prosemirror-sync` + presence** (real-time collaborative editor), Better Auth, OpenAI via actions, Resend. 13-table schema.
**Patterns worth keeping:**
- **Real-time collaborative document editing** — `convex/prosemirror.ts:10-11`: ProsemirrorSync + Presence components wired to IEP documents (`CollaborativeEditor.tsx`, `CollaborationIndicator.tsx`). The portfolio's only multi-user live-editing implementation.
- **Hand-rolled RAG scaffold** — `documentChunks` table (`convex/schema.ts:175`) for chunked document retrieval; predates aida's adoption of `@convex-dev/rag` — useful contrast showing why the component won.
- **Docs-first product process** — `docs/`: product-charter, backend-architecture, data-dictionary, ui-ux-flow-specs, testing-deployment, convex-components, api-integrations — all written up front for a two-week build. The discipline that later became steel's spec workflow.
- Domain schema for a compliance-heavy vertical — `ieps`, `progressData`, `implementationPlans`, `reports` (`convex/schema.ts`).
**Dead ends & lessons:** Scope (full IEP lifecycle + compliance + analytics + AI) was months of work approached in a two-week window; energy moved to aida in September. FERPA/compliance stakes of real IEP data make this the riskiest vertical in the portfolio to actually ship solo.
**Verdict candidate:** **close (harvest)** — the prosemirror-sync collaboration pattern and docs-first process are the assets; the vertical itself is too compliance-heavy for a solo side product, and the SPED-teacher empathy now channels through school-facing work.
