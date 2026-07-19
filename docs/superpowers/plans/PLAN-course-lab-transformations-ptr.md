# PLAN-course-lab-transformations-ptr

> **For agentic workers:** REQUIRED SUB-SKILL: superpowers:subagent-driven-development or superpowers:executing-plans, task-by-task. Checkbox steps.

**Repo:** `course-lab` (`C:/Users/rplap/OneDrive/Desktop/personal/course-lab`)
**Spec:** steel `docs/superpowers/specs/2026-07-19-transformations-ptr-design.md` — read it first; it is the contract. Also read course-lab `docs/course-lab-founding-spec.md` §4 and `src/modules/QuadraticsPTR.jsx` (the template file) end to end before writing anything.
**Verified starting state (2026-07-19):** `main` clean at PR #15; `npm test` 30/30 (incl. registry guard `src/registry.test.jsx`); live at <https://course-lab-two.vercel.app>, auto-deploys from `main`.
**Goal:** `transformations-ptr` — PTR rounds → earned sandbox for `F-BF.B.3`, quadratic + absolute value, one standalone module file, full telemetry spine compliance.
**Architecture:** one self-contained JSX file following QuadraticsPTR's shape (file-local atom kit — house ruling: single-file module artifacts, spec §5); families and rounds as data tables; SVG Plane plotter with CSS-transition move-moment; native range sliders.
**Tech stack:** React 18 + JSX/SVG only. The stack boundary is hard: no three/R3F/gsap, no new dependencies of any kind.
**Branch:** `feat/transformations-ptr`.

---

### Task 1: Registry row first — let the guard fail

**Files:** Modify: `src/App.jsx` (MODULES array, after `predict-test-reconcile` row)

- [ ] **1.1** `git checkout -b feat/transformations-ptr`
- [ ] **1.2** Add the registry row (module file does not exist yet):

```jsx
  { id: "transformations-ptr", title: "Function Transformations PTR", load: () => import("./modules/TransformationsPTR.jsx") },
```

- [ ] **1.3** Run `npx vitest run src/registry.test.jsx` — expect the guard suite to FAIL (length mismatch "registers every module file exactly once" and/or an unresolvable-import error from the 13th generated per-module test — either red line is the proof). The guard is doing its job.

### Task 2: Module skeleton — make the guard green

**Files:** Create: `src/modules/TransformationsPTR.jsx`

- [ ] **2.1** Create the file with exports + data tables + a stub default export:

```jsx
import React, { useState, useMemo, useEffect, useRef, useContext, createContext } from "react";
import { useTelemetry } from "../lib/TelemetryContext";

// Bump on pedagogically meaningful change only (spec §4.6); roundIds are append-only.
export const MODULE_VERSION = "1.0.0";

// Read by the StartGate: round_enter fires from the studentCode dismissal (spec §8).
export const TELEMETRY_ENTRY = { roundId: "vshift-quad-plus3", guideState: "predict" };

// F-BF.B.3 — a·f(x+h)+k on two families; later families APPEND here (design ruling).
const FAMILIES = {
  quad: { label: "y = x²", f: (x) => x * x },
  abs: { label: "y = |x|", f: (x) => Math.abs(x) },
};

// Append-only, parameter-coupled (spec §4.6).
const ROUNDS = [
  { roundId: "vshift-quad-plus3", family: "quad", a: 1, h: 0, k: 3,
    prompt: "Where does f(x) + 3 send the parabola?",
    choices: [["up", "Up 3"], ["down", "Down 3"], ["left", "Left 3"], ["right", "Right 3"]],
    correct: "up" },
  { roundId: "hshift-quad-plus2", family: "quad", a: 1, h: 2, k: 0,
    prompt: "Where does f(x + 2) send the parabola?",
    choices: [["left", "Left 2"], ["right", "Right 2"], ["up", "Up 2"], ["down", "Down 2"]],
    correct: "left" },   // the trap round — most students pick "right"
  { roundId: "stretch-reflect-abs", family: "abs", a: -2, h: 0, k: 0,
    prompt: "What does −2·f(x) do to y = |x|?",
    choices: [["flip-stretch", "Flips it over the x-axis and makes it steeper"],
              ["flip-shrink", "Flips it and makes it wider"],
              ["stretch", "Just makes it steeper, still opens up"],
              ["shift", "Slides it down 2"]],
    correct: "flip-stretch" },
];

// Producer target (fixed, single-scenario convention §4.2): −1·f(x+2)+3 on |x|.
const PRODUCER = { roundId: "producer-abs-n1-h2-k3", family: "abs", a: -1, h: 2, k: 3 };
const SANDBOX_ROUND_ID = "sandbox-free-play";

export default function TransformationsPTR() {
  return <section>transformations-ptr skeleton</section>;
}
```

