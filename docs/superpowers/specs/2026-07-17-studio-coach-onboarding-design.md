# Studio-Coach Onboarding — Design

**Date:** 2026-07-17
**Status:** Approved design, pending spec review
**Decision driver:** Randall — "this vault upholds my development workflow; studio-coach should be under the STEEL umbrella."

## 1. What this is

Bring `project-studio-coach` (AI scoping coach for Mr. L's high-school club; Convex + Vite/React/TS; local path `C:/Users/rplap/OneDrive/Desktop/personal/project-studio-coach`) under STEEL governance as the **sixth spoke**. Two ordered concerns: publish the repo to GitHub, then register it in the hub. Deploy is explicitly out of scope.

**Current repo state (verified 2026-07-17):** already a local git repo — `main` holds one docs-only bootstrap commit (satisfies the bootstrap-on-main founding exception); `feature/studio-coach-build` (current branch, clean tree) holds 13 commits of app work; **no remote**. Founding-clause gaps: missing `.gitattributes`; not yet on GitHub.

**Scope ruling (Randall, 2026-07-17):** GitHub publish + hub registration only. Repo name `project-studio-coach`, private. Hub identity framing: **workflow-governance hub** (see §3, decisions.md append).

## 2. Concern 1 — publish (in the spoke repo)

All work on the existing `feature/studio-coach-build` branch. Steps, in order:

1. **Pre-push secret audit — hard gate.** Confirm `.env.local` is untracked (`git ls-files`); scan full history for secrets (`git log -p` grepped for `sk-`, `key`, `token`, `CONVEX_DEPLOY`). A hit stops the plan — history rewrite before any push, surfaced to Randall first.
2. **README accuracy fix.** The "Honest limitations" bullet claiming the deployment's OpenAI key is dead is stale — an active key is stored in the Convex dashboard environment (Randall, 2026-07-17). Correct the bullet (and the Setup section's "currently-set one is expired" line) in one small commit.
3. **`.gitattributes`** (`* text=auto`) committed on the feature branch — patches the founding-clause gap (the clause puts it in the root commit; the root commit predates the clause, so it lands here instead).
4. **Publish:** `gh repo create Lokie-ree/project-studio-coach --private`; push `main`; push `feature/studio-coach-build`.
5. **Integrate:** PR `feature/studio-coach-build` → `main`; self-merge with a `Merge: …` title; pull `main` locally; delete the merged branch. All 14 pre-admission commits are grandfathered (the 13-commit branch merges as one PR; the baseline is already on `main`) — conventions apply from admission forward, not retroactively.

**Exit state (gates Concern 2):** clean tree, local `main` == `origin/main`, private remote exists, PR shows merged.

## 3. Concern 2 — register (in steel)

Starts only after Concern 1's exit state is verified — the proven checklist's ordering rule: a dirty or remote-less spoke flips session briefs to UNVERIFIED. Steel edits on branch `docs/register-studio-coach`, shipped as one PR. Checklist reused from `course-lab/docs/course-lab-founding-spec.md` §2 (proven by execution 2026-07-09):

| Item | Hub target | Content |
|---|---|---|
| Local-paths row | `index.md` → Local paths table | Machine-read by `Get-SpokePaths`; auto-enrolls studio-coach in drift-check + build-context |
| Project card | `projects/project-studio-coach.md` | House format. `## Role` section (feeds build-context's `context.md`): AI coach teaching students to scope oversized ideas into finishable projects (ISTE+ASCD AI-Ready Graduate, Learner 1.1); Convex backend (Agent/Workflow/RAG components) + OpenAI via AI SDK + Vite/React/TS; prototype — **standing warning: no auth; do not deploy beyond the trusted club**. Priority P6 (course-lab P5-as-lowest pattern). Not an ISTE surface → **no Tier 1 sync fields** |
| Spoke-count updates | `index.md` (line 3), `projects/index.md` (line 3), `wiki/ecosystem-map.md` (line 3), `wiki/index.md` (line 7), `drift-check` SKILL.md (line 9) | The five verified hardcodes of the spoke count (grep-confirmed 2026-07-17) → six. Note this list differs from the course-lab-era checklist: the `session-start` skill no longer hardcodes a count; `wiki/index.md` does. `ops/tests/HubContext.Tests.ps1` line 240 ("all four spokes") is fixture text — leave it alone |
| decisions.md append | `wiki/decisions.md` (append-only) | Ruling: **STEEL is a workflow-governance hub** — it governs development workflow (git conventions, session briefs, drift/state visibility) for any actively-developed project Randall registers; ISTE-arc is one cluster among spokes, not the hub's definition. studio-coach admitted 2026-07-17; pre-admission history grandfathered |

Also updated in the same pass: the hub-identity line in `index.md`, and (outside the PR — agent memory, not vault content) `project_steel_hub.md` and `git-workflow-convention` memory repo lists.

## 4. Verification

- **After Concern 1:** `git status` clean; `gh pr view` merged; `git rev-parse main origin/main` identical.
- **After Concern 2:** run `ops/drift-check.ps1` — preflight lists **six** spokes, studio-coach clean/current; Stage 1 SKIP for studio-coach (".hub not installed") is expected hub-wide behavior, not a failure. Pre-existing iste-26 dirty state is out of scope.
- If registration requires re-reading ops script source to rediscover enrollment side effects despite the §2 checklist, the deferred register-spoke skill's named trigger fires — build it then (per `friction-spoke-registration-fanout`).

## 5. Explicitly not doing

- **Deploy** (Convex prod / frontend host) — blocked on auth; the README's own warning stands.
- **`.hub/` bundle install** — the spoke rollout is deferred hub-wide (operator decision); studio-coach joins that deferral.
- **Retroactive history splitting** of the 13-commit feature branch.
- **register-spoke skill** — checklist reuse is the path that keeps the 2026-07-09 deferral valid.
- **Tier 1 sync fields** for studio-coach — not an ISTE surface.
