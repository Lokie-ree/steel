# Creative Lab × ISTE+ASCD 26: Alignment Findings

*A formal record of what was discovered about Randall's body of work and how it
sits within the ISTE+ASCD 26 conference frameworks. This document is evidence,
not strategy. Strategy — including the question of what (if any) public-facing
post to write, and what framing it should use — is deliberately left open.*

*Date drafted: ISTE 26 sprint, ~45 days out.*

---

## Section 1 — What Randall Built

Four production-shipped pieces, covering grade 8 geometry standards 8.G.A.1
through 8.G.B.8:

| Piece | Standards | Status |
|---|---|---|
| **M1 — Rigid Motions** | 8.G.A.1–3 | Shipped, all 4 phases complete |
| **M2 — Dilations & Similarity** | 8.G.A.3–5 | Shipped, all 4 phases complete |
| **M3 — Pythagorean Theorem** | 8.G.B.7–8 (covers B.6 via visual proof) | Shipped, all 4 phases complete |
| **CSE — Cross-Section Explorer** | 8.G.C.9 adjacent; whole-body geometry | Shipped, demo for ISTE exhibit |

Stack: React 19 + TypeScript + R3F + GSAP + Tailwind. Single state per module
via `useReducer`. Standalone CSE uses React Router v7 (SPA).

### Cross-module architectural patterns (documented in the architecture files)

These patterns are present in M1, M2, and M3 — not as coincidence, but as
documented design constraints:

- **Earned-reveal system.** `EARNED_REVEALS: Partial<Record<RoundId, EarnedReveal>>`,
  `shownReveals: Set<string>` persisting across rounds, `isFirstReveal` gate.
  The student earns the reveal by completing the prediction task; the formal
  notation then appears as discovery, not as instruction.
- **One-way visibility flags.** `coordinatesVisible`, `formulaVisible`,
  `converseVisible`, etc. flip `true` and stay `true`. Represents permanent
  unlock milestones — the system never takes things back.
- **`handleNext` records-reveal-key-before-dispatch.** React 18 batching fix:
  recording in `handleCheck` would make `firstMatch` always false. Recorded
  in M1's lessons-learned and replicated in M2 and M3.
- **SpriteLabel (CanvasTexture → PlaneGeometry).** Never drei `<Text>`. Reason
  documented: troika-three-text creates secondary WebGL contexts that exhaust
  the browser's context limit in StrictMode dev.
- **No `<primitive object={new THREE.X()}>` in JSX.** Geometries created in
  `useMemo` or `useRef`, attached in `useEffect`, disposed on cleanup.
- **Pure math files, separately tested.** `transform-math.ts`,
  `match-scoring.ts`, `classifyShape.ts` are pure functions with dedicated
  test files. M1 alone has ~111 tests across six test files.

CSE shares the *spirit* but not the literal patterns:
- CSE uses a `mode + solid + completion-set` matrix instead of `currentRound`.
- CSE uses HTML overlays for labels (ShapeLabel) rather than SpriteLabel for
  in-scene text, because the labels sit above the canvas, not inside the scene.
- CSE's "earned reveal" is the connection sentence after both modes complete
  on the same solid — gated by `connectionDismissed`, auto-hidden after 4s.

### CSE-specific engineering depth (from the code review)

Worth recording because it's load-bearing evidence for any "this is engineered,
not assembled" claim:

- **`classifyShape` pipeline** absorbs six documented classes of CSG
  triangulation noise: fan-centroid prepending, 3D dedup insufficiency,
  hull-tolerance asymmetry, scale-relative collinearity, rhombus projection,
  geometric-invariant gating (a cone cannot produce a quadrilateral
  cross-section; the gate enforces this).
- **`JoystickGizmo`** uses separate `heightRef` and `tiltQuatRef` (avoiding
  matrix-element-13 reads after rotation mixes in), samples camera-right
  *once* at drag start for gesture stability, uses `setPointerCapture` on the
  canvas (not the handle) for off-handle drag continuity, and stops the
  affordance pulse after first interaction.