- [ ] **2.2** Run `npm test` — expect all green (30 + the new per-module guard test = 31; assert "all green", not the number).
- [ ] **2.3** Commit: `git add src/App.jsx src/modules/TransformationsPTR.jsx && git commit -m "feat: transformations-ptr registry row + telemetry-contract skeleton"`

### Task 3: Copy the atom kit + Plane with transform support

**Files:** Modify: `src/modules/TransformationsPTR.jsx`

- [ ] **3.1** Copy from `QuadraticsPTR.jsx` verbatim into the new file (house ruling — single-file artifacts, do NOT extract a shared module): `C` tokens, `FONT_DISPLAY`/`FONT_BODY`, `copyText` + `nextCopyId`, `isFiller`, `Coach`, `Btn`, `Field`, `NumField`, `StageTag`, `H`, `P`, `RecapRow`, `CopyResults`, `SessionContext` + `useSessionReport`, and the shell `App` pattern (session store + header + CopyResults footer) with the header retitled `F-BF.B.3 · Function Transformations` / "Predict → Test → Reconcile".
- [ ] **3.2** Adapt `Plane` for this module: y-range must span negatives (reflections): `yMin = -10, yMax = 10`; add an x-axis line at y=0 (QuadraticsPTR's Plane already emphasizes it — keep). Add transformed-curve rendering: the plotted polyline gets `style={{ transition: "all .6s ease" }}` so a parameter change animates the move-moment. Plot two curves in TEST phases: original family `f` as dashed ghost (`strokeDasharray="5 4"`, `C.sub`), transformed `(x) => a * f(x + h) + k` solid (`C.ember`).
- [ ] **3.3** Run `npm run dev`, open the module through the picker (code `DEMO01`), confirm the skeleton renders with a plotted ghost curve. Commit: `feat: transformations-ptr atom kit + transform-capable plane`.

### Task 4: Rounds 1–3 — predict / commit / reveal / reconcile

**Files:** Modify: `src/modules/TransformationsPTR.jsx`

- [ ] **4.1** Implement the round engine over `ROUNDS` as data — one active round index, per-round state `{ pick, why, committed, reconciled }`. Phases per round: **predict** (choice buttons from `round.choices` + why-`Field`, thin-answer nudge via `isFiller`, transformed curve HIDDEN) → **test** (on commit the transformed curve renders/animates; verified-praise `Coach` — praise only the checked call) → **reconcile** (round 2 ONLY: mandatory reconcile prose ≥ 12 chars before advancing — it is the trap round; rounds 1/3 advance directly).
- [ ] **4.2** Telemetry — all emits inside named handlers (spec §4.4), using `useTelemetry()`:
  - `commitRound(round)`: `emit({ roundId: round.roundId, guideState: "predict", action: "check", result: pick === round.correct ? "match" : "miss" })`
  - `advanceRound(nextRound)`: `emit({ roundId: nextRound.roundId, guideState: "predict", action: "round_enter" })` — round 1's `round_enter` comes from the StartGate (TELEMETRY_ENTRY); do NOT emit it again on mount.
  - No `reset` action exists in this module (post-reveal start-over only, structurally zero — same as QuadraticsPTR).
  - **`next` is also structurally zero here** — unlike QuadraticsPTR (whose `startProducer` emits `next`), every transition in this module already carries its own event; do not add `next` emits, Task 7 asserts the exact sequence. (Spec records this ruling.)
- [ ] **4.3** `npm test` green; dev-server spot check: round 2 shows the leftward move after a "right" pick and demands reconcile prose. Commit: `feat: transformations-ptr rounds 1-3 with trap-round reconcile`.

### Task 5: Producer round

**Files:** Modify: `src/modules/TransformationsPTR.jsx`

- [ ] **5.1** After round 3: `startProducer` handler (`emit({ roundId: PRODUCER.roundId, guideState: "producer", action: "round_enter" })`). Render the TARGET curve (solid, `C.violet`) from `PRODUCER` params next to the dashed base `|x|` ghost; three `NumField`s for `a/h/k`; live preview of the student's `a·f(x+h)+k` (third curve, `C.ember`) once all three parse.
- [ ] **5.2** `checkProducer` handler: exact equality `(aN === -1 && hN === 2 && kN === 3)` → `emit({ roundId: PRODUCER.roundId, guideState: "producer", beatId: "producer", action: "check", result: ok ? "match" : "miss" })`. Unlimited retries; after any miss show redirect `Coach` + ghost `Btn` "I'm stuck — move on anyway" (sets `stuck`, allows advancing without a match — no-wall principle).
- [ ] **5.3** `finishRounds` handler on advance from producer: `emit({ roundId: PRODUCER.roundId, guideState: "producer", action: "complete" })` → recap phase. Commit: `feat: transformations-ptr producer round`.

### Task 6: Recap + earned sandbox

**Files:** Modify: `src/modules/TransformationsPTR.jsx`

- [ ] **6.1** Recap: `RecapRow`s (locked calls + why-texts per round, producer params + attempts) + `CopyResults` lines + `useSessionReport` (record when round 1 committed, same pattern as QuadraticsPTR).
- [ ] **6.2** Sandbox, revealed from recap by a named handler `enterSandbox`:

```jsx
const sandboxEntered = useRef(false);
const enterSandbox = () => {
  setShowSandbox(true);
  if (!sandboxEntered.current) {
    sandboxEntered.current = true;
    // Earned reveal fires when the student USES the unlocked reveal (2026-07-09 ruling).
    emit({ roundId: SANDBOX_ROUND_ID, guideState: "sandbox", action: "reveal_earned" });
  }
};
```

Sandbox UI: family toggle (two `Btn`s), three native `<input type="range">` sliders — `a ∈ [-3, 3] step 0.5` (skip 0 → clamp to ±0.5), `h ∈ [-5, 5] step 1`, `k ∈ [-5, 5] step 1` — live equation readout (`−2·f(x + 1) − 3` style), ghost + transformed curves with the CSS transition. **Slider `onChange` emits nothing** (drag-telemetry NOT-DOING).
- [ ] **6.3** `npm test` green, `npm run build` clean. Commit: `feat: transformations-ptr recap + earned sandbox`.

### Task 7: Scripted browser verification

**Files:** Create (scratchpad, not committed): `transformations-verify.mjs`. Load-bearing facts: scripted Playwright against `npm run dev` (localhost:5173); if the Chrome extension is down use the global-install fallback (import playwright from `C:/Users/rplap/AppData/Roaming/npm/node_modules/@playwright/cli/node_modules/playwright/index.mjs`, launch with `executablePath` pointing at the newest `C:/Users/rplap/AppData/Local/ms-playwright/chromium_headless_shell-*` revision); read events via `page.evaluate(() => JSON.parse(localStorage.getItem("course-lab:events") || "[]"))`. Use a fresh browser context (default) — the "yields exactly" assertion breaks against a profile carrying prior spot-check events.

- [ ] **7.1** Script drives the full loop on `npm run dev` with `DEMO01`: R1 correct pick → commit; R2 WRONG pick ("right") → commit → reconcile prose; R3 correct; producer: one wrong triple (0,2,3) then the right one (−1,2,3); recap → enter sandbox; then assert `localStorage["course-lab:events"]` yields exactly:
  `round_enter`(vshift, from gate) → `check` match → `round_enter`(hshift) → `check` miss → `round_enter`(stretch) → `check` match → `round_enter`(producer) → `check` miss (beatId producer) → `check` match → `complete` → `reveal_earned`(sandbox-free-play, guideState sandbox) — and NO events after moving sandbox sliders.
- [ ] **7.2** Also assert every event carries the five core fields and one constant `sessionId`. Run: expect ALL PASS. Paste the event-sequence output into the PR body.

### Task 8: Coverage row + ship

**Files:** Modify: `docs/family-coverage.md` (append-update — never fork a v2)

- [ ] **8.1** Append to §1 inventory (row 30) and §2 grid:

```
| 30 | `transformations-ptr` | TransformationsPTR.jsx | PTR | F-BF.B.3 |
| `transformations-ptr` | ☐ | ✔ (U2 transformations; ~10 lessons) | ✔ (U4 transformations) | ☐ | ☐ | ~ |
```

Bump the §1 heading "(29 units)" → "(30 units)". Update the §3 Algebra II content-gap row: transformation lessons now covered; complex numbers / sequences / trig remain. Note: the BRCC `~` cell deviates from the spec's "☐ elsewhere" deliberately — it matches the `quadratics-ptr` precedent row (topic fit, rigor unjudged).
- [ ] **8.2** `npm test` + `npm run build` final green. Commit: `docs: family-coverage row for transformations-ptr`.
- [ ] **8.3** Push, PR (`feat: transformations-ptr — F-BF.B.3 PTR rounds + earned sandbox`) with the event-sequence evidence, self-merge (`Merge: …` subject). Merge auto-deploys to the production URL. Update steel hub card status line + sprint session log (hub edits uncommitted).

## Edge cases a weaker model would miss

- **Round 1's `round_enter` comes from the StartGate** via `TELEMETRY_ENTRY` — emitting it again on mount double-counts the entry and violates §4.4 (no effects). Only rounds 2+ emit `round_enter`, from the advance handler.
- **`reveal_earned` is once-per-mount** (the `useRef` flag): re-opening the sandbox from recap must not re-emit. It rides `sandbox-free-play`, not a ROUNDS id.
- **The trap round's `miss` is the point.** Do not soften round 2's choices so "right" looks obviously wrong; the reconcile prose after the miss is the pedagogy. Verified-praise-only: the Coach praises the correct call only, never the attempt.
- **`a = 0` in the sandbox** collapses the curve to `y = k` and reads as a bug — clamp the slider past 0 (±0.5 step skip), don't special-case render.
- **Producer check is exact param equality**, not curve-point sampling — `0.5`-off answers are misses, and that's correct (the standard is about reading parameters).
- **CSS transition on polyline `points` does not interpolate in all browsers** — if the move-moment doesn't animate on school Chrome, fall back to transitioning a `transform` on the original polyline's `<g>` (translate/scale from the same a/h/k) and keep the recomputed points as the settled state. Do not add an animation library.
- **Sliders emit nothing**, but React re-renders per input event — derive curves with `useMemo` on `[a, h, k, family]` if plotting feels janky; do not throttle with timers.
- **This module has no `reset` emit site** — a start-over button on recap resets state but is post-reveal; per §4.5 course-lab resets are structurally zero. Do not add a reset emit "for completeness."

## Acceptance criteria

- `npm test` green (registry guard row included), `npm run build` clean, zero new dependencies.
- Scripted browser pass produces exactly the Task-7 event sequence, including the sandbox `reveal_earned` and silent sliders.
- Trap round demands reconcile prose after a miss; sandbox unlocks only after producer completion.
- `docs/family-coverage.md` row appended; PR self-merged; production URL serves the module.

## Explicitly out of scope

- Families beyond quad/abs (append to `FAMILIES`/`ROUNDS` later); `f(kx)` round (deferred with trig).
- Drag-the-curve interaction, any animation library, shared component extraction, backend anything.
