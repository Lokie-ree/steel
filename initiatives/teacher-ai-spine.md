# Initiative — Teacher-AI Spine

**Vision:** The absorbed Pelican inheritance ([[../wiki/decisions]] 2026-07-18) kept alive as working capital: the RAG/ingestion/agent architecture is the *canonical* way any future teacher-facing AI gets built here, and the Louisiana corpus (Student Standards + Educator Rubric, six namespaces) stays revivable rather than rotting in a dormant repo.

**Current state (2026-07-18):** aida paused at live-beta quality (2026-01-13); corpus and ingestion functions intact in the repo; architecture documented in [[../archaeology/aida]] and [[../wiki/patterns]] §2. Pelican-as-product is closed *for now* — this initiative is deliberately not a product roadmap.

**Harvested inputs:** patterns §2 (namespace-per-domain RAG + ingestion lifecycle), §4 (metered-AI spine), §8 (server-side sessions), §9 (heuristic before LLM), §11 (domain-grounded personas — the pelican-ai-strategy agents.yaml style).

**Revival criteria (write the sprint only if one fires):** a Louisiana colleague cohort actually asks for it; a district/parish channel opens; or a current build (studio-coach, course-lab) needs the Louisiana corpus, in which case the corpus migrates to the consuming repo per pattern §1 rather than reviving Pelican.

**First sprint-sized slice (preservation, cheap, do once):** verify the aida Convex deployment's corpus can be re-ingested from source docs alone (run the ingestion path against a fresh dev deployment); record the result in the aida dossier. If re-ingestion works from markdown sources, the spine is durable and nothing else needs maintaining.
