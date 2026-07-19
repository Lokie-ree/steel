# sanity-ai-portfolio

**Identity:** "AI-Twin" portfolio — public portfolio at `/` plus embedded Sanity Studio at `/studio`, with an OpenAI ChatKit "digital clone" chatbot. Forked from the PAPAFAM/Sonny Sangha tutorial (README lines 336-437 are still the tutorial's). Active Oct 15 → Oct 24 2025 (~10 dense days), then stopped mid-polish (last commits are z-index/sidebar work). Superseded by portfolio-markdown-site as the portfolio direction.
**Stack:** Next.js 16 (Turbopack) + React 19, Sanity 4 CMS (13 schemas), Clerk, OpenAI ChatKit (`@openai/chatkit-react`), Tailwind v4 + shadcn/ui, Framer Motion, Recharts, Biome, pnpm.
**Patterns worth keeping:**
- Dual-app App Router split — `app/(portfolio)/` vs `app/(sanity)/studio/[[...tool]]/`: one repo, one dev server, live-editable CMS (`CLAUDE.md:33-42`).
- Sanity real-time live-fetch wiring — `sanity/lib/live.ts:6-10` (`defineLive` → `sanityFetch`/`<SanityLive/>`), sections as async server components.
- **ChatKit session bootstrap gated behind Clerk** — `app/actions/create-session.ts:5-49`: server action mints a `client_secret` scoped to the Clerk `userId`; keys never reach the client.
- **Layered AI-safety prompt set** — `prompts/`: AI-twin persona + `guardrail_fail_agent.txt` + `topic_filter_prompt.txt` + `topic_moderator_agent.txt`. A real guardrail/topic-moderation pattern.
**Dead ends & lessons:** Paid four-service stack (Clerk + Sanity + ChatKit + AgentKit) for a single-user portfolio was over-built; the CMS-driven approach lost to the simpler markdown-sync model.
**Verdict candidate:** **absorb then close** — harvest the ChatKit-session and guardrail-prompt patterns; the repo itself is superseded.
