# Depth criteria — the gate between build one and build two

**Written:** 2026-07-24, after `transformations-ptr` shipped ([[../projects/course-lab]] PR #16) and before the first class period — deliberately, so the thresholds are set by judgment rather than by whatever the first data happens to look like.

**Binds:** [[decisions]] D-2026-07-22b (fewer, deeper; first-student-data-is-a-gate) · [[decisions]] D-2026-08-03a (date-not-label — the CSV and any per-session field key on the calendar date; "A Day" means opposite days in the two cohorts and will merge them silently) · [[../initiatives/edgeex-build-family]]

The question this doc answers is not "did students like it." It is: **did the module teach, and is it worth building a second one before fixing this one.** Read it once, on the telemetry CSV from the first real run (teacher export in the module picker, one row per event).

---

## Evidence status — what is and is not established

*Filed 2026-08-03, from the strategy session. This section exists because the gap it names is exactly the gap this doc is the instrument for; without it, the doc looks like a formality rather than the first real test.*

**Validated: engagement.** Students voluntarily used creative-lab / CSE after finishing tests — no grade attached, no instruction given, rides waiting outside. Some completed all phases anyway. Reactions were strong. This is real and it is not nothing.

**Not validated: learning.** Reconcile has never been observed in the wild. A couple of students made connections with the teacher standing next to them; **that is four data points and a present adult, not a finding.** Signal 2 of this doc has therefore never actually been read on real data — which is the entire reason for the gate.

**The sample caveat, and it is severe.** Post-test volunteers who choose to linger in a math classroom are the friendliest population available anywhere in the building. That population tells you a great deal about the artifact and close to nothing about the compulsory 8:00 block. **Do not carry engagement evidence from the first group into expectations for the second.**

**Do not conflate "challenging" with "confusing."** They produce identical faces across a room, and the difference is the whole design. High achievers struggling is the *expected* result of a discovery-first module and is not evidence of a defect. **Do not tune difficulty on the strength of a room read** — the thresholds above exist precisely so that call gets made on the notebook and the reconcile prose, which can tell the two apart, rather than on the impression of a period that cannot.

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

**Sort against [[reconcile-calibration]]** — 15 worked samples with the boundary calls
made before any student data existed, plus three rulings that decide most sorts (the big
one: a memorized rule like *"a plus inside does the opposite"* is **not** a mechanism).
Sort those 15 first, blind, and reconcile any disagreement there rather than mid-read.

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

### The denominator is at risk — review before the semester, do not rewrite

*Added 2026-08-03.* Every band above is a rate, and every rate assumes a sample volume this year may not produce. Virtual students take unit tests at unscheduled times; LEAP, ACT, and WorkKeys windows carve the calendar up further. A first run of nine students who happened to be in the room is not a class-level read, however cleanly the percentages come out.

**Review the denominator before the semester starts; do not rewrite the thresholds after seeing the data.** The bands were set on 2026-07-24 by judgment, deliberately in advance, for exactly this reason — moving them once numbers exist converts the gate into a rationalization. What is legitimate is deciding *in advance* what minimum n makes the read meaningful at all, and being willing to say **"not enough data, run it again"** instead of grading a handful of students against bands built for a room.

---

## The collection path — resolved 2026-07-26

**Status: protocol written ([[collection-protocol]]). Dry run outstanding.**

The four signals above are read *across a class*. The events are not — every event lands in
`localStorage` under `course-lab:events`, **per browser**, and the teacher CSV export reads one
device's store. Getting ~40 devices into one file is the collection problem this section opened.

Two things resolved it, and one remains:

**1. The failure is no longer silent.** The original risk recorded here was that Chrome blocks
`localStorage` on wiped school profiles, the sink falls back to memory ([[patterns]] §6), and
in-memory events die at tab close — so a student could complete the module, hand in their answers,
and leave behind nothing, with no error anywhere. course-lab PR #18 closed that: the sink probes
whether it can actually round-trip a write, and the picker and start gate render the answer. A
blocked device is now visible **before the student starts**, not after the data is gone.

**2. The signals split across two independent paths.** This section assumed one collection problem;
there are two, and they fail independently ([[collection-protocol]] §The two paths). Signal 2 — the
reconcile prose, the only signal requiring human reading — travels by clipboard from React state and
**never touches storage at all**. It survives a fully storage-blocked device. Signals 1, 3, and 4
want the CSV, and also arrive in prose form on the same paste, hand-tallyable if the CSV is lost.

That makes the clipboard path a floor the gate can stand on even if every device blocks storage.

**3. Still outstanding: one `DEMO01` dry run** on a real school device, per
[[collection-protocol]] §The DEMO01 dry run. Everything above is reasoned from the code and from
the 2026-07-26 network check; none of it has been executed in the building. **The gate does not
open on a protocol that has only ever run on this laptop.**

## Design constraints on the unit of work

*Filed 2026-08-03. These bind **build two's scoping**, not the CSV read above — they live here because this doc is where build two gets scoped, and because the greenlight branch otherwise hands off to nothing.*

The environment is fluid by design, not by accident: virtual students take unit tests at unscheduled times, and LEAP / ACT / WorkKeys windows fragment the rest. **The unit of work must survive interruption.**

- **The container is the 50-minute block.** P-Tech has math 50 minutes daily; Instrumentation has 105 minutes three days a week. **Design for 50 and extend to 105 — never the reverse.** A PTR arc authored at 105 and compressed into 50 gets amputated at the reveal, which is the one part that cannot be cut.
- **Self-contained.** A five-day arc missing day three is not a four-day arc, it is a broken one. If a unit only works when every day lands, this schedule will break it.
- **Resumable, within a session and across sessions.** That is the whole requirement. **Not** offline-first sync, not conflict resolution, not a server — client-side until the [[decisions]] D-2026-07-24 triggers actually fire ([[../projects/course-lab]] stays client-side).
- **Works without the teacher at the front of the room.** Not a nice-to-have: the RTI block, the ECO duty, and the testing calendar all guarantee periods where that adult is unavailable.

**The reframe worth keeping:** chaos is not the obstacle to this product, it is the demand for it. **The student who finishes a unit test with 25 minutes left is the ideal user** — and this schedule generates that student constantly. A module that needs a quiet, intact, fully-attended period is solving for a room that will not exist this year.

---

## What this doc deliberately does not measure

- **Score.** There is no score. Every `check` is match/miss on one committed call, and the reconcile prose is saved unjudged for the teacher (founding spec §4).
- **Time on task.** `ts` is in every event and it is tempting. It measures Chromebook lids and hallway passes as much as thinking.
- **Sandbox slider motion.** A deliberate NOT-DOING ([[decisions]] via the module spec) — free play stops being free the moment it is recorded.
- **Anything requiring a dashboard.** This is a one-page read of a CSV, once. If it needs a build to answer, it is not a gate, it is another project.
