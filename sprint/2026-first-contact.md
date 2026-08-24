# Sprint — First Contact

**Window:** 2026-08-23 → 2026-09-19. The end date is a **planning horizon, not a deadline** — nothing external falls due on it. One interior date is real: **Unit 1 taught and reportable ≈ 2026-08-28** ([[../projects/algebra2-course-plan]]), which gates Units 2–6.

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
| 1 | **loop-bench → one student** | Teaching | Ten minutes, *Find the rule*, **watched — not asked afterward.** Predicted failure point is "how much does it go up for each inch"; if it fails, the fix is an intermediate step working two rows at a time. That is currently a guess, and watching is what converts it. |
| 2 | **The room → 8b** | Teaching | **Name the network.** One conversation with whoever stood up the community-college room. No device, no test, no Chromebook. Gates 9b — a dry run on an unnamed network scores a PASS that cannot be reused. |
| 3 | **course-lab → 9b** | Teaching | `DEMO01` dry run, seven checks, school device, **after 8b**. Record the network name in the result row ([[../wiki/collection-protocol]] §Which network, dry-run step 0). |
| 4 | **Algebra II Units 2–6** | Teaching | **Nothing — correctly held** until Unit 1 is taught and reportable (≈ 08-28). The three-document format is the thing under test; starting Unit 2 early tests nothing and forecloses the revision. |
| — | **Civics tool** | Facilitator | Two ratifications pending (source anchor, intake source field). Reconcile ceiling applies ([[../wiki/decisions]] D-2026-08-23): no build without going through [[../initiatives/issue-ledger]]'s gate. |
| — | **Tech Station** | Facilitator | Reading, not building. The supervisor's district-pulse ask runs off incidentIQ, which already logs it. |
| — | **Six spokes** | — | All clean, 0 ahead / 0 behind. Drift 22/0 is a regression tripwire on frozen code, not a status signal. Touch only if something breaks. |

---

## Explicitly not doing this sprint

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
