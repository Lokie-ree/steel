# Collection protocol — getting a class period's data to a desk

**Gap this doc fills:** [[depth-criteria]] says what to read and what the numbers have to
say; it does not say how ~40 Chromebooks' worth of data reaches one desk. This is the
class-period runbook — held while students are in the room, not read at a desk afterward.
Different reader, different moment, different genre.

**Written:** 2026-07-26, closing [[depth-criteria]] §OPEN.
**Binds:** [[decisions]] D-2026-07-24 (client-side stays) · course-lab PR #18 (storage health)

---

## What changed since §OPEN was written

Two things, and together they shrink the problem a lot.

1. **The school-network check passed** (2026-07-26, district Chromebook, district wifi).
   No custom domain, no DNS. The URL is the URL. **⚠ Scoped 2026-08-04 — see
   §Which network, below. That result is correct for the network it ran on, and the room
   has since moved into the community college.**
2. **The silent failure is no longer silent** (course-lab PR #18). The sink now probes
   whether it can actually round-trip a write, and the picker and start gate say so:
   quiet "Saving your work ✓" when healthy, a red `role="alert"` when not. §OPEN's hardest
   branch — *"what happens on a device that was storage-blocked"* — is now answerable **in
   the room, before the bell**, instead of three days later as a hole in the CSV.

---

## The two paths (this is the important part)

§OPEN treated all four depth signals as one collection problem. They are not.

| Path | Carries | Mechanism | Survives a storage-blocked device? |
|---|---|---|---|
| **A — clipboard** | Signal 2 (reconcile prose), plus a per-student prose copy of 1, 3, 4 | "Copy my answers" → paste into a Google Form | **Yes** — fully independent |
| **B — CSV** | Signals 1, 3, 4 in computable form | Teacher export on each device → one folder | No |

**Path A does not touch `localStorage`.** The session report is assembled from React state
at recap time (`useSessionReport`, built from `rounds[]` and `state.reconcile`) and handed
to the clipboard. A device that never persisted a single event still produces a complete,
correct paste. There is even a select-the-box fallback when the clipboard API itself is
blocked, which managed Chromebooks sometimes do.

That makes Path A the **floor**. If everything else fails, a class period still yields
Signal 2 — the only signal that requires human reading and the one the gate leans on
hardest — plus a hand-tallyable version of the other three.

Path B is the **ceiling**: same data, computable instead of hand-counted, worth the device
wrangling but never worth a class period's stress.

> **Design consequence:** run Path A for every student, every time. Run Path B when it's
> cheap. Do not let a Path B problem consume instructional time — the floor already holds.

---

## Student-side runbook (in the room)

Four steps, said out loud, in this order.

1. **"Check the green line."** Before entering a code: the screen says either
   *Saving your work ✓* or a red warning. **Hands up for red.** Note those seats — that
   is the entire storage-blocked roster and you have it before anyone starts.
2. **Enter your code. Do the module.**
3. **At the recap: press "Copy my answers," then paste into the Form.** This is the
   non-negotiable step. If the button says *"Select the box below & copy,"* select the box
   and press Ctrl-C — same result.
4. **Then press "Export telemetry CSV" on the module list** and hand in the file (see
   Path B below). Skippable under time pressure; step 3 is not.

The Form needs exactly two fields: **student code** (short text) and **your answers**
(long text, paste target). The paste does not contain the student code — keep them
separate so the code is validated as its own field.

## Teacher-side

**Path A.** Nothing. Responses are already one spreadsheet, one row per student, at the
end of the period. This is what Signal 2 gets read from.

**Path B.** Each device's export downloads as
`course-lab-events-<STUDENTCODE>-<date>.csv` (PR #18 — the code is in the filename so a
collected folder answers *"who handed in?"* without opening 40 files). Get them into one
folder, then concatenate: every file has the same header, and `studentCode` is on every
row, so the merge is header-plus-tails. One `cat`, or paste-append in Sheets.

Do **not** press "Clear device telemetry" on a shared cart until the merged file is
confirmed readable. The two-step confirm exists for exactly this.

---

## When it goes wrong

| Symptom | What it means | Do this |
|---|---|---|
| Red warning at the start gate | Storage blocked on that device | Student works normally. **Path A only** — make sure they paste. Don't troubleshoot mid-period. |
| Student closed the tab before pasting | Path A lost for that student; Path B lost too if the device was red | Re-run is cheap (module is short). Otherwise that student is absent from the data, which is fine — n=40 tolerates it. |
| "Copy my answers" doesn't copy | Clipboard API blocked | The button already falls back to select-the-box. Ctrl-C. |
| Wrong / typo'd student code | Roster guard rejects it at the gate | It cannot get past the gate — this fails loud by design. Correct and continue. |
| Export button downloads nothing | Storage blocked (device was already red) | Expected. Path A covers it. |
| Downloads blocked by policy | Path B unavailable on this device | Path A covers it. Note it; if it's *every* device, Path B is dead district-wide and the gate runs on Path A alone. |

---

## Facts still to confirm in the building

These are the only remaining unknowns, and each has a named fallback so none of them
blocks the gate:

- [ ] **Which network the room actually runs on** — district or community college. Answer
      this first; it re-scopes the three below and the 2026-07-26 check. *No fallback: this
      one is a question to a person, not a test.*
- [ ] **Google Form reachable and submittable** from a student Chromebook on whichever
      network the room runs on. *Fallback: Google Classroom assignment with a text
      response, or paste into a shared Doc.*
- [ ] **Downloads allowed** to the device, and reachable afterward (Files app / Drive).
      *Fallback: Path A alone.*
- [ ] **Cart or 1:1**, and whether profiles wipe between periods. Determines whether
      Path B must run every period or can run once at the end of the day.
- [ ] **How many devices show red.** Zero is a different protocol from a third of the
      room. This is the single most useful number the dry run produces.

---

## Which network — open as of 2026-08-04

The room is moving into the community college, and **it is not yet known whether it runs
on district wifi or on the college's own network and filtering.** Until that is answered,
"the district network" is not a single referent in this doc and every network-dependent
result below is scoped to the network it was observed on.

**This is a question, not a defect.** The 2026-07-26 check was correct for the network it
ran on. What is no longer safe is the *inference* — that a pass there predicts a pass in
the room students will sit in.

- **Answer it by asking, not by testing.** Whoever is standing up that room knows. This
  costs a conversation and does not require a Chromebook, which makes it strictly cheaper
  than discovering it through a failed dry run.
- **Do not run the dry run against an unidentified network.** A PASS recorded without
  naming the network is worse than no result: it reads as settled in six weeks, and the
  vault has already catalogued what a confidently wrong recorded answer costs
  ([[../initiatives/issue-ledger]] §the honesty instrument).
- **If the college network is in play, the custom-domain/DNS branch is not dead** — it was
  retired on evidence from the other network. Different vendor, different allowlist.

**The rule this earns:** *a network result is only as portable as the network it was
observed on.* Record the network, or the result decays into folklore.

---

## The DEMO01 dry run

One student, one device, one period's worth of steps — on a **school** device, on **the
network students will actually be on**. Not on the dev laptop; the whole point is the
school profile.

Run it end to end and confirm each of these is true at the end:

0. **Name the network before starting** — district wifi, the college's, or a guest SSID —
   and write it into the sprint-log row with the result. A check that does not say which
   network it ran on cannot be reused, and this is the step whose absence is being
   corrected here.
1. Site loads; the storage line renders (either state — note which).
2. `DEMO01` passes the gate.
3. Module completes through the recap.
4. "Copy my answers" copies, and the paste lands in the Form with content.
5. Export downloads a file, and the filename contains `DEMO01`.
6. The CSV opens and has more rows than just the header.
7. The merge step works with two files (export twice, or use a second device) — this is
   the step most likely to surprise, and the cheapest place to find that out.

**If 1–4 pass and 5–7 fail, the gate is still open.** Path A is the floor and it held.
Say so in the sprint log rather than treating the run as failed.

---

## What this protocol deliberately does not do

- **No backend.** [[decisions]] D-2026-07-24 ruled client-side stays, with two named
  reopen triggers. "Collection was annoying" is not one of them; *"collection fails in a
  real class period"* is. If Path A fails in the room, that ruling reopens — not before.
- **No merge tooling.** Forty files with identical headers is a `cat`, not a project.
  If it turns out to need a script, that is a finding worth having, not one worth
  pre-empting.
- **No per-student dashboard.** [[depth-criteria]] is a one-page read of a CSV, once.
