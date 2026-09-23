# loop-bench

**GitHub:** [`Lokie-ree/Lokie-ree.github.io`](https://github.com/Lokie-ree/Lokie-ree.github.io), public, created 2026-08-24
**Local:** not cloned on the hub machine (checked 2026-09-22)
**Live:** <https://lokie-ree.github.io/loop/>. It returned 200 on 2026-09-22 and serves *"The wire that watches the tank"*
**Agent entry:** this card → `verify/verify_loop.py` (the numbers) → `loop/index.html` (the shipped face)

> **Corrected 2026-09-22.** From 08-24 until today, this card said "not a repo yet… not deployed… staged in `~/Downloads`," while the repo and Pages site were live. It's the same class as [[../wiki/lessons]] #3: the card was trusted, the artifact wasn't opened.

> **Gap this file covers:** the two HTML files are self-contained and carry no docs of their
> own, so nothing explains *why* there are two of them, which one is canonical, or which
> numbers in them were checked. This card carries the rulings; the files carry the build.

**Not a spoke, and now a pointer card with a repo**, the same shape as [[still-true]]: no drift enrollment and no Local-paths row. Filed 2026-08-23 so the hub knows the fall's most
complete build exists; before that it was invisible here — zero mentions, vault-wide.

---

## Role

Interactive simulation of a 4–20 mA current loop, built for **Algebra II / Instrumentation and P-Tech**, grounded in the Amatrol hardware in the school's CTE lab (T5552 Process Control, T5553 Thermal Process Control, pneumatic and hydraulic instrumentation modules).

First face of a planned **one engine, six faces** build — one transfer-function engine, one panel per Algebra II unit. Only the Unit 1 face exists. The remaining five (cylinder annulus, resonance, DP flow, composition skid, asymptote) are designed but unbuilt.

Not district infrastructure. Classroom instrument, one room, two sections.

**This is the Algebra II applied layer, not a separate build.** [[algebra2-course-plan]] anchors the course's applied content on the 4–20 mA loop, one hook per unit; the six faces are those hooks. It sits *inside* the 2026-08-03 build-surface ruling rather than beside it ([[../wiki/decisions]] D-2026-08-23).

## Stack

Vanilla HTML/CSS/JS in a single file each. **No dependencies, no build step, no network calls, no browser storage.** Hand-rolled SVG for the gauge and the tank scene; system font stack only, so it renders on a school Chromebook with no font loading and works offline from a USB stick.

Verification is Python 3 stdlib (`fractions.Fraction`) — exact rational arithmetic, no floats, no third-party packages.

## Files

| File | What it is |
|---|---|
| `loop/index.html` (was `loop-bench-student.html`) | **Canonical.** Student-facing. Tank scene, plain language, three modes |
| `loop/technician.html` (was `loop-bench.html`) | Technician register. LRV/URV vocabulary, four modes, calibration and fault-diagnosis |
| `verify/verify_loop.py` (was `verify-loop-bench.py`) | 59 checks over every number that appears in either file |
| `verify/verify_ladder.py` | In the repo; **not yet described on this card** |
| `shared/README.md` | Deliberately empty: it reserves `loop-engine.js` for the drift-seam fix below |

*The file mapping was read from the repo tree on 2026-09-22. The rulings below still use the old file names, because they were dated under them.*

*Sizes deliberately omitted — transcribed state that decays ([[../CLAUDE]] §Git state is derived, never transcribed).*

## The engine

One equation, everything derives from it:

```
I = 16(PV − LRV)/(URV − LRV) + 4
```

Slope `m = 16/(URV − LRV)`, intercept `b = 4 − m·LRV`. Readback is the inverse, `PV = LRV + (I − 4)(URV − LRV)/16`. Nothing else in either file computes a milliamp.

**Needle motion is a spring-damper**, not a tween: `v += (target − pos)·0.045 − v·0.276`, roughly ζ≈0.65, settling in ~0.5 s with a small overshoot. Students who have stood at a T5552 notice instantly when a needle snaps to value, and the credibility is gone in about four seconds. Respects `prefers-reduced-motion` by jumping to the settled value.

## Modes

| `loop-bench-student.html` | What the student does |
|---|---|
| Watch | Drag the tank level, watch the wire and the far-end screen move together. Equation hidden behind a fold |
| Guess the reading | Bench applies a level, meter is covered, student commits a mA value before reveal. Graded at ±0.04 mA |
| Find the rule | Three readings in a table; student answers *how much per unit* and *what it reads at empty* — slope-intercept in plain words |

| `loop-bench.html` | What the student does |
|---|---|
| Run | Three-piece decomposition: fraction of range → ×16 → +4 |
| Predict | Same as Guess the reading, technician register |
| Calibrate | Randomized zero and span error; record two points, derive the actual rule, report zero error in mA and span error in % |
| Find the fault | One of five faults inserted at random (open, zero shift, span error, reversed range, saturated); diagnose from a list |

**The wire-cut control is live in every mode of both files** and is the centerpiece. In the student file it produces the intended moment: the tank is still visibly half full, the meter reads 0.00, and the far-end screen reads `SENSOR FAULT` — *not* "empty." A working sensor can never send 0 mA, so the screen reports a broken sensor rather than an empty tank. That lands without any instrumentation vocabulary.

## Verified numbers

`verify-loop-bench.py` — 59 checks, exact rationals, run before any value was typeset:

- The six ranges and their rules: 0–200 psi, 0–150 psi, 0–100 psi, 0–500 psi, 0–72 in, 50–250 °F
- Every clean landmark on each (50 psi → 8.00, 36 in → 12.00, 150 °F → 12.00, …)
- Live zero: exactly 4.00 at LRV and 20.00 at URV across eight ranges including a negative LRV
- Tolerance: 0.25% of 16 mA = 0.04 mA, with the 12.04 pass / 12.05 fail pair asserted
- Inverse round-trip on five range/value pairs
- Unit 5 composition preview: `(C∘T)(h) = (100/72)h`, checked at four levels
- The 0–80 in tank added for the student build

**Re-run confirmed 2026-08-23** on this machine: exits clean, final line `OK - 59 checks passed`. The count on this card is the script's own output, not a recollection of it.

## Rulings

**2026-08-22 — Student default tank is 0–80 in, not 0–72 in.** `16/80 = 0.2` mA per inch exactly, so *Find the rule* yields a clean slope from a table. 0–72 gives 0.2222…, and a repeating decimal on first contact turns a pattern-finding task into an arithmetic task. **0–72 remains canonical for the Unit 5 composition** — `(100/72)h` is the point there — and stays available in the setup menu. Both are asserted in `verify-loop-bench.py`.

**2026-08-22 — The student file is canonical; the technician file is kept, not maintained.** The first build used LRV/URV, five fault types, and NAMUR-adjacent framing. The audience is high school juniors who have not started their technical courses and have never worked in a plant. The register was wrong, not the physics. `loop-bench.html` is retained because the calibration and fault-diagnosis modes may earn a place later, once students have lab hours.

**2026-08-22 — The needle carries the lag; the number is exact.** See *Failure history*.

**Recorded 2026-09-22, from the operator's project summary. Decided after first classroom use, during the [[../archive/2026-first-contact]] window. Individual dates weren't supplied.**

**The bench is an intervention tool, not a whole-class bench.** In class, it did not hold attention against graded work. It did hold attention unusually well for learners who usually disengage from symbolic math. That second result is the most valuable one, and it is **unexplained**. The rescope rests on it, which makes it the first thing to try to break.

**No v2 until a five-minute verbal probe with a fresh student.** Findings get documented before anything is acted on. The instrument is a print-ready clipboard form (`Loop_Bench_5Min_Read.docx`, kept outside the vault): a six-prompt script, four observation checkboxes, and the expected meter readings for both tank ranges (0–80 in and 0–72 in).

**Student explainers wait until after the fresh-student probes.** A student who can explain the bench to peers is a signal about the design. Deploying explainers early turns them into teachers and spends the fresh reads the redesign depends on.

**Non-terminating slopes get an ellipsis, not removal.** 0–72 in stays for Unit 5 as `2/9 = 0.222…`, shown honestly rather than avoided.

## Requirements and defects from first classroom use (recorded 2026-09-22)

Each line describes the bench. None describes a person (see *Exclusions*).

| # | Type | Finding | Status |
|---|---|---|---|
| R1 | **Defect: layout** | **Co-visibility failure.** On a 1366×660 Chromebook viewport, the tank scene and the active task are never visible at the same time. The page runs two screens tall with a ~540 px gap. The earlier probes at 880 px and 390 px (*Status* below) didn't test this viewport, which is why it was missed | Open. Fix before or with v2. It may explain R2 (unproven) |
| R2 | Requirement | The tank, needle, and table must connect **without prompting**. They didn't | Open. Retest after R1 |
| R3 | Requirement | The **live zero** (4.00 mA at an empty tank) is the strongest conceptual hook and has to land unprompted. It didn't | v2 starts at 0 in so the live zero is the first thing seen |
| R4 | Requirement | Question wording has to work without verbal nudges. It needed them | Open. v2 rewording |

**v2 direction: agreed, not built.** Collapse to **two stages, derive then apply**. Ask each question at the moment the data is captured, not afterward. Start at zero inches. Delete Stage 1 as a numbered step instead of gating it.

**The Unit 1 prediction below (*Open threads*: "Find the rule") is not confirmed or refuted by this.** The classroom read didn't report on that prediction directly. The fresh-student probe is where it gets tested.

## Known drift seam

**Each HTML file carries its own copy of the transfer function.** Change a range or a tolerance in one and the other is silently wrong. This is transcription where the ecosystem rule is derivation ([[../wiki/decisions]] D-2026-08-03a; [[../CLAUDE]] on git state), and it is the same failure class as the four-way count drift in the tech station.

It is tolerable at two files and will not survive six. **Before the second face is built, the engine, the range table, and the tolerance move to one source and both faces import it** — most likely a shared `loop-engine.js`, with `verify-loop-bench.py` reading the same range table rather than restating it. Recorded here so it is a scheduled fix and not a discovery.

## Failure history

**Damping filter produced wrong readings (found and fixed 2026-08-22, pre-release).** An exponential filter on the applied value, added for physical feel, never fully converged — 100 psi displayed 11.98 mA instead of 12.00, 200 psi displayed 19.97. Caught by a headless-browser probe comparing twelve landmark readings against `verify-loop-bench.py`, not by looking at the screen.

Consequence had it shipped: a student reads 11.98, concludes the 0.04 mA tolerance band is arbitrary, and the *Guess the reading* mode teaches the opposite of what it exists to teach. Fix was to delete the filter — the needle's spring-damper already supplies all the perceived lag, and the digital readout is now exact.

The general lesson, worth applying to the remaining five faces: **an effect added for realism must not sit between the equation and the number the student reads.**

## Status (2026-08-22)

- Both files built, rendered, and probed headless at 880 px and 390 px; no console errors
- All twelve landmark readings verified against the script through the actual DOM
- Every mode screenshot-checked; four layout collisions found and fixed by inspection
- ~~**Not yet in front of a single student.** Nothing here is validated by use~~ **Superseded:** the bench was used in class during the first-contact sprint. See *Requirements and defects from first classroom use*. Note that the headless probes above ran at 880 px and 390 px, not at the 1366×660 Chromebook viewport where R1 appears

## Known defects — found 2026-08-23 on filing; 1 fixed 2026-08-24, 2 open

**1. ~~`verify-loop-bench.py` prints a success line before it finishes.~~ FIXED 2026-08-24** — the leftover `print` deleted; a clean run now reports `OK - 59 checks passed`, and a corrupted 0–80 check was confirmed to raise with **no** `OK` line ahead of it. Kept below because the failure mode, not the line, is the reusable part. There was a `print(f"OK - {checks} checks passed")` at the end of the original suite (49 checks) *and* again after the 0–80 in block appended later (59). The first one was a leftover — the 0–80 block was appended *after* the final print instead of before it. If anything in the 0–80 block fails, the script has **already printed `OK - 49 checks passed`** to stdout before it raises — so a reader tailing the output, or any future CI step reading the wrong line, sees a pass on a failing run. Same family as the damping filter above: something cosmetic sitting between the check and the verdict the reader trusts. **Fix is deleting one line.**

**2. Both HTML files render in quirks mode.** Neither has a `<!doctype html>`, `<html>`, `<head>`, or `<body>` — they open directly on `<meta charset>`. **This is not a safe drive-by fix.** Quirks mode uses the legacy box model, and the layout was hand-tuned inside it — the "four layout collisions found and fixed by inspection" above were fixed against quirks-mode geometry. Adding a doctype shifts every element that sets `width` alongside padding or border, so it carries a re-check at 880 px and 390 px and belongs with the drift-seam work before face two, not on its own.

## Open threads

- **Hosting: SETTLED, recorded 2026-09-22, decided on or before 2026-08-24** (when the repo was created). The bench runs on **personal GitHub Pages, with notice rather than permission, scoped to the bench only.** The teacher tech hub's hosting question stays open and separate. The "settle once for both" suggestion below was not taken. *Source: the operator's own project summary, supplied 2026-09-22.* The original thread is kept below as record.
- ~~**Hosting.** Artifacts do not persist for students.~~ Options are GitHub Pages off a repo iframed into Google Sites, or something district-owned. **This is the same personal-account ownership question already open on the teacher tech hub** — worth settling once for both rather than twice.
  - **Scoped 2026-08-23 — hosting gates a class, not one student.** Verified against the files: zero network calls, zero external assets, zero storage APIs. A single student watching over a shoulder needs a laptop or a USB stick and nothing else. `build-inventory.md` ranks hosting as blocker 1 *ahead of* student contact as blocker 2; **for n=1 that dependency does not exist**, which is what makes the item below doable this week ([[../archive/2026-first-contact]] P1).
- **Student testing.** Predicted failure point is *Find the rule* — "how much does it go up for each inch" may be one abstraction too many, and the fix would be an intermediate step working two rows at a time. That is a guess. Ten minutes of watching a student resolves it.
- **The other five faces.** Designed, unbuilt, gated on the drift-seam fix above **and** on face one being watched.
- **Repo: resolved 2026-08-24.** It became `Lokie-ree.github.io`, **public**. That departs from the private-first founding convention, and the reason isn't recorded. Presumably it follows from the hosting ruling, but that is unverified. It remains a pointer card, not a spoke.
- ~~**Whether this becomes a spoke.**~~ Three loose files staged in a downloads folder are not a repo. If face two gets built, it needs one — founding convention is `main`, private, docs-only root commit ([[../CLAUDE]] §Git).

## Sync obligations

None. Introduces no `sync-registry.md` fields; nothing for `drift-check`.

## Exclusions

Nothing observed from teaching with students appears in this card or in either file, and nothing should be added later.

**Amended 2026-09-22 (operator ruling):** classroom findings may appear here **only as requirements and defects on the tool, in aggregate**. This is the same rule as [[civics-planning-tool]]. The following never appear: per-student anything, counts small enough to identify anyone, anecdotes, quotes, or any description of a particular student. The test for every line: *does it describe the bench, or a person?* Only the bench is allowed. Findings that can't be phrased that way stay outside the vault. This repo is public under a real name tied to a named employer. Student-facing content in these files is invented tank levels and generic process ranges — no rosters, no work samples, no names, no initials.

No Edmentum or other publisher content is reproduced. The 4–20 mA standard, the Amatrol model numbers, and the engineering ranges are public.
