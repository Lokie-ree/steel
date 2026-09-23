# Build Inventory

*Companion to `ai-collaboration-context.md`. One row per thing that exists.
Started 2026-08-23.*

---

## Why this file exists

I have been undervaluing what I've built. That is a claim, and my oath says I don't claim
what I haven't seen — which cuts both ways. This is the count.

**Rules for this file:**
- One row per artifact that exists. Not per idea, not per plan.
- Mark every row `[verified]` only after I have opened it and confirmed it runs or reads
  as described. Everything else stays `[unverified]` until I check. Rows below are seeded
  from my own record; **none are verified until I open them.**
- No student data, no rosters, no work samples, no names. Ever.
- Dead and retired things stay in the file with their lesson named. No orphans.

---

## A. Shipped and used by someone

| Artifact | What it is | State |
|---|---|---|
| Module M1 | Production interactive math module (R3F/GSAP) | `[unverified]` |
| Module M2 | Production interactive math module | `[unverified]` |
| Module M3 | Production interactive math module | `[unverified]` |
| CSE interactive | Standalone interactive | `[unverified]` |
| STEM Club field tests | Multiple sessions, live students; drove the Rigid Motions redesign | `[unverified]` |
| Portfolio site | Live deployment, OG image confirmed rendering | `[unverified]` |
| DEMO01 | Shipped demo | `[unverified]` |
| still-true | Hackathon entry: a forwarded document gets a line-cited reply ([[../projects/still-true]]). On 2026-09-21 it answered a forward from someone other than the operator, unattended, in 23.7 s. That is the first use from a domain it was never tested from | `[unverified]`. The repo's own gate read 8/8 against production on 09-22; flip this when you've opened it yourself |
| loop-bench, face one (`loop/index.html`) | Canonical 4–20 mA bench, three modes ([[../projects/loop-bench]]). Live at <https://lokie-ree.github.io/loop/> since 2026-08-24 and in front of students this sprint. Moved here from §B on 2026-09-22, because its §B blocker (hosting) was settled on 08-24 | `[unverified]` |

**This section is the answer to the undervaluation question.** Three production modules
plus a demo plus live student contact is not "getting started."

## B. Built, not yet in front of anyone

| Artifact | What it is | Blocker |
|---|---|---|
| `loop-bench.html` | Technician register; kept, not maintained | — (deliberately parked) |
| `verify_loop.py` | 59 assertions, exact rationals | — |
| Faces 2–6 | Designed, unbuilt | Gated: drift-seam fix **and** face one watched by a student |

## C. Repositories

`creative-lab-demos` · `creative-lab` · `portfolio` · `iste-26` · `steel` · `aida` ·
`sped-sync` · `still-true` · `Lokie-ree.github.io`

Nine repos, built from zero GitHub knowledge in about eighteen months.
`loop-bench` lives in `Lokie-ree.github.io`, and has since 2026-08-24. Until 2026-09-22 this line said it was "not yet among them."

**Per repo, when I verify it:** does it run today, does it have a card, does it have a
`CLAUDE.md`, is it public, does anything in it reference a student.

## D. Governance and operating layer

| Artifact | What it covers |
|---|---|
| Oath to Self (draft 1) | What I will not delegate |
| `ai-collaboration-context.md` | Role, students, constraints, goals, values for AI sessions |
| AI decision memo | District-facing AI governance ruling |
| `wiki/decisions` | Decisions of record |
| `CLAUDE.md` (per repo) | Conventions, commands, git state |
| Skills | creative-lab-conventions, module-planning-pipeline, educational-copywriter, session-end, and others |
| `loop-bench.md` card | Rulings, drift seam, failure history |

**This section is the real surprise.** Most solo builders have none of this. I wrote
evaluation thresholds before the data existed and deleted unused patterns on purpose.

## E. Professional record

- ISTE LIVE 2026 (Orlando, June 28–July 1). Peer connections made deliberately.
- Compliance training complete (youth safety, LA DCFS mandatory reporter).
- Supervisor who wants to keep the work.

---

## What the AI-native SDLC playbook says I already do

| Play | My version | Status |
|---|---|---|
| Committed artifact chain (intent → spec → plan) | `module-planning-pipeline` (MVP → PRD → UX spec → build prompts) | **Have it** |
| `CLAUDE.md` as shared context | Per-repo `CLAUDE.md` | **Have it** |
| Skills as institutional knowledge | Seven skills | **Have it** |
| Give the agent a feedback loop | `verify_loop.py` + headless landmark probe | **Have it, and it caught a real bug** |
| Incident → eval as regression test | Damping-filter failure history with generalized lesson | **Have it** |
| Decisions of record | `wiki/decisions`, plus rulings in each card | **Have it** |
| Continuous evals | **For me this is student testing, not CI.** The eval is a kid using the thing | **Missing — and it's the blocker** |
| Hooks, approval gates, branch protection, separation of duties, release managers, parallel worktrees | Solves coordination problems a solo builder does not have | **Do not adopt** |

**The translation that matters:** in an org, evals catch regressions before users do. For me,
there are no users yet. Ten minutes watching one student use *Find the rule* is the entire
eval suite, and it is the only play on this list I haven't run.

---

## Open blockers, in dependency order

1. **Hosting.** Artifacts don't persist. Nothing reaches a student until this is settled.
   Same personal-account ownership question as the teacher tech hub — settle once, for both.
   Lean district-owned: a public repo under my real name, tied to a named employer, serving
   content to minors is a conversation worth having *before* it happens.
2. **One student, ten minutes, *Find the rule*.** Predicted failure point. Watching resolves it.
3. **Drift-seam fix** — engine, range table, tolerance to one shared source.
4. Everything else.

## Not doing right now

- Faces 2–6 of loop-bench (gated above)
- RTI / LEAP 7–10 design work (deferred to year 2–3)
- Enterprise SDLC ceremony (see table)
- The inverse-reading mode for loop-bench (parked until after student contact)
