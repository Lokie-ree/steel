# Depth criteria — the gate between build one and build two

**Written:** 2026-07-24, after `transformations-ptr` shipped ([[../projects/course-lab]] PR #16) and before the first class period — deliberately, so the thresholds are set by judgment rather than by whatever the first data happens to look like.

**Binds:** [[decisions]] 2026-07-22 (fewer, deeper; first-student-data-is-a-gate) · [[../initiatives/edgeex-build-family]]

The question this doc answers is not "did students like it." It is: **did the module teach, and is it worth building a second one before fixing this one.** Read it once, on the telemetry CSV from the first real run (teacher export in the module picker, one row per event).

---

## What to read

Four signals, all already in the event log. No new instrumentation.

### 1. Round 2 miss rate — the trap

`hshift-quad-plus2`, `action: check`, `result: miss` ÷ students who reached it.

Round 2 is the pedagogical heart: `f(x + 2)` moves **left** and most students say right. A miss here is the module working, not failing.

| Band | Reading |
|---|---|
| **40–75%** | Healthy. The trap is live and the reconcile prose is doing real work. |
| **< 40%** | Either the class already knew it (check whether EdgeEx covered the lesson first) or the choice order/wording is leaking the answer. Not automatically a problem — but the module isn't earning its round. |
| **> 75%** | Fine on its own, but pair it with signal 2: near-universal miss plus thin reconciles means students bounced off rather than reasoned. |

### 2. Reconcile quality — the only human read

The reconcile prose after round 2, in the CSV's session export (student-facing "Copy my answers" text, or the per-student recap the teacher collects).

Sort each into one of three, by hand, no rubric:

- **Names the mechanism** — says something about the input being changed *before* `f` runs, or reaching the same output earlier. This is the target.
- **Restates the outcome** — "it went left, I thought right." True, unreasoned. Acceptable in volume, worrying as the majority.
- **Filler** — the `isFiller` shapes the module already nudges against, arriving anyway.

**Threshold:** at least a third of reconciles name the mechanism. Below that, the reveal Coach text is doing the explaining instead of the student.

### 3. Commit-before-reveal — did locking in matter

Compare round 1 and round 3 match rates against round 2's.

Rounds 1 and 3 are the non-trap rounds; if their match rates are high (they should be — `+3` outside is intuitive) while round 2's is low, the commitment mechanic is exposing a *specific* misconception rather than measuring general confusion. That contrast is the evidence that predict-before-reveal earns its friction.

**Threshold:** rounds 1 and 3 match ≥ 70% while round 2 misses ≥ 40%. If all three rounds look alike, the module is measuring attention, not understanding.

### 4. Producer retries and the ghost path

`producer-abs-n1-h2-k3`, `action: check` — count per student — and how many sessions end at `complete` after a `miss` with no `match` (the "I'm stuck — move on anyway" path).

- **Median retries 2–4:** the target. One try means the read is too easy; five-plus means the student is guessing parameters rather than reading them.
- **Ghost-path rate > 25%:** the producer round is over-hard for its slot. The no-wall design means nobody is blocked — but a quarter of the room walking past it is a design signal, not a student signal.
- **`reveal_earned` rate:** what fraction of students who hit `complete` actually opened the sandbox. Low uptake means the earned reveal isn't reading as a reward, which is worth knowing before the next build leans on the same mechanic.

---

## The two thresholds

### Greenlight build two

**All four** of:

1. Round 2 miss rate lands in 40–75%.
2. At least a third of reconciles name the mechanism.
3. Rounds 1/3 match ≥ 70% with round 2 clearly below them.
4. Median producer retries 2–4 **and** ghost-path rate ≤ 25%.

Meeting all four means the PTR-plus-earned-sandbox shape demonstrably teaches, and the next build can reuse it without re-litigating the pedagogy. Build two gets scoped from the reuse ranking in [[edge-ex-courses]] §Cross-course overlap.

### Send build one back

**Any one** of:

1. Reconcile prose is majority filler — the writing gate isn't producing writing.
2. Round 2's miss rate sits below 40% **and** rounds 1/3 also run low — students aren't reading the prompts at all, which is a copy problem, not a concept problem.
3. Ghost-path rate above 40% — the producer round is a wall in everything but name.
4. Any operational failure that ate class time: telemetry gaps, the URL blocked on the school network, the module unusable on a Chromebook.

Revision means a `MODULE_VERSION` bump on `transformations-ptr` and a second run. **Build two does not start in the meantime** — that is the whole point of the gate.

---

## What this doc deliberately does not measure

- **Score.** There is no score. Every `check` is match/miss on one committed call, and the reconcile prose is saved unjudged for the teacher (founding spec §4).
- **Time on task.** `ts` is in every event and it is tempting. It measures Chromebook lids and hallway passes as much as thinking.
- **Sandbox slider motion.** A deliberate NOT-DOING ([[decisions]] via the module spec) — free play stops being free the moment it is recorded.
- **Anything requiring a dashboard.** This is a one-page read of a CSV, once. If it needs a build to answer, it is not a gate, it is another project.
