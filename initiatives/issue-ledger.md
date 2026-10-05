# Initiative — Issue Ledger

**Vision:** A running, honestly-counted record of real student and teacher technology problems across 2026–27, and what actually happened to each one. The year's question is *how many real issues did I solve* — and the ledger exists so that number cannot be inflated by the person reporting it.

**The gap this fills:** the other five initiatives all begin *after* the decision to build. None names where the problems come from. This one is the intake; a small minority of its items graduate into [[edgeex-build-family]], most never become code.

**Status 2026-07-31:** this initiative does not start from zero, and it is not the operator's idea. **The platform already exists, shipped, and its stakeholder has already asked for exactly this.**

---

## The platform already exists

The **IPSB New Teacher Tech Station** — delivered 2026-07-29, three 15-minute rotations at new teacher orientation. Owner: Randall LaPoint, Jr., technology facilitator, Iberville Parish School Board. Three outputs from one data source (`answers.json`): a printed packet, a web hub embedded in Google Sites, and a supervisor review doc carrying 29 questions put to district leadership.

Two facts from its `CLAUDE.md` reframe this initiative entirely:

1. **"The technology supervisor wants to reuse the platform as a running pulse on what is actually happening with tech across the school year — so treat this as a living system, not a shipped artifact."** The year-long ledger is not a new thing to invent. It is a stated ask from a named stakeholder, against a platform that already builds, tests, and refuses to drift.
2. **"The 29 review items are the highest-value output. Nobody else in the district tracks them. Re-run each July."** An annual cadence already exists, and the artifact already has institutional standing.

> Corrects an earlier draft of this doc (same day) that called the project a finished record and proposed leaving it alone. It is neither finished nor unowned.

---

## Where it lives

