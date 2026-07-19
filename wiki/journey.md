# Journey — June 2024 → Now

Gap this doc fills: the sprint's P3 item — the 2024→now archaeology narrative — existed nowhere; per-repo evidence lives in [[../archaeology/index]], but no doc tells the arc. Written 2026-07-18 from the full 17-repo dig.

---

## The shape of the whole thing

Two years, seventeen repos, three eras. Read in order, they are not a pile of abandoned projects — they are one long narrowing of audience: **build for a market → build for a community → build for your own room.** Every "failure" shipped its architecture forward. The stack stabilized early (Convex appears March 2025 and never leaves); what kept changing was *who it was for*, until that question landed on the students in front of Mr. L.

## Foundations (June 2024 – early 2025)

It starts with a README. [[../archaeology/github-readme|github-readme]]'s first commit (2024-06-15) marks the public beginning; React/Next learning and sandboxes ([[../archaeology/coding-playground-vanilla|coding-playground-vanilla]]) fill the months before the first real product. The profile README will quietly evolve for two years, ending as the builder-narrative constellation map it is today.

## Era I — AI for teachers, aimed at a market (March – September 2025)

[[../archaeology/edcoachai|EdCoachAi]] is the first swing and the biggest first swing imaginable: a full instructional-coaching SaaS — Next.js 14, Convex, Clerk, dual coach/teacher dashboards, AI walkthrough feedback, three pricing tiers, quota metering — built to 87% before a single user existed. It is remembered as "the first RAG build"; the dig shows it was actually context-stuffing (a lesson in itself — the memory of a project drifts from its evidence). Its collapse is instructive: a week of CI firefighting, E2E tests deleted to unblock deploys, then archive. But its metered-AI spine, wizard forms, and — critically — `docs/agents/` persona files and `docs/CONTEXT.md` single-source-of-truth doc are the seeds of everything that follows.

Mid-era, a two-week July spike: [[../archaeology/sped-sync|sped-sync]], born from a SPED teacher's frustration. Docs-first (seven planning docs before code), the portfolio's only real-time collaborative editor (ProsemirrorSync + presence), and a scope — the full IEP compliance lifecycle — that no solo builder ships in two weeks. It stops, but the docs-first discipline survives.

## Era II — AI for teachers, aimed at a community (September 2025 – January 2026)

[[../archaeology/aida|aida / Pelican AI]] is the portfolio's magnum opus of this period: 331 commits, 141 PRs, and the famous three morphs — voice assistant (dead in days to webhook fragility), RAG alignment scorecard (built, then deliberately removed), landing on the prompt-first **Conversational Prompt Coach** for Louisiana educators. The narrowing continues: not "coaches everywhere" but *Louisiana* teachers, LEADS rubric, "We're Not Waiting for LDOE." Here the real RAG finally appears — six namespaces over the Louisiana Student Standards and Educator Rubric, typed content filters, repeatable ingestion — the crown-jewel architecture the 2026-07-18 consolidation formally absorbed as the canonical teacher-facing AI spine ([[decisions]]).

Around it, a support constellation: [[../archaeology/ts-google-automation|ts-google-automation]] generating beta welcome kits and surveys, [[../archaeology/pelican-ai-strategy|pelican-ai-strategy]] — a CrewAI "AI co-founder" meant to keep strategy grounded in the actual codebase. That crew never ran; the *need* was real, and it is exactly what steel's markdown governance and drift-check later delivered without a Python runtime. Two portfolio experiments ([[../archaeology/sanity-ai-portfolio|sanity-ai-portfolio]], [[../archaeology/portfolio-markdown-site|portfolio-markdown-site]]) flare and fade in the same window — both forks of other creators' visions, both mined for patterns, neither the identity.

aida pauses January 13, 2026. Not abandoned — outgrown by a better question.

## Era III — Building with and for students (2026)

The ISTE 26 arc answers it: [[../archaeology/creative-lab|creative-lab]] (interactive geometry, R3F), [[../archaeology/iste-26|iste-26]] (printable lab guides), [[../archaeology/portfolio|portfolio]] (the door — built from the ground up, the operator's own vision, the URL on the business cards), [[../archaeology/creative-lab-demos|creative-lab-demos]] (live demo). Four surfaces, one pedagogy, exhibited at ISTE LIVE 2026 in Orlando. steel emerges as the hub that keeps them aligned — the pelican-ai-strategy idea, solved with markdown and PowerShell instead of a crew framework.

Post-ISTE, the production era: [[../archaeology/course-lab|course-lab]], the first repo built for the operator's *own* six-course room, founded under ratified conventions with plan-set discipline and scripted-browser verification — the exact inverse of EdCoachAi's deleted E2E suite. And [[../archaeology/project-studio-coach|project-studio-coach]], where the aida lineage's deepest lesson — *coach the human's use of AI, don't replace the work* — returns aimed at students: the coach structurally cannot reveal the library's plans until the student's own plan exists. Enforcement moved from prompts to schema. That is two years of learning in one query projection.

## Throughlines (what the dig proved)

1. **Audience narrowing is the plot.** Market → community → own room. Each pivot was toward students actually in the building.
2. **Convex is the constant.** Every substantial build since March 2025; the component ecosystem (RAG, Agent, Workflow, ProsemirrorSync, Aggregate) was adopted piecewise across four projects and is now fluent vocabulary.
3. **Markdown-as-canonical emerged three times independently** — portfolio-markdown-site's sync, studio-coach's `sync-knowledge`, steel's `build-context` — before being recognized as *the* pattern. See [[patterns]].
4. **Process matured from pain:** deleted E2E (EdCoachAi) → docs-first (sped-sync) → dated design/implementation plans (aida) → steel's spec/plan/verdict workflow with drift-check.
5. **Nothing was wasted.** The consolidation's verdict table ([[decisions]], [[../archaeology/index]]) closes seven visions and keeps zero orphans: every closed repo's best pattern is named, harvested, and pointed at a current initiative.
