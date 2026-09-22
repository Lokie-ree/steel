# Patterns — Harvested Architecture

Gap this doc fills: the wiki holds facts (names, URLs, coords) but no architecture patterns; the 2026-07-18 consolidation harvested these from the full 17-repo dig ([[../archaeology/index]]). Admission rule: a pattern appears in ≥2 repos, or has a named forward use in a current initiative. Harvest, not museum — if a pattern loses its forward use, delete it.

**Scope: repos.** For surfaces with no repo behind them — documents, packets, context stacks — the sibling registry is [[../initiatives/reconciliation-layer]], which adapts this bar to ≥2 independent *instances*. Two registries on purpose, not an oversight: that doc's open question 2 chose placement there over widening the bar here, on the grounds of §1 below. **Check both before concluding a shape is unrecorded.**

## 1. Markdown-as-canonical pipeline

Author in markdown under git; a sync step publishes to the serving layer; the DB/bundle is derived, never hand-edited. Emerged **three times independently** before being recognized: portfolio-markdown-site's `scripts/sync-posts.ts` (gray-matter → Convex → static `/raw/*.md`), project-studio-coach's `scripts/sync-knowledge.mjs` (docs/ → convex/knowledge → RAG), steel's `build-context` (wiki/module-facts.md → `.hub/` bundles). Cousin: ts-google-automation's markdown-template DSL (`src/parsers/survey-parser.ts:6-80`) parsing `**Type:**`/`**Options:**` markdown into typed Google Forms.
**Forward use:** every initiative; this is the house style. New corpora and content surfaces start as markdown + sync script, never as DB-first.
**Correction 2026-07-26:** steel's `build-context` was deleted — it was the one instance
of this pattern with **no consumer**, generating bundles into six repos that never
imported them. The pattern survives on its two live implementations. The lesson it leaves
is a sharpening of the admission rule: a sync pipeline earns its place from the reader
downstream, not from the canonical source upstream. Markdown-as-canonical is not a reason
to build a sync step nobody reads.

## 2. Namespace-per-domain RAG with first-class ingestion

aida's `convex/rag.ts`: corpus split into six semantic namespaces (instruction/planning/environment/professionalism/system/coaching), typed `contentType` filters, a query cookbook in the doc comment, and ingestion as repeatable Convex functions (`ingestStandards.ts`, `ingestRubric.ts`, `ragCleanup.ts`) rather than one-off seeds. studio-coach repeats the shape (docs-as-corpus → knowledge modules → RAG). sped-sync's hand-rolled `documentChunks` table is the "before" picture that shows why the component won.
**Forward use:** canonical teacher-facing AI spine ([[decisions]] D-2026-07-18a); any future corpus (EdgeEx lesson bank) uses this shape.

## 3. Structural guardrails beat prompt guardrails

studio-coach withholds archetype plan fields **at the query layer** (explicit-pick projection + return validator — `archetypes:search` cannot return them; the only door is a logged reveal). Contrast: sanity-ai-portfolio's layered guardrail *prompts* (`prompts/guardrail_fail_agent.txt`, topic filter/moderator) — useful, but advisory. Two implementations, one lesson: when pedagogy or safety depends on the model *not* having something, enforce it in schema/projection, not instructions.
**Forward use:** every agentic build; already the studio-coach standard.
**Third instance, 2026-09-22 harvest: still-true, where the guardrail is on output, not input.** The model returns **line numbers, never prose quotes**. The server reads the quote out of the source by index after the model has finished. `convex/schema.ts` makes a finding a discriminated union, so an `answered` finding cannot exist without `quote` and `lineNo`, and a refusal carries `linesSearched` so it can be counted. **The sharpening it leaves:** state exactly which field the structure protects. On 2026-09-10 the README claimed the model never writes the answer, but the answer is the one field that is entirely model prose. Only the quote is guaranteed. A structural guarantee described one field too wide is a prompt guarantee again.

## 4. Metered-AI spine (auth → quota → generate → log → cache)

