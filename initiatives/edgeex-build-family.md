# Initiative — EdgeEx Build Family

**Vision:** A family of supplemental interactive builds aligned to the EdgeEx Algebra II/III courses — the agile layer on top of the district curriculum, never a replacement. The leverage fact from [[../wiki/edge-ex-courses]]: ~20 lessons overlap between the two courses; build once, serve both preps.

**Current state (2026-07-22):** Two-build slate, with a gate between them ([[../wiki/decisions]] 2026-07-22 — fewer, deeper).

1. **transformations-ptr** (`F-BF.B.3`) — fully scoped and ready to execute: spec `docs/superpowers/specs/2026-07-19-transformations-ptr-design.md`, plan `docs/superpowers/plans/PLAN-course-lab-transformations-ptr.md`, home ruled **course-lab** ([[../wiki/decisions]] 2026-07-19). PTR rounds → earned sandbox; quadratic + absolute value v1, families as data. Ships as specced — four rounds, two families; a third family is scope creep, not depth.
2. **Build two — unnamed, gated.** Does not get scoped until build one has run with real students and cleared the depth criteria. Candidate concept comes from the reuse ranking in [[../wiki/edge-ex-courses]] §Cross-course overlap (graphing function families with key features is next in line), but the choice is made *after* reading build one's data, not before.

**The gate:** depth criteria doc (one page, `wiki/`) written after the transformations-ptr PR lands and before the first class period — round-2 miss-rate band, reconcile quality, commit-before-reveal comparison, producer retry / ghost-path counts, plus two thresholds: what greenlights build two, and what sends build one back for revision.

**Why only two:** the 2026–27 assignment is two preps, not six. The course-lab infrastructure was sized for the larger workload, so the shrink is slack to spend on depth — student data per build, not more builds.

**Harvested inputs:** [[../wiki/patterns]] §5 (durable stage machine — any multi-round module must survive a closed Chromebook lid), §6 (resilient sink), §1 (if the family grows a lesson-alignment corpus, it starts as markdown + sync). creative-lab's earned-reveal round structure ([[../archaeology/creative-lab]]) is the pedagogy template.

**Next sprint-sized slice:** execute `PLAN-course-lab-transformations-ptr` (eight tasks, fail-first registry row, branch `feat/transformations-ptr`). The brainstorm slice closed 2026-07-19. Subsequent slices: one build per sprint at most, each tagged to its EdgeEx lesson IDs so reuse across both courses is checkable, each gated on the previous build's student data.