- **`ShapeLabel`** has two synthesis sentences doing different pedagogical
  work: retrospective ("that cross section — it's the shape you started with")
  when arrived at from cross-section mode; prospective ("slice this solid —
  you'll find the shape you swept from") when arrived at from rotation mode.
- **`prefersReducedMotion` honored in three separate files** for three
  separate animation systems. Accessibility is a system commitment, not a
  one-off.
- **Rapier physics is lazy-loaded and deliberately decoupled.** `physicsMode`
  resets on every navigation action. The state model knows about it; the
  pedagogy does not depend on it.

---

## Section 2 — The ISTE+ASCD 26 Framework Landscape

Three official framework layers govern the conference. All sessions are tagged
into them. They are the controlled vocabulary.

### Layer 1 — Transformational Learning Principles (TLPs)

The pedagogy framework. Co-developed by ISTE and ASCD. Eight sub-principles in
three categories. Every ISTE 26 session is tag-filtered against these.

**Nurture**
- Cultivate Belonging
- Connect Learning to the Learner
- Ensure Opportunity

**Guide**
- Spark Curiosity
- Develop Expertise
- Elevate Reflection

**Empower**
- Prioritize Authentic Experiences
- Ignite Agency

Source: https://iste-ascd.org/tlps. Full definitions captured in Workstream 1
(`iste-narrative.md`).

### Layer 2 — Profile of an AI-Ready Graduate

The AI-era framework. Authored by Richard Culatta (CEO of ISTE+ASCD). Six core
"roles" students take on alongside AI. Centerpiece of the ISTE 26 Pavilion via
six themed stations.

The six roles (per Culatta's canonical ASCD blog, not the popular
write-ups which use "Ideator" for the fourth):

- **Learner** — uses AI to set learning goals, seek feedback, get unstuck
- **Researcher** — uses AI to investigate, evaluate claims, compare sources
- **Synthesizer** — uses AI to bring information together, illuminate
  connections, adapt across formats and levels
- **Problem Solver** — uses AI as a brainstorming partner for ideas and
  alternative perspectives
- **Connector** — uses AI to facilitate human collaboration across languages
  and perspectives
- **Storyteller** — uses AI to present complex ideas via text, image, audio,
  video

Source: https://www.ascd.org/blogs/profile-of-an-ai-ready-graduate

**Critical scope note**: All six roles, as Culatta defines them, involve
students *actively using AI tools*. The framework is about AI tool use.
Creative Lab does not involve students using AI tools.

### Layer 3 — Topic taxonomy

The granular session filters from the ISTE 26 program search. Most relevant
categories for grade 8 geometry / R3F work:

- Curriculum and Instruction: Curriculum Design, Instructional Design and
  Strategies, Personalized Learning, Virtual and Blended Learning
- Emerging Tech: AI, Emerging Technologies (AR/VR/XR), Games for Learning,
  Innovative Learning/Making/Fabrication
- Serving All Students: Cognitive Development and the Science of Learning,
  Universal Design For Learning
- Student Engagement: Creativity and Storytelling, Innovative Learning
  Environments, Project-/Problem-/Challenge-Based Learning, Student
  Engagement and Agency
- Subject: Mathematics, Interdisciplinary STEM/STEAM, Engineering
- Grade band: 6–8

### Signature spatial experiences at ISTE 26

Not lecture rooms — physical-space curations that are themselves themes:

- **Playgrounds: Where Play Is the Point** — large-scale, hands-on, immersive,
  educator-led
- **Creativity Crossroads** — student and educator projects where imagination,
  wonder, learning, and creativity intersect (Dan Ryder is presenting here)
- **Profile of an AI-Ready Graduate Pavilion** — six themed stations with
  educator stories, student work, hands-on challenges, short stage talks

---

## Section 3 — Where the Work and the Frameworks Touch

This is the empirical map. What follows are alignments supported by the
architecture files and the shipped code, not speculative bridges.

### Strong, direct TLP alignments

These are the alignments where the evidence is in the architecture, not in the
narration:

**Spark Curiosity.** *Connect content to prior knowledge, create new pathways
for engagement.*
- CSE's hexagon-from-diagonal-cube is the explicit "wait WHAT?" moment.
- M3's Phase 1 asks the student to predict the hypotenuse-square area before
  revealing the formula — the formula emerges from the curiosity, not the
  reverse.
- M1's `synthesis-reveal` state and M3's `proof-properties` pause are
  architecturally-named curiosity-pause states.

**Develop Expertise.** *Frame learning around key conceptual understandings,
multiple modes of presentation and inquiry, intentional practice.*
- Three modules sharing the same architectural patterns (earned reveal,
  one-way flags, pure math files, SpriteLabel) means the student encounters
  multiple geometry topics through one consistent interactional vocabulary.
- 8.G.A.1 through 8.G.B.8 covered systematically.
- Each module has a capstone (M1 SequenceBuilder, M2 AA-capstone, M3
  coordinate-distance, CSE connection moment) where conceptual understanding
  is tested by construction, not recall.

**Elevate Reflection.** *Timely feedback, time and support to reflect.*
- Round-based pacing across all modules creates explicit reflective beats.
- CSE's 4-second connection-sentence auto-hide is a beat, not a banner —
  designed restraint.
- The earned-reveal pattern itself is a reflection mechanic: the student
  completes the task, then sees the formal notation that describes what they
  just did. The notation is a mirror.

**Prioritize Authentic Experiences.** *Students as designers, creators,
problem-solvers.*
- Students drag, cut, rotate, predict, and construct. They do not select from
  multiple-choice options.
- CSE's joystick gizmo and M1/M2's sequence builders put the student in the
  operator role.

**Ignite Agency.** *Learner-led approaches, follow intellectual pursuits, take
risks, make discoveries.*
- M1's `predict-translate` / `predict-reflect` / `predict-rotate` flow is
  literally a predict-then-verify loop — risk is built into the task.
- CSE's rotation builder lets the student pick the silhouette.
- The pulse-then-trust pattern in CSE's gizmo (handle pulses for affordance,
  stops after first interaction) treats the student as capable of
  remembering.

