# Sprint — First Contact

**Window:** 2026-08-23 → 2026-09-22. **The end date is a deadline now.** It opened as a planning horizon with nothing external falling due on it, and was extended from 09-19 on 2026-08-27 so this doc cannot expire three days before the only hard external date in the vault. One interior date is real: **Unit 1 taught and reportable ≈ 2026-08-28** ([[../projects/algebra2-course-plan]]), which gates Units 2–6. **The end date itself is the second: submissions close 2026-09-22, 12:00 PM PT (2:00 PM CT)** — external, hard, and unmovable.

**The test this sprint exists to pass:** *something built this fall gets used by the person it was built for, while the operator watches.*

Update this file at the **start and end** of each work session.

---

## Why that is the whole sprint

At sprint open, **five separate documents independently recorded that nothing has met a student** — five vocabularies, no links between any of them:

| Doc | How it says it |
|---|---|
| [[../wiki/depth-criteria]] | Build two waits on build one's student data |
| [[../archive/2026-fall-runway]] item 9b | The `DEMO01` dry run, still unrun |
| `build-inventory.md` | "Continuous evals … **Missing — and it's the blocker**" |
| [[../projects/loop-bench]] §Status | "Not yet in front of a single student" |
| [[../initiatives/reconciliation-layer]] | "The build has outrun the validation" |

The fall was productive and unvalidated at the same time. Only one of those halves is fixable this month, and it is not the productive one.

**Horizon rule.** From the operator's own AI-collaboration context §3: the planning horizon is short and the unit of work is *the next thing handed to a student.* This doc therefore carries **one next action per surface** and no roadmap. If it grows one, that is the drift, not the plan.

---

## The correction that opens P1

`build-inventory.md` lists blockers in dependency order and puts **hosting** first — *"Artifacts don't persist. Nothing reaches a student until this is settled."*

**True for a class. False for one student**, and that difference is the entire sprint.

Verified against the file 2026-08-23, not taken from the card: `loop-bench-student.html` makes **zero** network calls, loads **zero** external assets, and touches **no** storage API. Grep for `fetch(` / `XMLHttpRequest` / `WebSocket` / `localStorage` / `sessionStorage` / `https://` / `<script src=` / `<link href=` returns nothing at all. The card claimed self-containment; it is now checked.

So the n=1 case has **no hosting dependency**. One student, the operator's own laptop or a USB stick, ten minutes. **Blocker 2 does not wait on blocker 1** — the item that has been sitting behind a hosting decision since 2026-08-22 can happen this week.

---

## Priority stack — by surface, not by repo

Four of the six spokes are dormant by ruling and the rest are clean; a repo-keyed stack would list six rows of nothing. The fall's work happens on **surfaces**, two of which have no repo behind them ([[../wiki/decisions]] D-2026-08-23).

| P | Surface | Role | The one next action |
|---|---|---|---|
| 0 | **Hackathon → submitted** | Public identity | **Dry submission by 2026-09-01** — public repo, `hackathon.md` at root, a deployed `convex.site` URL, a 90-second video, filed on vibeapps. Content quality is not the test; the pipeline existing is. Multiple submissions are allowed by the rules, so an early bad one costs nothing and removes the only failure mode with a precedent. |
| 1 | **loop-bench → one student** | Teaching | Ten minutes, *Find the rule*, **watched — not asked afterward.** Predicted failure point is "how much does it go up for each inch"; if it fails, the fix is an intermediate step working two rows at a time. That is currently a guess, and watching is what converts it. |
| 2 | **The room → 8b** | Teaching | **Name the network.** One conversation with whoever stood up the community-college room. No device, no test, no Chromebook. Gates 9b — a dry run on an unnamed network scores a PASS that cannot be reused. |
| 3 | **course-lab → 9b** | Teaching | `DEMO01` dry run, seven checks, school device, **after 8b**. Record the network name in the result row ([[../wiki/collection-protocol]] §Which network, dry-run step 0). |
| 4 | **Algebra II Units 2–6** | Teaching | **Nothing — correctly held** until Unit 1 is taught and reportable (≈ 08-28). The three-document format is the thing under test; starting Unit 2 early tests nothing and forecloses the revision. |
| — | **Planning tool** | Facilitator | Two ratifications pending (source anchor, intake source field). Reconcile ceiling applies ([[../wiki/decisions]] D-2026-08-23): no build without going through [[../initiatives/issue-ledger]]'s gate. |
| — | **Tech Station** | Facilitator | Reading, not building. The supervisor's district-pulse ask runs off incidentIQ, which already logs it. |
| — | **Six spokes** | — | All clean, 0 ahead / 0 behind. Drift 22/0 is a regression tripwire on frozen code, not a status signal. Touch only if something breaks. |

