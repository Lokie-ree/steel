# Reconcile calibration set — pre-registering the one human judgment

**Gap this doc fills:** [[depth-criteria]] Signal 2 says *"sort each into one of three, by
hand, no rubric."* It is the only signal that is a judgment rather than a number, it will
be exercised once, alone, on ~40 samples, on a school night — and it has no worked
examples. This file supplies them, sorted **before any student data exists**.

**Written:** 2026-07-26. Same discipline as [[depth-criteria]]'s thresholds: the call is
made before the data can create an incentive to move it.

---

## The prompt students answer

Round 2 (`hshift-quad-plus2`) is the trap: `f(x + 2)` moves **left** and most students
say right. The reconcile field is mandatory on that round and its label is a sentence
frame:

> **I thought ___, but f(x + 2) actually ___ because ___**

A response must clear 12 characters and survive the module's `isFiller` heuristic to
submit at all. **Those gates are not the sort.** A 20-character sentence that says nothing
passes both and still lands in the CSV — which is exactly what makes this sort necessary.

## The three bins ([[depth-criteria]] Signal 2, verbatim)

- **Names the mechanism** — says something about the input being changed *before* `f`
  runs, or reaching the same output earlier. **This is the target.**
- **Restates the outcome** — "it went left, I thought right." True, unreasoned.
  Acceptable in volume, worrying as the majority.
- **Filler** — the `isFiller` shapes the module nudges against, arriving anyway.

**Threshold: at least a third name the mechanism.**

---

## The three rulings that decide most sorts

Made now, on purpose. Every borderline sample below turns on one of them.

**R1 — A memorized rule is not a mechanism.** *"A plus inside does the opposite"* and
*"inside is backwards"* are correct, useful, and will be the single most common response.
They still go in **Restates**. The student has recalled a rule that describes the outcome;
they have not said anything about `x` being changed before `f` sees it. If this ruling
feels harsh when the real data arrives, that feeling is the reason it was written down
first.

**R2 — Wrong words don't disqualify a right mechanism.** Grammar, spelling, and vocabulary
are not the sort. If the sentence conveys *the input is bigger before `f` runs* or *the
same y arrives at a smaller x*, it counts, however it is spelled.

**R3 — An `isFiller` shape inside a longer sentence is still filler.** *"I don't know why
but it went left"* clears the length gate by wrapping a non-answer in words. It is filler
with padding, not a restatement.

---

## The set — 15 samples, sorted

| # | Response | Bin | Why |
|---|---|---|---|
| 1 | "i thought +2 would go right but it went left because the x is already 2 more before it even gets to the function so it hits the bottom of the v earlier" | **Mechanism** | Both halves: input changed before `f`, and the outcome arrives earlier. Textbook target. |
| 2 | "I thought it would move right, but f(x+2) actually moved left because a plus inside does the opposite." | Restates | **R1.** The most common response you will see. Correct rule, zero mechanism. |
| 3 | "i thought right. it went left." | Restates | Bare outcome. Clears the gate, says nothing. |
| 4 | "I thought +2 shifts right like it does when its outside, but inside youre changing what goes IN to f, so f already gets a bigger number and the vertex shows up 2 sooner" | **Mechanism** | Names the inside/outside distinction *and* the reason. Strongest in the set. |
| 5 | "i thought it would go right cuz plus means right but it went left, that was confusing" | Restates | Honest, unreasoned. |
| 6 | "to get the same y you need x to be 2 smaller now" | **Mechanism** | **R2.** Short, no frame, no "I thought" — and it is exactly the same-output-earlier formulation. Count it. |
| 7 | "The +2 is inside the parenthesis so it affects x not y, so it moves horizontal and its backwards" | Restates | **R1, and the hardest call in the set.** Correctly sorts inside vs. outside and horizontal vs. vertical — real understanding — then lands on "backwards" instead of why. This is the near-miss you will want to promote. Don't. |
| 8 | "i thought +2 = right, but actually f is getting fed x+2, so when i put in 0 the function is really seeing 2, so everything happens 2 early" | **Mechanism** | Reasons from a specific input. Student's own words throughout. |
| 9 | "I thought it moves right because you add 2. But it moved left because the graph is shifting the other way when the number is with the x." | Restates | Same family as #7 — locates the cause on `x` but explains nothing about it. |
| 10 | "because the vertex went from 0 to -2" | Restates | A precise observation of the outcome. Precision is not mechanism. |
| 11 | "asdfasdf" | **Filler** | Passes both gates — `isFiller` matches bare `asdf`, not `asdfasdf`, and 8 > 6 chars. Junk reaches the CSV; expect some. |
| 12 | "I dont know why it did that but it went left" | **Filler** | **R3.** A non-answer padded past the length gate. |
| 13 | "i thought it would go right, but f(x+2) moved left because your replacing x with x+2 so its like the whole graph slides back to where x+2 used to be" | **Mechanism** | **R2.** Substitution framing, badly spelled, completely correct. |
| 14 | "it moved left because negative" | **Filler** | Boundary case. Gestures at a reason without containing one; nothing here can be scored as either mechanism or outcome. |
| 15 | "I thought the +2 would push it right since thats what +3 did on the last round, but the 2 gets added to x first, so f is already 2 ahead of where I am on the graph" | **Mechanism** | Reasons *from the previous round's contrast*, which is the module's own design. |

### Distribution

**5 mechanism · 7 restates · 3 filler → 33.3% naming the mechanism.**

That is deliberate. The set lands **exactly on the threshold**, so sorting it is a real
exercise of the judgment and not a warm-up with an obvious answer. If your sort of these
15 comes out above or below a third, the disagreement is with the rulings above — resolve
it *here*, on synthetic samples, where nothing is at stake.

---

## How to use it

1. **Before reading the real data**, sort these 15 yourself without looking at the Bin
   column. Ten minutes.
2. **Compare.** Where you differ, decide which call you actually believe and amend R1–R3
   here, with the date. Amending the rulings is legitimate; amending them *after* seeing
   student data is not.
3. **Then sort the real reconciles**, with this table open beside them.

**If your sort of the real data and this set disagree, this set wins.** The whole point of
writing it before the data existed is that it cannot be bent by what the data turns out to
say.

---

## What this does not do

- **It is not a rubric handed to students.** They never see it. The module's own copy says
  *"there's no right wording — just say what you noticed,"* and that stays true.
- **It does not grade.** [[depth-criteria]] measures whether the *module* taught, not
  whether a student passed. No score exists anywhere in course-lab.
- **It does not generalize past this round.** These samples are specific to `f(x + 2)`
  moving left. A second build gets its own set, written the same way — before its data.