### Moderate or indirect TLP alignments

**Connect Learning to the Learner.** Present at the system level (round-based
copy adapts pacing; earned reveals don't force-feed students who already get
it) but not as a per-learner personalization system.

**Cultivate Belonging.** Present at the interaction-design level (round-based
pacing reduces fear of failure; no high-stakes single moments) but not as a
relationship/community feature.

**Ensure Opportunity.** The work doesn't require prior vocabulary to begin —
interaction is the entry point, vocabulary attaches after. Real but indirect.

### Topic-taxonomy alignments

Direct fits: Mathematics (subject); 6–8 (grade band); Innovative Learning
Environments; Creativity and Storytelling; Curriculum Design; Instructional
Design and Strategies; Project-/Problem-/Challenge-Based Learning; Student
Engagement and Agency.

Defensible fits: Emerging Technologies (AR/VR/XR) — CSE is browser-based 3D,
not literal AR/VR, but lives in the same "spatial reasoning through immersive
tech" lane.

Non-fits: AI; Personalized Learning (in the algorithmic sense); Virtual and
Blended Learning (in the LMS sense).

### Profile of an AI-Ready Graduate alignment — the honest version

Following Culatta's framing, every one of the six roles involves students
*using AI tools*. Creative Lab does not involve students using AI tools.

There are two ways to position this honestly:

1. **Adjacent but not aligned.** Creative Lab cultivates cognitive habits
   (synthesis, pattern recognition, predict-then-verify) that are *useful*
   when students later use AI tools, but the work itself is not an AI-tool
   workflow. This is a plausible argument but not one the Profile framework
   was built to accommodate. It also has no empirical support — there is no
   evidence that students who use Creative Lab become better AI users.

2. **Outside the framework's scope, and that's fine.** The Profile is one
   framework among several. Not every grade 8 math intervention needs to be
   AI-aligned. Creative Lab's relationship to the Profile is "this is the
   kind of conceptual grounding that the Profile takes for granted." That's
   a defensible non-claim.

The second positioning is the more honest one. The first one requires
constructing a bridge the work doesn't yet earn.

---

## Section 4 — Cross-Module Pedagogical Pattern

This is the strongest single observation surfaced by reading the architecture
files alongside each other:

**Each of the four pieces collapses a distinction students normally hold as
separate.**

- **M1:** Spatial reasoning (dragging triangles) and coordinate algebra
  ((x,y) → (x+a, y+b)) describe the same transformations. The `synthesis-reveal`
  state makes this explicit between Phase 2 (spatial) and Phase 4 (capstone
  sequence-building using both).
- **M2:** Similarity is *decomposable* into rigid motion + dilation. The
  similarity sequence builder forces the student to *construct* the
  transformation that proves similarity, not just recognize it.
- **M3:** The Pythagorean theorem and the coordinate-plane distance formula
  are the same theorem. Phase 4 makes the connection by hiding the triangle
  and asking for the distance between two points, then revealing the right
  triangle underneath.
- **CSE:** Cross-sectioning and rotation produce structurally related solids.
  The connection sentence makes this explicit after both modes are completed
  on the same solid.

This is not the same as "Synthesizer" in Culatta's framework. It is a
*mathematics-education* claim about how the modules teach: each one performs a
de-fragmentation move where the student arrives believing X and Y are
different and leaves understanding they are the same thing in different
clothes.

This pattern is supported by:
- The architectural naming (`synthesis-reveal` in M1; `proof-properties` in M3
  as a synthesis-pause)
- The earned-reveal mechanic itself (which presents the formal notation at the
  moment the student has already done the thing the notation describes)
- The capstone structures (each ends with a construction task that requires
  the synthesis to be operational, not just understood)

**Whether this pattern is the spine of any public-facing post is a separate
question.** The pattern is real. Its audience and framing are TBD.

---

## Section 5 — Presenter Landscape

Tracker maintained separately (`iste-tracker-final.html`). Tier 1 targets:

- **Aleata Hubbard Cheuoua** — existing connection, math + humanizing/AI
- **Olga Kazarina** — "Design Interactive Learning: A Pedagogy-First Approach
  for Teachers." Her session thesis is your portfolio's tagline in different
  words.
- **Monica Burns** — instructional design / engagement
- **Lee Ann Crawford & Kim Sebek** — TBD on session focus

Tier 2 / backup: Sabba Quidwai, Dan Ryder, Sawsan Jaber, Cristobal Alvares.

Detailed per-presenter briefs are Workstream 2 (not yet drafted).

Field calibration note: the ISTE 25 / ISTE 26 program ecosystem is dominated
by AI, instructional coaching, digital citizenship, and general edtech tools.
Subject-matter-specific, content-deep, production-grade interactive modules
targeting named standards in grade 8 math are a real but **under-served**
topic-taxonomy lane. The room is not crowded in Creative Lab's specific niche.

---

## Section 6 — What Was Discovered That Wasn't Obvious

Things the research surfaced that weren't visible from the inside:

1. **The conference's controlled vocabulary overlaps your portfolio's
   vocabulary.** The TLPs page uses "joyful," "curiosity," "agency" — these
   are words you already use. Not adjacent; overlapping.

2. **Olga Kazarina's session thesis is your tagline.** "Design Interactive
   Learning: A Pedagogy-First Approach for Teachers" is the literal
   description of what Creative Lab is. This is the warmest pre-existing
   target on the floor.