**P1 moves before P0 in time, not in priority.** Ten minutes, one student, *Find the rule*, watched — this week, before 08-28. It is the item this sprint exists for, it has no hosting dependency, and it has already slipped once behind an unrelated blocker. If it slips again it will slip past the whole hackathon window.

---

## Explicitly not doing this sprint

- **Any hackathon scope that requires student data.** Not a preference, an inherited hard line. A public URL judges open with no invite means synthetic or adult-facing, ruled at schema time.
- **Reusing pre-08-25 code.** Only apps started on or after 2026-08-25, 12:00 PM PT qualify. Patterns, skills, and house style transfer; repos do not. Do not open a spoke looking for a shortcut.
- **New features after the final gate date** ([[../initiatives/public-identity]] §Release gate). Post-freeze work goes to the video and the write-up, not the app.
- **Reframing the vault.** Considered and rejected at sprint open. The frame was sound; four line-level edits fixed what was stale. A reorganization has no downstream reader — the operator's own §5.3 test — and is the documented shiny-build sidecar in vault form.
- **Faces 2–6 of loop-bench** — gated on the drift-seam fix **and** face one watched by a student. Both, not either.
- **Hosting, beyond the n=1 case.** It gates a class, not this sprint's test. Still the same personal-vs-district account question open on the Tech Station; settle it once, for both.
- **Build two / any second module** — gated on [[../wiki/depth-criteria]], unchanged.
- **Widening the [[../wiki/patterns]] admission bar** for [[../initiatives/reconciliation-layer]]. It stays in `initiatives/` until the fall's builds have readers.
- Carried unchanged from [[../archive/2026-fall-runway]]: ISTE 27/28 planning, monorepo / shared packages, new studio-coach features, the post-ISTE System graph, rebuilding `family-coverage.md`, the Fable standards-mapping audit, a third transformation family.
- Carried from [[../initiatives/issue-ledger]]: a solicited intake envelope, a personalization instrument, any new instrument for a lens that already has one.

---

## Session log

