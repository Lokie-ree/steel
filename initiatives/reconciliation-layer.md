# Reconciliation Layer

> **Gap this doc covers:** [[../wiki/patterns]] harvests architecture from repos, and
> [[../projects/index]] carries one card per project — spokes, and since 2026-08-13 the
> non-spoke surfaces too. But a card is still *per project*. The fall's highest-volume work
> has not been in a repo — it's been documents, packets, context stacks, and one HTML bench,
> built across three roles — and **the shape those surfaces share** has no home at the hub,
> so it keeps getting rediscovered per project instead of applied.

**Status:** open initiative. Drafted 2026-08-22, **filed 2026-08-23**. Not a spoke.
Nothing here is a ruling — the one ruling this doc needed lives in
[[../wiki/decisions]] 2026-08-23.
**Operator surfaces in scope:** classroom (Algebra II), district facilitation, colleague support.

---

## The pattern

Every build this fall started the same way: **two maps of the same territory that don't
line up, and no crosswalk between them.** The visible deliverable is a packet, a plan, a
simulator. The thing actually built is the layer underneath that makes the two maps agree
— and that layer, not the deliverable, is what other people can inherit.

The corollary is why the output volume looks larger than the effort: **one source, many
faces.** Build the reconciling layer once and the surfaces fall out of it cheaply. Build
the surfaces first and they drift.

Worth noting that the term was already in use before it was recognized as the pattern — a
context stack built in August named its fourth layer *Reconciliation* without the operator
connecting it to anything else he was doing.

## Evidence

Admission bar borrowed from [[../wiki/patterns]]: a pattern earns a card at **≥2
independent instances**. This has four, in three roles, inside four weeks.

| Surface | Role | The two maps | What got built |
|---|---|---|---|
| Algebra II course build | Teaching | Vendor course structure vs. a real calendar and a 50-minute block | Pacing calendar (HTML + XLSX), Class-Time Playbook, Unit 1 three-document set, `verify_coverage.py`, course-context skill ([[../projects/algebra2-course-plan]]) |
| CTE anchor | Teaching | Lab hardware vs. Algebra II standards | One loop engine, six front panels; student-facing bench build ([[../projects/loop-bench]]) |
| New-teacher tech reference | Facilitator | Platform reality vs. what a new hire needs on day one | Single source file → printed packet, web hub, review doc ([[issue-ledger]]) |
| Colleague's planning support | Facilitator | A state framework's unit/topic map vs. an adopted textbook's chapter numbering | Five-layer context stack, standards reference, alignment gap register ([[../projects/civics-planning-tool]]) |

The fourth row is the clearest case: the crosswalk between those two maps **does not exist
anywhere**, and every teacher in that position rebuilds it privately each week. That's the
duplicated-effort failure this whole pattern exists to stop, and it's the same failure
[[../README|steel]] was built for — the same facts written in six places, drifting
silently, discovered in front of students.

**Count corrected 2026-08-23.** An earlier draft of this doc said three of the four rows
are not Algebra II. **Two are not.** The CTE anchor *is* the Algebra II applied layer —
one panel per Algebra II unit, and [[../projects/algebra2-course-plan]] already anchors the
course's applied content on the 4–20 mA loop. The surfaces split cleanly by **role**, two
and two, which is what turned open question 1 below from a violation into a gap.

## Rules that repeat across all four

Each one is already load-bearing somewhere; listing them together is the new part.

**One source, many faces.** *Derive state, never transcribe it* ([[../CLAUDE]]) applied to
audiences rather than to git. Three outputs from one data file. Six unit panels from one
engine. A weekly draft from one context stack. Any surface that carries its own copy of a
number will eventually disagree with the others in front of a student.

**Hand back the typing, not the thinking.** The value is in what the person stops doing,
not in what the tool produces. Transcription is automated; judgment is protected
structurally — the equation stays hidden behind a fold until the rule is found, two
columns are always rewritten by the teacher regardless of draft quality. Same family as
[[../wiki/patterns]] #3: *structural guardrails beat prompt guardrails.* When the learning
depends on someone **not** being handed something, withhold it in the design, not in an
instruction.

**Verify before it's baked in.** `verify-loop-bench.py`, `verify_coverage.py`, exact rational
arithmetic, CAS-checked answers, a build that fails loudly on a count mismatch. Earned:
a damping filter put 100 psi at 11.98 mA instead of 12.00. No one would have caught that
by reading it.

> **Sharpened 2026-08-23, from filing [[../projects/loop-bench]]:** the verifier itself is
> a surface and obeys the same rule. `verify-loop-bench.py` prints `OK - 49 checks passed`
> before running its final ten checks, so a failing run puts a success line on stdout ahead
> of the failure. *Verify before it's baked in* is not satisfied by owning a verifier — the
> verifier's own output has to be trustworthy, and this one's was not. The card carries it
> as a known defect.

**Watch where they hesitate.** Observation over self-report, stated independently in two
unrelated builds — *watch the cell she stalls on*, and *put the bench in front of one
student and see where they stop.* What someone reports afterward is a summary; the pause
is the data.

**Strip to protect the receiver.** Jargon out of the student build. Critique out of the
peer email. Evaluation framing out of validation findings — findings written as tool
requirements, never as an assessment of a colleague's work. Three different subtractions,
one instinct.

## Standing risk: the build has outrun the validation

