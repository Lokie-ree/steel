# portfolio-markdown-site

**Identity:** Markdown-sync publishing framework (write markdown → `npm run sync` → Convex → live site, no redeploy), forked from `waynesutton/markdown-site` and repurposed as the personal portfolio. Active Dec 14 2025 → Jan 6 2026; transformation carried through merged PRs #2-#5 (clean-slate → projects → homepage → ProjectDetail/About). Mid-transformation but functional — the newest portfolio effort.
**Stack:** React 18/19 + Vite 6 + TS, Convex, React Router v7, Netlify (edge functions), react-markdown + gray-matter, `@convex-dev/aggregate`. Content is git-tracked markdown in `content/`.
**Patterns worth keeping:**
- **Terminal-driven content sync** — `scripts/sync-posts.ts:8-24`: env-switched (`SYNC_ENV`), gray-matter frontmatter parse, push to Convex, emit static `/raw/*.md`. Markdown stays version-controlled; the DB is only the serving layer. Same shape as steel's `build-context` pipeline — convergent evolution.
- **Write-conflict-free analytics** — `convex/stats.ts`: append-only view events with dedup windows (`stats.ts:8-14`) + O(log n) `TableAggregate` counters (`stats.ts:22-40`) instead of hot-row counters; cron cleanup.
- Frontmatter-as-config — posts table with ~30 optional fields driving layout without code changes (`convex/schema.ts`).
- AEO/LLM discovery surface — `/raw`, `/api/posts`, `/llms.txt`, `/openapi.yaml`, HTTP MCP server at `/mcp` (README:132-161).
**Dead ends & lessons:** Six `convex/*.ts.disabled` files (newsletter, aiChat, contact, aiImageGeneration) — upstream's heavier features switched off, not deleted; README is still upstream's marketing.
**Verdict candidate:** ~~revive~~ → **absorb then close (ratified 2026-07-18)** — the `portfolio` spoke stays the door: it is the operator's own ground-up vision and the business-card URL, and a fork of another creator's framework can't be the professional identity however recent or clean. Harvest the sync pipeline, analytics, and AEO surface into [[../wiki/patterns]].
