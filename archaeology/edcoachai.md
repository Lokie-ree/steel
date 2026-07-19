# edcoachai

**Identity:** AI-assisted instructional-coaching SaaS ("EdCoachAi") — classroom walkthroughs → AI feedback → teacher reflection, a five-phase "continuous growth loop" (set goal → capture evidence → generate feedback → reflect → monitor). Built March 2025 → September 2025 (feature-complete "87%"), security-patched through January 2026, then **archived on GitHub**. The most complete SaaS ever shipped in this portfolio: dual coach/teacher dashboards, invitations, billing plans, onboarding, marketing site.

**Stack:** Next.js 14 App Router (route groups per audience: `(marketing)` / `(setup)` / `(dashboard)` with `(coach)` / `(teacher)` nests), Convex backend (14 tables), Clerk auth, OpenAI `gpt-4.1-mini`, shadcn/ui + magicui, Vitest, pnpm.

**Patterns worth keeping:**
- **Convex AI action with auth + usage gating** — `convex/aiFeedback.ts:41-67`: authenticate → resolve user → check per-plan monthly AI quota → generate. Plan limits in `convex/plans.ts`, logs in `aiUsageLogs`/`aiUsageAlerts` tables, UI gating via `components/common/FeatureProtect.tsx` + `hooks/usePlanDetection.ts`. The complete metered-AI-feature spine.
- **AI response caching table** — `aiFeedbackCache` in `convex/schema.ts` with `isCached` flags in the action; cost-control pattern.
- **Phase-mapped test suites** — `convex/tests/phase1-goal-setting.test.ts` … `phase5-monitor-growth.test.ts` + `complete-growth-loop.test.ts`: tests named after product phases, not code units. Readable product-level coverage.
- **Agent persona docs** — `docs/agents/{product-manager,system-architect,ux-designer,backend-engineer,frontend-engineer}.md`: proto multi-agent role docs, direct ancestor of steel's hub-governance idea.
- **Single source-of-truth context doc** — `docs/CONTEXT.md` (mission, personas, status): the pattern steel's vault later institutionalized.
- **Multi-step wizard** — `app/(dashboard)/walkthrough/new/components/WalkthroughWizard.tsx` + `wizard-steps/`; validation per step in `validation.ts`.

**Dead ends & lessons:**
- **E2E testing was completely removed** to unblock deployments (Sep 23 2025 commit run: "skip E2E tests temporarily" → "make E2E non-blocking" → "completely remove E2E testing"). Lesson: CI-coupled E2E on a solo project became a deploy blocker, not a safety net.
- **Billing/plans built before users existed** — three-tier pricing, quota alerts, upgrade prompts, for a product that never launched. Premature monetization scaffolding.
- **Not actually RAG** — remembered as "first RAG build," but the AI path is context-stuffing (rubric indicator objects inlined into a single user prompt, `aiFeedback.ts:102,184`); no embeddings or vector search anywhere. `data/handbook.json` is seed data, not a retrieval corpus.
- A week of CI firefighting (Sep 22-23) consumed the final active stretch; the project archived shortly after reaching "polish" phase.

**Verdict candidate:** **close** (already archived) — harvest the metered-AI spine, phase-test naming, and wizard pattern; the AI-for-teachers vision continues through aida/Pelican.
