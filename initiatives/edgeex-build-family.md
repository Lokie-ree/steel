# Initiative — EdgeEx Build Family

**Vision:** A family of supplemental interactive builds aligned to the EdgeEx Algebra II/III courses — the agile layer on top of the district curriculum, never a replacement. The leverage fact from [[../wiki/edge-ex-courses]]: ~20 lessons overlap between the two courses; build once, serve both preps.

**Current state (2026-07-24):** Two-build slate, with a gate between them ([[../wiki/decisions]] D-2026-07-22b — fewer, deeper).

1. **transformations-ptr** (`F-BF.B.3`) — **shipped 2026-07-24** (course-lab PR #16), live in production. Four rounds → earned sandbox, quadratic + absolute value, families as data; spec `docs/superpowers/specs/2026-07-19-transformations-ptr-design.md`, plan `docs/superpowers/plans/PLAN-course-lab-transformations-ptr.md`, home ruled **course-lab** ([[../wiki/decisions]] D-2026-07-19). It shipped as specced; a third family is scope creep, not depth. What remains is running it with students.
2. **Build two — unnamed, gated.** Does not get scoped until build one has run with real students and cleared the depth criteria. Candidate concept comes from the reuse ranking in [[../wiki/edge-ex-courses]] §Cross-course overlap (graphing function families with key features is next in line), but the choice is made *after* reading build one's data, not before.

**The gate:** [[../wiki/depth-criteria]] — written 2026-07-24, after the PR landed and before the first class period, so the thresholds were set by judgment rather than by whatever the first data happens to look like. Four signals off the existing telemetry (round-2 miss-rate band, reconcile quality, commit-before-reveal comparison, producer retry / ghost-path counts) and two thresholds: all four in band greenlights build two; any one of four failure shapes sends build one back for a `MODULE_VERSION` bump and a second run.

**Why only two:** the 2026–27 assignment is two preps, not six. The course-lab infrastructure was sized for the larger workload, so the shrink is slack to spend on depth — student data per build, not more builds.

**Harvested inputs:** [[../wiki/patterns]] §5 (durable stage machine — any multi-round module must survive a closed Chromebook lid), §6 (resilient sink), §1 (if the family grows a lesson-alignment corpus, it starts as markdown + sync). creative-lab's earned-reveal round structure ([[../archaeology/creative-lab]]) is the pedagogy template.

**Next sprint-sized slice:** none is a build. The brainstorm slice closed 2026-07-19 and the execution slice closed 2026-07-24; the next slice is a classroom run and one read of [[../wiki/depth-criteria]]. Subsequent slices: one build per sprint at most, each tagged to its EdgeEx lesson IDs so reuse across both courses is checkable, each gated on the previous build's student data.