edcoachai's complete chain: `convex/aiFeedback.ts:41-67` (authenticate → resolve user → per-plan monthly quota check), `aiUsageLogs`/`aiUsageAlerts` tables, `aiFeedbackCache` response cache, `FeatureProtect.tsx` UI gating. Matured in studio-coach as `rateLimits.ts` + `usage.ts` + token budgets.
**Forward use:** any AI feature that students or colleagues touch gets this spine before it gets users.

## 5. Durable stage machine for multi-step experiences

studio-coach: stage pointer in the record (`projects.stage`) mirrored by a Workflow parked on `awaitEvent` between stages; agent-persisted streaming deltas make reloads lossless. Ancestors: edcoachai's `workflowStates` table + walkthrough wizard (`WalkthroughWizard.tsx` + `wizard-steps/`).
**Forward use:** EdgeEx build family — any multi-round student module that must survive a closed Chromebook lid.

## 6. Resilient no-backend persistence for classroom tools

Seed-data + localStorage overlay (iste-outreach-tracker `initializeData()`, `iste-tracker-final.html:614-630`) matured into course-lab's hardened sink: never-throwing writes, in-memory fallback for cookie-blocked Chrome, two-step clear control (PR #10). School Chromebooks block storage in ways dev machines never do.
**Forward use:** default persistence layer for every course-lab/creative-lab module.

## 7. Persona-driven QA for agentic builds

studio-coach's 4-persona scripted CLI playtests (vague / oversized / stuck / defector) with committed transcripts and an evaluation report (`docs/playtests/2026-07-15-*`), findings fixed in named commits. Ancestor: edcoachai's phase-mapped test suites (`convex/tests/phase1…phase5`) naming tests after product phases, not code units. Anti-pattern on record: edcoachai *deleting* E2E to unblock deploys — QA that blocks shipping gets deleted; QA that replays personas gets kept.
**Forward use:** every agent-facing feature ships with a persona playtest.

## 8. Server-side AI session minting

Model keys and session secrets never reach the client: sanity-ai-portfolio's `app/actions/create-session.ts:5-49` (server action mints ChatKit `client_secret` scoped to the authed user); studio-coach runs all model calls in Convex actions.
**Forward use:** invariant for anything students touch.

## 9. Heuristic before LLM

aida's title generation (`promptCoach.ts:18-65`): regex-extract standard codes / grade+subject patterns, LLM never called for what a regex answers. One occurrence, kept for its forward use: cost discipline in every AI feature — reach for the model last.

## 10. Append-only events + aggregate counters

portfolio-markdown-site's `convex/stats.ts`: views as append-only event records with dedup windows and O(log n) `TableAggregate` counters instead of hot-row updates; cron cleanup. One occurrence, kept for its forward use: course-lab's measurement spine, if/when it needs server-side analytics.

## 11. Domain-grounded agent personas

Agent role definitions anchored in real practitioner constraints, not job titles: pelican-ai-strategy's `agents.yaml` ("Would I use this during my planning period?"), preceded by edcoachai's `docs/agents/*.md`.
**Forward use:** persona style for future agent/subagent definitions in any spoke.

## 12. Claims as executable checks, one question per script

What a repo says about itself is a claim. Claims get a script that exits non-zero when they're false, and each question gets its own script and its own verdict. This emerged **twice independently**:

- **still-true:** `scripts/gate.mjs` asks whether the *system* still works. It makes eight read-only checks against production, and one carries a control so that a query returning nothing for everything cannot pass. `scripts/reconcile.sh` asks whether the *documents* still describe the system (CONFIRMED / DRIFTED / UNVERIFIABLE). Its header gives the reason for the split: the gate "is itself one of the claims the README makes."
- **steel:** `ops/drift-check.ps1` asks whether the frozen spokes still agree. `ops/vault-check.ps1` asks whether the vault's own records still resolve. It's kept separate because "one green line covering two unrelated questions" is the failure `CLAUDE.md` already warns about.

**The two rules both converged on:** checks are read-only and free, so there's no reason not to run them. Every check is written from a defect that actually happened, not a hypothetical. **The limit on record:** On 2026-09-15 still-true's reconciler flagged seven drifts, and two were real. A doc-checker is an instrument that needs reading, not an oracle.

**Forward use:** every repo with a public README or a judge reading it. The next hackathon build gets a gate on day one, not in week two ([[../initiatives/public-identity]] §Next instances).