| Date | Surface | What happened |
|------|---------|---------------|
| 2026-08-23 | steel | **Sprint opened.** Fall Runway archived 13 days past its window — every briefing since 08-10 had been reading a dead priority stack as live. Priority stack re-keyed from repos to **surfaces**, because four of six spokes are dormant by ruling and the fall's actual work has no repo behind it. Reframing the vault was **considered and rejected**: the frame held, four line-level edits fixed the staleness |
| 2026-08-23 | loop-bench | **P1 unblocked by a verified correction.** `build-inventory.md`'s dependency order puts hosting ahead of student contact; checked against the file, `loop-bench-student.html` has zero network calls, zero external assets, zero storage APIs, so the n=1 case never needed hosting. The one item that most directly answers this sprint's test had been filed behind an unrelated blocker |
| 2026-08-23 | loop-bench | **Card filed** ([[../projects/loop-bench]]) — the fall's most complete build, previously zero mentions vault-wide. Two defects found while verifying it, both recorded, neither fixed: `verify-loop-bench.py` **prints `OK - 49 checks passed` before running its last ten checks**, so a failing run shows a pass to anyone reading the wrong line (one-line fix); and both HTML files render in **quirks mode** with no doctype, which is *not* a safe drive-by — the layout was hand-tuned against quirks-mode box geometry, so adding one carries a re-check at 880/390 px. Card's verifier filename corrected (`verify_loop.py` -> `verify-loop-bench.py`) and the Size column dropped as transcribed state |
| 2026-08-23 | steel | **Role amendment ruled** ([[../wiki/decisions]] D-2026-08-23): the 2026-08-03 build-surface ruling bounds the *teaching* role only; the facilitator role is a second surface at a **reconcile-only** ceiling. Resolves [[../initiatives/reconciliation-layer]] §Open questions 1 — which asked whether that ruling was being violated — as **a gap, not a violation**. Corrects the doc's count: two of its four fall surfaces are not Algebra II, not three, because **loop-bench *is* the Algebra II applied layer**, one panel per unit |
| 2026-08-23 | steel | North star and Purpose de-staled in [[../index]]. The north star had been **wrong three times in six weeks** (six preps -> two preps -> one course), swept each time only after a session tripped over it, because it restated the current ruling instead of pointing at the log. Now marked derived, dated, and pointed at [[../wiki/decisions]] — the same rule as *git state is derived, never transcribed*, applied to the vault's most-read line. Purpose line no longer claims the hub is six repos |
| 2026-08-23 | steel | **[[../initiatives/reconciliation-layer]] filed** — seventh initiative, and the first whose subject is not a repo. Filed rather than promoted into [[../wiki/patterns]]: its own §Standing risk is the argument against admission, since four instances with no downstream reader are four hypotheses, and patterns' §1 correction already rules that a layer earns its place from the reader downstream. Revisit trigger named — the first fall surface that gets used by the person it was built for. Its three pre-commit checks were run rather than carried forward: placement (one copy, not two), sync registry (**no Tier 1 field touched**, verified against [[../sync-registry]]), and extend-don't-create (checked against [[../initiatives/issue-ledger]] and patterns; neither covers cross-surface shape). Open questions 1 and 2 closed, 3 re-checked as the doc's own rule demands on extension, 4 left open but now visibly shaping the sprint it was cut into |
| 2026-08-23 | steel | **Link repair, found by a vault-wide dangling-wikilink scan** run to verify this session's own edits. Archiving the runway doc orphaned **four** inbound links from [[../wiki/decisions]] — repaired to `archive/`; the ruling prose was not touched, since the append-only rule protects rulings, not their pointers. The scan also caught two pre-existing breaks that predate this session: [[../CLAUDE]] pointed at `../wiki/decisions`, escaping the vault entirely — residue of the 2026-07-31 move of `ops/claude.md` to the root, where the file moved and one link did not — and `drift-check/SKILL.md` was one directory level short. **Both were in always-loaded agent context.** Two links remain deliberately forward-looking, to `initiatives/reconciliation-layer`, which is still staged in `~/Downloads` and unfiled |
| 2026-08-24 | loop-bench | **Defect 1 fixed** ([[../projects/loop-bench]] §Known defects) — the premature `print` deleted from `verify-loop-bench.py`. Root cause was structural, not typographical: the 0–80 in block was **appended after the final print instead of before it**, which is why the count in the success line (49) never matched the count the card claimed (59). Verified by corrupting one of the last ten checks on a scratch copy and running both versions — the old file printed `OK - 49 checks passed` *then* raised; the fixed file raises with no `OK` line at all. Clean run: `OK - 59 checks passed`, `exit=0`. **Defect 2 (quirks mode) deliberately untouched** — still not a safe drive-by, still belongs with the drift-seam work before face two |
| 2026-08-24 | steel | **Phantom dirty file cleared, and it was not what the diagnosis assumed.** `projects/algebra2-course-plan.md` had shown as modified with an **empty** diff; the cause was not CRLF in the worktree but `core.autocrlf=true` expecting CRLF and finding LF — index and worktree were *both* LF, so git flagged the stat entry while the clean filter normalized content back to identical. Status said modified, `git diff --exit-code` said 0, and it could not resolve on its own. `git add --renormalize` cleared it losslessly (`git diff --cached --stat` empty — nothing to stage). `.gitattributes` added with `* text=auto` so the normalization is a property of the repo rather than of whichever machine has `autocrlf` set. steel predates the 2026-07-09 founding clause that requires it in new repos ([[../CLAUDE]] §Git); this is that clause applied retroactively to the one repo that missed it |
| 2026-08-27 | steel | **Hackathon filed as the third surface.** The three staged pieces in `hackathon-vault-entries.md` applied to their separate targets and the staging file deleted: ruling **D-2026-08-26** to [[../wiki/decisions]] (index + log), the release gate to [[../initiatives/public-identity]], and this doc's window note, **P0**, and three not-doing lines. `ai-collaboration-context.md` and `build-inventory.md` **stay at the vault root** rather than moving into a folder — D-2026-08-23 cites the first by name inside its `Why` cell, which is append-only, so a move would break a citation in an immutable ruling. Both are now registered in [[../index]]'s vault map, which had listed only directories. **Window extended 09-19 → 09-22** in the same session, so the horizon covers the deadline rather than ending three days short of it — same failure class as the runway doc that ran 13 days past its window while briefings read it as live. Yesterday's ruling is untouched: the hackathon stays P0 inside this sprint, P1 stays the item the sprint exists for |
