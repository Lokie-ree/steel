# Sprint — Results Bridge

**Window:** 2026-09-22 → 2026-10-04. **This is a planning horizon, not a deadline.** The only external date inside it is **hackathon results, 2026-09-25**, and nothing here depends on them. The window exists so the vault always has a current sprint. It also keeps the next-hackathon brainstorm from being mistaken for a build.

**The test:** *the fall's first student contact gets written down where it belongs, and the second one happens.* The first sprint passed its test (P1 was watched). This one converts that pass into a record and runs the dry run that 8b unblocked.

Update this file at the **start and end** of each work session. As before: one next action per surface, and no roadmap.

---

## Priority stack

| P | Surface | Role | The one next action |
|---|---|---|---|
| 0 | **Record P2** | Teaching | **P1 recorded 2026-09-22** on [[../projects/loop-bench]], as requirements on the tool and never as observations of people (the card's Exclusions were amended to say this). **8b paid 2026-09-28:** the 9b dry-run row names the **district network** and a student login ([[../wiki/collection-protocol]] §Which network). **Next on loop-bench:** the five-minute fresh-student probe, then fix R1 (co-visibility), before any v2. |
| 1 | **course-lab → 9b, then first contact** | Teaching | **⛔ Blocked 2026-09-28 at dry-run check 1.** The student filter extension categorizes the site as "Games." An IT allowlist ticket is submitted. **Next:** when IT confirms, re-run `DEMO01` on a **student login**. If the vendor recategorization is also pending, file it through the block page's KB link and ask for Education. The Mastery Test 3.2 lead-in dates below have slipped to the first class after a passing re-run. **Module changed 2026-09-27:** `quadratics-ptr` v1.1.0, not transformations-ptr. It matches Unit 3's Week 7 question; transformations was Unit 1. Order: merge course-lab PR #20 → create the Google Form (one paragraph field) → sort [[../wiki/reconcile-calibration]] Q1–Q8 blind → `DEMO01` dry run (seven checks, school device, **8b network named in the row**) → run it as the lead-in to Mastery Test 3.2 (P-Tech Mon 9/28, Instrumentation Tue 9/29). **Read:** signal 2 sorted by hand, plus the count of red devices, both recorded in aggregate only. The transformations-ptr depth read, the build-two gate, stays pending. |
| 2 | **Hackathon results** | Public identity | **Read them 09-25 and record them as one dated line** under [[../initiatives/public-identity]] §Outcome. No reaction work before the line exists. |
| 3 | **Brainstorm: next hackathon + what the vault becomes** | Public identity | **Explore, don't decide.** Captured in [[../initiatives/public-identity]] §Next instances. This sprint does not pick an event, an idea, or a stack, and it does not restructure the vault. |
| 4 | **Algebra II Units 2–6** | Teaching | Unchanged from [[../archive/2026-first-contact]]. It's gated on Unit 1 being reportable, and that's still owed to its canonical doc. |
| — | **still-true** | Public identity | **Nothing.** The log is closed and production stays up. The repo's post-submission items (`og.jpg` → SVG) are optional and wait until after 09-25. |

## Explicitly not doing this sprint

- **Choosing the next hackathon, idea, or stack.** The brainstorm has four goals that aren't ranked yet (identity, forcing function, winning, learning). Picking before they're ranked just picks one goal by accident.
- **New still-true features.** Readiness sits at 24 with ten open flags. Fixing them after the judging window is maintenance of a finished entry, not the next build. Revisit only if the brainstorm says still-true *is* the next build.
- Everything carried in [[../archive/2026-first-contact]] §Explicitly not doing that wasn't hackathon-scoped: build two, faces 2–6, hosting beyond n=1, and the rest. **Except reframing the vault.** That exclusion was reopened on 2026-09-22 (see P3). The rejection's test was "no downstream reader," and the operator named one: the operator, moving from project to project. The vault's evolution is now in the brainstorm. It is **not** a build this sprint: no restructure lands until the brainstorm says what the vault is for.

---

## Session log

| Date | Surface | What happened |
|------|---------|---------------|
| 2026-09-22 | steel | Sprint opened on the close of [[../archive/2026-first-contact]]. still-true logged as a pointer card. Brainstorm section opened in [[../initiatives/public-identity]] |
| 2026-09-22 | steel | **First project-close harvest (still-true).** Patterns §3 extended and §12 added. [[../wiki/lessons]] opened with five lessons. A draft story section added to [[../wiki/journey]] for the operator to edit. `vault-check`: 423 links resolve |
| 2026-09-22 | loop-bench | **The card was four weeks stale, and the classroom findings are recorded.** `Lokie-ree.github.io` has been public and serving `/loop/` since 08-24, while the card said "not deployed." The hosting ruling and the file mapping are now recorded. Findings are recorded as R1–R4 tool requirements. The Exclusions were amended (aggregate only, describe the bench and never a person). New ruling: intervention rescope, probe before v2, explainers after probes. [[../wiki/lessons]] gains #6 and new evidence for #3. [[../wiki/journey]] Era IV accepted |
| 2026-09-23 | steel | **Receipts from outside the vault.** Four project reports logged in [[../initiatives/public-identity]] §Next instances. Main finding: lessons in steel can't reach the district account, so the open step has to carry them across. Next is a URL test, not a build. The Tech Station got a row in [[../projects/index]] pointing at [[../initiatives/issue-ledger]]. [[../operator/build-inventory]] gained four `[unverified]` rows. The loop-bench index row was moved to the with-a-repo table. Branch hygiene: 14 merged remote branches deleted, and auto-delete of head branches turned on in all nine repos |
| 2026-09-27 | steel · course-lab | **Zoom-out: readers first.** The operator named real people waiting on four projects, and course-lab students go first. Checking the Algebra II pacing moved the first contact to `quadratics-ptr`. The operator ruled R4 (the discriminant alone is restating). Its frame named the discriminant, so it was reworded before any data (course-lab PR #20, v1.1.0). Calibration set Q1–Q8 added. The order for the other projects is logged in [[../initiatives/public-identity]] §Next instances |
| 2026-09-28 | course-lab | **`DEMO01` dry run FAILED at check 1.** Run on the **district network** from a **student Chromebook**: the web filter blocked `course-lab-two.vercel.app` before the page loaded. Checks 2–7 were never reached. The block page reads **Reason: Blocked by Category · Category: Games · Policy: Base/Default · Filtering method: Extension**. It's a vendor miscategorization, caught by the browser-extension layer. The 07-26 PASS in [[../wiki/collection-protocol]] was on the same network but used a **staff login** (operator-confirmed), so it never tested the student policy. Protocol amended: step 0 now names the login too. Next: ask district tech to allowlist the hostname, and ask the filter vendor to recategorize it as Education. The custom-domain branch is weaker now: a new domain goes through the same category crawler |