| Thing | Home | Note |
|---|---|---|
| **The Tech Station** (`answers.json`, `answers.js`, `build.js`, `render-hub.js`, `test_hub.py`, the Makefile) | Claude for Teachers account (district email). **Not on the steel machine** — a filesystem sweep on 2026-07-31 found none of these files. | Where the working tree lives for `make` is an open question ([[#Open]]). |
| **The generalized skeleton** (`personal/new-teacher-tech`) | This account, untracked as of 2026-07-31 | Extracted *from* the Tech Station after delivery. Renamed on the way out: `answers.json`→`content.json`, `answers.js`→`content.js`, `render-hub.js`→`render.js`, `test_hub.py`→`test_output.py`, `project-handoff.md`→`HANDOFF.md`. **Do not conflate the two file sets.** |

**Steel holds the pointer and the direction, never the items or the counts.** Both projects arrived at this rule independently, which is the strongest argument for it: steel's drift policy says *document sync points, derive state*, and the Tech Station's prime directive says **"Never state a count in a chat reply from memory. Run `make status` first."** Its own `CLAUDE.md` deliberately does not print its numbers. Neither does this file.

**Not doing:** unifying the accounts, mirroring `answers.json` into the vault, or restating any status count in vault prose.

---

## The honesty instrument

Already built, already load-bearing, and the reason this initiative rides the existing platform instead of a new markdown table:

- `respondedTo` and `fullyAnswered` are **separate counts**. The shipped docs once disagreed because nobody said which one they meant. The year's headline number is **`fullyAnswered`**; `respondedTo` is the one that flatters.
- `unknown` ≠ `answered`. Item #27 was answered "unsure" — counted as answered *and* listed under partial answers worth tightening. Deliberate; do not collapse.
- `status` and `followUp` are independent (item #14: routing answered, category not).
- The build refuses to write when a marker and the data disagree, and the suite's expectations derive from `answers.json` rather than hardcoded numbers — a fix for `test_hub.py` having once frozen an undercount as a correctness invariant.

**Student references:** the Tech Station's editorial decision 3 already governs and is stricter than anything this initiative would add — *no student information into any AI tool, by anyone; describe needs generically; this is the one line not to soften.* An earlier draft here proposed reusing course-lab's roster codes for ledger items. **Withdrawn** — pseudonymous per-student tracking is a weakening of a generic-description rule, not a strengthening of it.

---

## Scope — sized 2026-07-31

**Both roles are live simultaneously:** two Algebra II/III preps on EdgeEx *and* the technology-facilitator role with the supervisor's district-pulse ask. That is the binding constraint, and it rules out the solicited building-wide envelope.

**No new intake this year.** The orientation envelope was a one-time moment that has already happened and already produced the 29 items. Manufacturing a second one costs the scarcest thing in the year — attention in the first six weeks — to generate items nobody has capacity to close. The `respondedTo` / `fullyAnswered` split exists precisely to make that trade visible; running an envelope you can't service inflates the first number and moves the second not at all.

Instead, the question splits into three that were being conflated, with different sources and different costs:

| Question | Source | Marginal cost |
|---|---|---|
| **"What is actually happening with tech district-wide?"** — the supervisor's literal ask | **incidentIQ**, which already logs it continuously, plus keeping the 29 alive | Near zero. Read an existing stream; build no intake. |
| **"How many real issues did I solve?"** — the operator's challenge | Issues that arrive on their own, from his own room and colleagues who ask | Low, and it is the honest number. |
| **"Gamification / personalization / equity / engagement"** — the pedagogical depth question | His own two preps and course-lab telemetry | Already instrumented — see below. |

The first needs *reading*, not building. Only the third involves code, and it is already gated.

---

## Lenses — three already have instruments

**gamification · personalization · equity · engagement**, plus **ISTE** for certification evidence.

The instinct is to build for these. Three of the four are already pointed at by [[../wiki/depth-criteria]], written 2026-07-24 without these words attached to them:

- **Gamification** — `reveal_earned` uptake. *"Low uptake means the earned reveal isn't reading as a reward, which is worth knowing before the next build leans on the same mechanic."* That is the gamification question, already instrumented.
- **Equity** — ghost-path rate (who walks past the producer round), plus course-lab PR #18's storage-health probe, which turns *whose work silently vanished on a wiped Chromebook profile* from invisible into observable.
- **Engagement, in the only sense worth measuring** — round-2 miss band against rounds 1/3, and reconcile quality. Not "did they like it": did they think.
- **Personalization** — **no instrument, and the most expensive to build.** Defer it. It is also the one most likely to be satisfied by EdgeEx rather than by anything built here.

So the year's depth work is **reading the first CSV through these lenses**, not opening four workstreams. Where a lens genuinely needs a new signal, that is a build-two scoping input, gated as usual.

On intake items they stay **tags, not workstreams** — by semester the ledger reports which lens the real problems clustered under, instead of the operator having guessed in July. ISTE accrues as a byproduct of solving real issues, matching its stated standing: achievable, not the goal. The ISTE research docs stay archived ([[../wiki/decisions]]).

---

## The rate limit

**Counting is free. Building is gated.** Solving an issue usually means answering it, routing it, or writing it down well enough that someone else can — not shipping code. The Tech Station's own history is the proof: its most valuable output was a 29-question audit produced as a **byproduct of marking unknowns instead of guessing**, and nobody set out to make it.

Items that do become builds are already rate-limited by [[../wiki/depth-criteria]] — build two does not start until build one has run with students and cleared the gate. This initiative adds no second queue and must never become a reason to open one.

---

## Next slices — already named, none of them new

Nothing below is a new idea; every item was already named in one project or the other. The value here is **the order**, because with two preps plus the facilitator role, four separate things all want the first six weeks — and that, not ambition, is the overwhelm risk.

**Before the first day** (the only genuinely deadlined work):

1. ~~**Confirm the first day of school.**~~ **Closed 2026-07-31 — students 2026-08-10, teachers return 2026-08-03.** Everything below is now scheduled against a known date; the five building days Aug 3–7 are the window, and they compress toward the end.
2. **The `DEMO01` dry run** — [[../wiki/collection-protocol]]. One student, one school device, fifteen minutes. The last gate-blocking item in the vault.
3. **Tech Station item #3** — whether Apple Classroom and GoGuardian arrive with rosters loaded, its named day-one blocker. Same building, plausibly the same visit as #2.
4. **The Gemini Notebook decision memo** — the Tech Station's own highest-value unbuilt thing, with supervisor agreement that it needs writing and no district AI guidance to lean on (item 29). *Better written now than reconstructed after someone asks* — and the asking starts when school does.

**After the first class period, in this order and not before:**

5. Run `transformations-ptr` with students; read the CSV once against [[../wiki/depth-criteria]], through the four lenses above.
6. Only then: build two gets scoped, or build one gets sent back.

**Unscheduled, cheap, do whenever:** track the skeleton as a repo — founding convention `main`, private, docs-only root commit. It is a tool with no district content; nothing blocks it.

**Explicitly not in the first six weeks:** a solicited intake envelope, a personalization build, any second module, and any new instrument for a lens that already has one.

## Carried in from the 2026-08-03 debrief

Three things from the Tech Station debrief that were absent from both `project-handoff.md` and this file. Everything else offered that day was already covered and was discarded rather than filed — see below.

**A duplicated doc forks reality.** This file already records the `test_hub.py` half of the lesson (a suite froze an undercount as a correctness invariant). The other half is not recorded anywhere: **two divergent copies of `project-handoff.md` were live at the same time, and whichever one got pasted into a new chat determined what that session believed.** Neither copy was wrong on its face; there was simply no way to tell them apart. This is the direct argument for *one canonical narrative source, pointers everywhere else* — which is the rule this initiative already runs on, now with its incident attached.

> It fired again the day it was written up. A chat-authored `ipsb-teacher-tech.md` was offered for the vault, claiming *"it does not duplicate the handoff, it indexes it"* — and duplicating the handoff. Filing it would have made three live documents for one project. **Discarded, not filed.** It also printed `make status` counts as vault prose, three days after the rule against exactly that was ratified, in a card whose own body memorializes the count disagreeing three ways.

**The second-adult trigger fired — and it does not apply to course-lab.** The technology supervisor asking to reuse the platform as a year-long district pulse is genuine second-adult adoption, and it is one of the two named triggers in [[../wiki/decisions]] D-2026-07-24. **But that ruling's trigger is specifically *a second teacher adopts course-lab*, and this is a different artifact on a different account.** It is recorded here so a future session reads it as the encouraging signal it is and **not** as license to reopen the client-side ruling. The course-lab trigger has not fired.

**Owning the work aloud, rep two.** ISTE was rep one; this was rep two, inside a month. Two points is a habit forming rather than a fluke — and the gap was never technical.

---

## Pre-meeting hypotheses — facilitator meeting, 2026-09-24

*Written 2026-09-23, the day before, so the answers get checked against a prediction instead of absorbed into one. Origin: the operator's "My Path is Calling" entry (stop building for workflows not yet needed; put what exists in front of humans; iterate on their feedback). The room: every school's tech facilitator (one per school) plus the supervisor, who already champions the Tech Station and the Claude workflow shown at the last meeting.*

**Goal of the meeting:** learn *teachers'* pain points through the facilitators. Listen and take notes. Pitch nothing. If asked what's been built, show the Claude workflow, not repos.

**Scope line:** the operator supports colleagues on request but is **not paid to spearhead** the Early College Option transition. Program lead is out of scope. Anything below that turns into one-on-one custom building for colleagues across the district breaks this line too.

### Baseline — the one colleague adaptation on record

The civics planning tool ([[../projects/civics-planning-tool]]): **~4–5 hours of tweaking plus a 1-hour walkthrough.** The teacher reported it saved a lot of time and put quality resources in front of students. It ended when the teacher's assignment changed. **Lesson:** it was tied to a person, so it left with the person. The next adaptation should be tied to a course or a role, so it survives a handoff.

### Hypotheses

| # | Hypothesis | What would weaken it |
|---|---|---|
| H1 | **The dominant pain is systems sprawl:** too many outdated, incompatible systems, driving attrition. If so, anything handed to colleagues must not be *one more system*. The offer is the pattern (the Claude workflow, plus the Station as a leave-behind), not the builds. | Answers cluster on specific, repeated, answerable questions instead of on sprawl. |
| H2 | **Facilitators will carry a ~10-minute segment into their own buildings** (staff meeting, PLC). This is train-the-trainer: the operator's strongest channel, in front of a group, reaching rooms he is never in. | Nobody says yes, or nobody can name a topic they'd want. |
| H3 | **Knowing the Tech Station exists is not the same as using it.** The supervisor nearly led with it last month, and a few teachers are known to use it, but no feedback has come back. A URL with no live introduction doesn't get opened. | Facilitators report teachers mentioning or using it unprompted. |
| H4 | **Civics-style adaptation doesn't scale one-on-one** at ~5–6 hours each. It waits until H2 or H3 surfaces one specific teacher with one specific need. | A facilitator could do the adapting themselves. |

### Questions to bring

Ask about specific recent events, not general opinions. Workarounds and repeated questions are where the real pain shows up.

1. What teacher question did you answer more than once in the last two weeks?
2. When a teacher gave up on a system, what did they do instead?
3. What do you get asked that you can't fix?
4. If one hour a week came back to your teachers, where would it come from?
5. *(H2)* If I gave you a 10-minute piece for a staff meeting, would you run it? About what?
6. *(H3)* Has any teacher mentioned the Tech Station to you?

**This week, independent of the meeting (H3):** five-minute conversations with 2–3 of the teachers known to use the Station. What did they open, what did they need, and what wasn't there. No form.

### Results — fill after the meeting

Record needs, never people. No names, no school identifiers, and no statement that reads as an evaluation of a colleague (this vault is public). Counts follow the rule above: none from memory.

| # | Held / weakened / unclear | What was heard (as a need) |
|---|---|---|
| H1 | | |
| H2 | | |
| H3 | | |
| H4 | | |

**Set aside until results exist:** new builds, Studio Coach, and the ECO transition. None of them has a human waiting in the facilitator or Tech Station roles.

---

## Open

- **Retire the minified hub build and `verify-min.py`?** *(carried in 2026-08-03, unresolved)* Both were built against a Google Sites embed character limit that **has never been documented or observed** — ~58,000 characters pasted successfully, and the 52k fallback plus a second tool to prove the fallback content-identical answer a ceiling nobody has confirmed exists. This is the same shape as the `.hub` pipeline deleted on 2026-07-26: infrastructure with no demonstrated reader. Make it trigger-based rather than anticipated, then log the ruling to [[../wiki/decisions]] **either way** — a documented "keep it, here's why" closes the question as well as a deletion does.
- **Where does the Tech Station's working tree live?** Its pipeline needs `node` + `docx` and `python3` + `playwright` + Chromium. It is not on this machine. An earlier draft of this doc asserted the free Teachers tier could not run that toolchain and concluded the ledger must therefore run on the steel account — **that inference was wrong**; the pipeline demonstrably runs somewhere. Until the working tree is located, where the year ledger executes is undecided.
- **Does the year ledger extend `answers.json` or become a sibling instance?** The 29 items are *questions put to leadership*; a year pulse is *problems people hit*. Same schema, different unit. The supervisor's "running pulse" ask sits between them and has not been resolved with her.
- Whether the ledger ever gets a reader-facing surface, or stays internal. The Tech Station has `web` + `print` because it has an audience; a pulse may have an audience of one, in which case pruning the surface machinery is the first move — *"a skeleton you don't prune becomes the over-engineering it was meant to prevent."*
