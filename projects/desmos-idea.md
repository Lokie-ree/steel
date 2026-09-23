# desmos-idea — Exemplar Studio

**GitHub:** [`Lokie-ree/desmos-idea`](https://github.com/Lokie-ree/desmos-idea), private, created 2026-09-23
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/desmos-idea`
**Live:** none. Open `index.html` in Chrome; it needs to reach `desmos.com`
**Agent entry:** this card → `README.md` (canonical) → `index.html` (the build) → `node check.js`

**Pointer card, not a spoke,** the same shape as [[still-true]] and [[loop-bench]]: no drift
enrollment, no Local-paths row, no `sync-registry.md` fields. The README is the single source for
what the tool does. When this card and the repo disagree, the repo wins.

## What it is, in one line

A single-page generator of printable function-art problem sets for Algebra II. Each motif holds
every parameter of a family fixed but one and steps that one across a range, so a picture is a
slider frozen. Equations stay hidden for a graph-to-equation challenge sheet; the answer key
prints them.

## Why it doesn't cross D-2026-08-03c

[[../wiki/decisions]] D-2026-08-03c rules out a parameterized widget library that competes with
Desmos. This tool is built **on** Desmos and produces what Desmos doesn't: seeded, printable
problem sets with an answer key. That is the line; a tweakable-manipulative mode would cross it.

## Status

Iteration 1 was built 2026-09-15 and registered 2026-09-23 (PR #1 imports it unchanged; PR #2
fixes zero terms in the answer key, e.g. seed 6 printed `y=0(x+1.86)^3+4.09`). **Not yet in front
of students.** The screen recording `full_flow.mp4` (37 MB) stays local and is git-ignored.

## Open

- **Not verified on the target device.** The only render check was headless Chromium at 1400 px
  on the hub machine. The real test is a school laptop on the district network, where the filter
  may block `desmos.com` ([[../wiki/lessons]] #6).
- The script tag carries the Desmos public demo key. Get a free key before classroom use.
- A sweep's end point can overshoot its family range (a label showed abs `a` to 4.08 against a
  range capped at 2.5).

## Open step (2026-09-23): the first project opened under the three-slot model

[[../wiki/lessons]] and [[../wiki/patterns]] were read **after** the first commits, not before;
the step exists on paper ([[../initiatives/public-identity]] §Next instances) but nothing prompts
it yet. What applied anyway:

| Source | Applied |
|---|---|
| Lessons #5, reach for what the stack ships | The Desmos docs guarantee `asyncScreenshot` captures a fully evaluated state, so a hand-rolled 320 ms wait was removed |
| Lessons #6, verify on the device | Not met; see Open above |
| Patterns §12, claims as executable checks | `check.js` is read-only, written from a real defect, and fails on the pre-fix code |