3. **The lane is under-served, not overcrowded.** The ISTE program search
   confirms this. Subject-deep grade 8 math interactive modules with
   production polish are a niche; you're not entering a crowded space.

4. **Your cross-module architectural consistency is documented in the
   architecture files themselves.** Lessons learned in M1 reappear as
   constraints in M2 and M3. The earned-reveal pattern is named and described
   in each module's docs. You have written receipts for the pattern claim.

5. **CSE's engineering depth is non-trivial.** The `classifyShape` pipeline
   absorbs six documented classes of CSG noise. The `JoystickGizmo` has
   five interaction-design choices that show field-tested defensive coding.
   This is "engineered system," not "demo."

6. **The four-module pattern (collapsing distinctions) is real.** It is
   supported by the architecture, not just narrative. It is a
   mathematics-education claim, not an AI-readiness claim.

---

## Section 7 — Process Note: Where the Drift Happened

For the record, because naming it makes it less likely to recur.

The research plan started clean (Workstream 1, completed). The CSE code review
surfaced specific evidence about what was built. Then, in the move from
evidence to outline, the mentor anchored the post on the Profile of an
AI-Ready Graduate framework and began constructing a "cognitive habits before
AI tools" bridge.

The user pushed back twice:

1. First, that the framing left out the three-module arc. *Correct catch.* The
   framing was narrowed to CSE without justification.
2. Second, that the work doesn't actually map to students "touching an AI
   tool." *Correct catch.* The bridge was rhetorical, not empirical.

Workstream 1's own forbidden-moves list (Section C of `iste-narrative.md`) had
already warned against this exact drift: *"do not drift into 'humanizing math
with AI' — that's Aleata's lane."* The drift happened anyway, in a different
direction (using AI-readiness framing to position the work, rather than to
claim the work *does* AI-readiness).

**The lesson, captured for future reference:** when a framework requires
bridging to fit the work, the framework is the wrong framework. Pick a frame
the work earns without effort, or invent one. Creative Lab earns
mathematics-education framings without effort. It does not earn AI-readiness
framings without bridging. Therefore, mathematics-education framings are the
honest ones.

---

## Section 8 — Open Questions (Left Deliberately Open)

These are decisions the user retained, not decisions to be made by the
mentor:

1. **Is a public-facing post the right Workstream 3 deliverable?** The
   original research plan named one. The plan can be revised. A LinkedIn
   thread, a presentation-narrative document for the ISTE poster, or a private
   "what I built" document for sharing in DMs are all alternatives.

2. **If a post: who is the audience?** Math educators (NCTM-adjacent),
   interactive learning designers, R3F developers, generalist edtech, or
   curious peers — these are different audiences requiring different framings.

3. **If a post: what is the spine?** Mathematics pedagogy
   ("collapsing distinctions"), interactive design ("earned reveals"),
   portfolio tour ("here's what I built"), or something else.

4. **What is the relationship between Creative Lab and AI in any future
   work?** Open question. The current body of work is not AI-aligned and
   doesn't need to be. Whether the *next* module engages AI is unsettled and
   not on the 45-day sprint critical path.

---

## Appendix — Source Documents

- `iste-narrative.md` — Workstream 1 deliverable (this conversation, earlier
  turn)
- `iste-tracker-final.html` — presenter tracker (project files)
- `rigid-motions-architecture.md` — M1 as-built (project files)
- `dilations-and-similarity-architecture.md` — M2 as-built (project files)
- `pythagorean-theorem-architecture.md` — M3 as-built (project files)
- `cse-architecture.md` — CSE as-built (project files)
- `CLAUDE_PORTFOLIO.md` — portfolio reference (project files)
- TLP source: https://iste-ascd.org/tlps
- AI-Ready Graduate source: https://www.ascd.org/blogs/profile-of-an-ai-ready-graduate
- ISTE 26 program: https://conference.iste.org/2026/program/