As of 2026-08-22, nearly everything above is finished and almost none of it has been used
by the person it was made for. The bench has not met a student. Units 2–6 are correctly
held pending the end-of-Unit-1 review. A handoff went out with disclosed blockers still
open.

This is the same failure already recorded once in [[../wiki/patterns]] #1 — the sync
pipeline with no consumer downstream, deleted 2026-07-26 — appearing on a new surface.
**A reconciliation layer earns its place from the reader downstream, not from the tidiness
of the source upstream.** The sharpening that entry left behind applies here without
modification.

**Promoted to a sprint 2026-08-23.** [[../sprint/2026-first-contact]] exists to close
exactly this risk, and it opened on the finding that **five documents — including this one
— independently recorded "nothing has met a student" without any of them linking to
another.** The rediscovery this doc says the pattern suffers from was happening to the
observation about the pattern.

## Open questions

1. ~~**This collides with a standing ruling.**~~ **RESOLVED 2026-08-23** ([[../wiki/decisions]]).
   The question was whether [[../wiki/decisions]] 2026-08-03 — *the fall build surface is
   Algebra II; the rest is a support obligation, not a build obligation* — was being quietly
   violated by the non-Algebra-II surfaces above. **It was a gap, not a violation.** The 08-03
   session was about the *math spectrum*; the fall asked *which roles do I build for*, and 08-03
   has no answer in it. The amendment: **that ruling bounds the teaching role, and the
   facilitator role is a second surface admitted at reconcile, not at build** — a crosswalk is
   cheap and inherited, a build is neither. Facilitator work that wants code goes through
   [[issue-ledger]]'s rate limit rather than around it. Two of the four rows above are
   facilitator-role, and both are reconcile work, so both sit inside the amendment.
2. **Admission.** ~~Either the bar widens to "≥2 independent instances" or this stays in
   `initiatives/` and patterns stays repo-only.~~ **Resolved by placement, 2026-08-23:** this
   doc is filed here; [[../wiki/patterns]] stays repo-only and its bar is unchanged. The reason
   is the standing risk above, not a judgment about the pattern — four instances with no
   downstream reader are four hypotheses, and patterns' own §1 correction says a layer earns
   its place from the reader downstream. **Named trigger to revisit:** the first fall surface
   that gets used by the person it was built for. This was settled by filing rather than
   ratified in [[../wiki/decisions]]; ratify it there if it needs to bind harder than a
   placement.
3. **Disclosure ceiling.** This vault is public under a real name tied to a named
   employer. The exclusion list below is what that costs; it should be re-checked whenever
   this doc is extended, not assumed to still hold. **Re-checked 2026-08-23** against the
   additions made on filing — the loop-bench and algebra2-course-plan links, the role
   column, the verifier note. Nothing added names a colleague, a publisher, a district
   staff member, or anything observed from teaching. The table below stands unchanged.
4. **Capacity.** Three roles, three concurrent builds, four weeks, hard dates on all
   three. Not a question this doc can answer — but it belongs on the record before a
   sprint gets cut from it. **A sprint was cut from it on 2026-08-23**, with this question
   on the record and visibly shaping the result: [[../sprint/2026-first-contact]] carries
   **one next action per surface and no roadmap**, on the operator's own short-horizon
   constraint. The capacity question is not answered; it is now at least being planned
   against rather than around.

## What this doc does not carry, and why

Public repo, real name, named employer. All of the following stayed out deliberately —
they belong in the local working copy, not here.

| Excluded | Reason |
|---|---|
| Any colleague's name, and the subject/school that would re-identify one | Standing rule: the pilot teacher stays unnamed. Subject + parish + year is re-identifying on its own |
| Named district staff, supervisors, and administrators | Same |
| The publisher, title, and state quality rating of any adopted material | Reads as a public judgment of an adoption decision the operator didn't make |
| Item text, counts, statuses, and dates of record from the district reference project | Derived from the source file; a number written here is transcribed state by definition |
| Specific findings from reviewing a colleague's submitted plans | Framed as tool requirements privately; publicly they'd read as an evaluation |
| Anything observed from teaching a unit with actual students | Standing exclusion |
| Ownership and account-custody status of any district-facing resource | An institutional risk statement about an employer, on that employer's employee's public repo |
| Role, title, and reporting-line observations | Career-political, not architectural. Belongs in a private note or a conversation, not a governance hub |

## Filing record — the doc's own pre-commit checks, run 2026-08-23

1. **Placement.** `initiatives/reconciliation-layer.md`. Open question 2 resolved toward
   *not* widening the patterns bar, so this is the only copy — **not filed in both.**
2. **Sync registry.** Verified against [[../sync-registry]]: this doc names no module
   display names, no standards strings, no triangle coordinates, and no deploy URLs. **No
   Tier 1 field is touched**, and nothing here is visible to `drift-check`. Re-check if the
   evidence table gains a row that does.
3. **Extend, don't create.** Checked against the nearest existing homes before filing.
   [[issue-ledger]] covers the facilitator role's *intake* and rate limit but carries no
   cross-surface architecture; [[../wiki/patterns]] carries architecture but is repo-scoped
   and stays that way per question 2. The shape shared across four surfaces has no existing
   home, which is the gap in the header. This doc does **not** become a second patterns
   doc; if it ever migrates, it migrates as one numbered entry with a `Forward use:` line.
