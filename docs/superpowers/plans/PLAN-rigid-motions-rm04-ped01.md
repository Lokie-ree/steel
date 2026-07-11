# PLAN-rigid-motions-rm04-ped01

**Repo:** `creative-lab` (`C:/Users/rplap/OneDrive/Desktop/personal/creative-lab`)
**Source:** `CLAUDE.md` § Outstanding Work — RM-04 (line ~203) and PED-01 (line ~210). Both scoped by `MARCH_AUDIT.md` (docs/). Run AFTER PLAN-creative-lab-closeout PR 1 (so the tracked skill layer is on main).
**Prerequisite reading for the executor:** `src/components/modules/rigid-motions/ARCHITECTURE.md` in full — especially the SpriteLabel section (never drei `<Text>`), the React-batching lesson (#10), and the Z-layering table.

Two ordered, single-concern PRs. Pedagogy rules bind: no quizzes, no "wrong answer" messaging, earned reveals preserved (CLAUDE.md § Agent Guidelines).

## PR 1 — RM-04: in-scene coordinate labels when `coordinatesActive`

**Defect:** `coordinatesActive` is plumbed to `CoordinateGrid` but the `_coordinatesActive` parameter is unused; no per-vertex "(x, y)" annotations render in Phase 3+/capstone. On mobile capstone there is no FormulaReadout compensating.

1. Branch `feat/rm04-vertex-coordinate-labels`.
2. Add `SpriteLabel` coordinate annotations for pre-image and image/ghost vertices, rendered only when `coordinatesActive === true`. Use `scene-primitives.tsx`'s SpriteLabel (CanvasTexture → PlaneGeometry) — NEVER drei `<Text>` (WebGL context exhaustion, ARCHITECTURE.md Lessons #1–2).
3. Placement: reuse `vertexLabelOffset` from `scene-math.ts` with an additional offset so coordinate labels don't collide with the A/B/C vertex letters; z-layer 0.03 per the Z table.
4. Labels must track live ghost drag (same data path FormulaReadout uses for live vertices) and update after reveal animation completes (A′B′C′ labels appear post-animation — mirror that gating in `ImageShape`).
5. Edge cases: axis-label collision zone at ±1 (Lesson #7 — do not tighten those offsets); half-unit coordinates from free-drag display as-typed (e.g. "(2.5, −1)") — use the typographic minus, matching `formatCoordinateRule`.
6. Tests: extend `scene-math.test.ts` if you add a pure offset helper; visual verification on a phone-width viewport (≤500px) in the capstone stage.
7. Update the RM-04 bullet in CLAUDE.md (delete it — it describes the gap) in the same PR.

## PR 2 — PED-01: capstone hint only after a miss

**Defect:** `CAPSTONE_PROMPT_TEXT['capstone-3']` ends with "If your first attempt misses, try reversing the order." (`rigid-motions-copy.ts:139`) — shown at round ENTRY, leaking the non-commutativity discovery before the student has risked an attempt.

1. Branch `fix/ped01-postmiss-hint`.
2. In `rigid-motions-copy.ts`: split into a neutral entry prompt (e.g. keep "Two steps again." and stop) and a new `CAPSTONE_POST_MISS_HINT: Partial<Record<CapstoneRoundId, string>>` carrying the reversal hint for `capstone-3`.
3. In `useRigidMotionsState.ts` / `InstrumentModule.tsx`: surface the hint only when `feedbackState === 'miss'` in capstone round 3 (capstone scoring is binary match/miss — no `close` state exists there, ARCHITECTURE.md Match-scoring table).
4. Preserve the reveal mechanics: this changes prompt copy pathways, not `EARNED_REVEALS`. `CAPSTONE_EARNED_REVEALS['capstone-3']` ("Rotation and translation don't commute…") still appears only on match, unchanged.
5. Tests: `rigid-motions-copy.test.ts` exists (7 tests) — extend to assert entry copy contains no "reversing" and the post-miss hint does.
6. Update the PED-01 bullet in CLAUDE.md (delete it) in the same PR.

## Acceptance criteria

- RM-04: with `coordinatesActive`, every visible vertex shows a coordinate label on desktop AND ≤500px viewports; no label collisions at the ±1 axis zone; `pnpm build` + full vitest green.
- PED-01: capstone-3 entry shows neutral copy; the reversal hint renders only after a missed CHECK; copy tests green.
- Both CLAUDE.md bullets removed; no other Outstanding Work items touched.
