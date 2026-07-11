# PLAN-cse-classifier-regression

**Repo:** `creative-lab-demos` (`C:/Users/rplap/OneDrive/Desktop/personal/creative-lab-demos`)
**Branch:** create `fix/cylinder-circle-threshold` from `main` before any edit.
**Verified starting state (2026-07-11):** `main` clean, but `pnpm vitest run` FAILS: 2 failed / 42 passed. Both failures in `app/utils/classifyShape.test.ts` — `cylinder > horizontal cut → circle` (line 195) and `cylinder > shallow 20° tilted cut → circle` (line 210). Both expect `"circle"`, receive `"ellipse"`.

## Goal

Make the classifier and its tests agree, with the pedagogically correct behavior: a horizontal cut through a cylinder IS a circle — if the shipped code labels it "ellipse", that is a user-facing bug on the live demo (creative-lab-demos.vercel.app), not just a stale test.

## Root cause (already located — verify, don't re-derive)

Commit `032e839` ("fix: physics polish — … shape thresholds") changed `classifyShape.ts` line ~250 from a single `aspect2d < 1.2` circle threshold to `const circleThreshold = solidId === "cylinder" ? 1.05 : 1.1`. The two failing tests were written against the 1.2 threshold (the line-210 test's comment still says "below 1.2 threshold") and were not updated. Open question you must answer empirically: why does `circle3D(1.0, 64)` — a perfect circle, aspect ≈ 1.0 — now classify as ellipse? Aspect 1.0 < 1.05 should pass, so something upstream (hull/dedupe interplay at 64 segments, or `minAreaBBox`) is inflating `aspect2d` above 1.05. Print `aspect2d` for the failing fixtures before choosing a fix.

## Steps

1. Branch. Run `pnpm vitest run` to confirm the 2 failures reproduce.
2. Instrument locally (temporary console.log or a debug assertion) to capture `hullN` and `aspect2d` for both failing fixtures. Record the values in the PR description.
3. Decide the fix by this rule, not by taste:
   - If `aspect2d` for a true horizontal cut is genuinely > 1.05 (numeric noise from hull/dedupe), the threshold is too tight for its own inputs → loosen the cylinder threshold to the smallest value that passes a horizontal cut with margin (and keep it below the 20°-tilt visual-indistinguishability case ≈ 1.06 passing, per the test's intent).
   - If `aspect2d` is ≈ 1.0 and something else mislabels, fix that upstream defect instead and leave the threshold.
4. Check the live behavior claim: `pnpm dev`, select cylinder, drag a flat (untilted) cut — the label must read "circle". This is the observable acceptance, not just the unit tests.
5. Remove instrumentation. Update the stale "below 1.2 threshold" comment at test line ~209 to name the actual threshold.
6. Commit, PR to `main`, self-merge allowed. One concern: this PR touches only `classifyShape.ts` and/or its test file.

## Edge cases

- The cube path (`isPrism`) is untouched — do not widen the fix into the invariant-gate table (lines 226–246); the hexagon-from-cube behavior is load-bearing for the demo's core moment.
- `cone` parabola branch (`aspect2d > 2.5`) is unrelated; leave it.
- Do NOT "fix" by changing the test to expect `"ellipse"` — a horizontal cylinder cut labeled ellipse is pedagogically wrong for a geometry teaching demo (ground truth outranks the shipped constant).

## Acceptance criteria

- `pnpm vitest run` → 44/44 passing.
- Manual: horizontal cylinder cut labels "circle"; a steep (>30°) tilt still labels "ellipse".
- PR description records the measured `aspect2d` values and which of the two fix rules applied.
