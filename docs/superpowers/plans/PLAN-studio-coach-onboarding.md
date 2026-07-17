# Studio-Coach Onboarding Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.
> **Git override (Randall's global rules):** NO worktrees. Concern 1 runs on the spoke's existing `feature/studio-coach-build` branch; Concern 2 runs on steel's existing `docs/register-studio-coach` branch. Steel commits are pre-authorized for this plan's execution only.

**Goal:** Publish `project-studio-coach` to a private GitHub repo and register it as STEEL's sixth spoke under the workflow-governance ruling.

**Architecture:** Two ordered concerns from the approved spec (`docs/superpowers/specs/2026-07-17-studio-coach-onboarding-design.md`): Concern 1 finishes the spoke's founding (secret audit → README fix → `.gitattributes` → GitHub → PR self-merge); Concern 2 executes the proven §2 registration checklist in steel. Concern 2 MUST NOT start until Concern 1's exit state is verified.

**Tech Stack:** git, `gh` CLI, PowerShell, Obsidian-flavored markdown. No application code changes.

**Spoke path:** `C:/Users/rplap/OneDrive/Desktop/personal/project-studio-coach` (below: `$SPOKE`)
**Hub path:** `C:/Users/rplap/OneDrive/Desktop/steel` (below: `$HUB`)

---

## Concern 1 — Publish the spoke

### Task 1: Pre-push secret audit (HARD GATE)

**Files:** none modified — read-only audit.

- [ ] **Step 1: Confirm `.env.local` is untracked**

Run: `git -C $SPOKE ls-files | Select-String -Pattern '\.env'`
Expected: no output (pattern deliberately excludes the tracked `src/vite-env.d.ts`). If `.env.local` appears, STOP — surface to Randall (requires history rewrite before any push).

- [ ] **Step 2: Confirm `.gitignore` covers it**

Run: `Get-Content $SPOKE/.gitignore`
Expected: a line matching `.env.local` or `.env*`. If missing, add the line in Task 2's commit.

- [ ] **Step 3: Scan full history for secrets**

Run: `git -C $SPOKE log -p --all | Select-String -Pattern 'sk-[A-Za-z0-9_-]{8}', 'CONVEX_DEPLOY', 'api[_-]?key\s*[:=]\s*["'']?\w', 'Bearer ' | Select-Object -First 40`
Expected: only documentation mentions (e.g., README's `npx convex env set OPENAI_API_KEY sk-...` placeholder, docs/auth-notes.md prose). Any string that looks like a REAL credential (long random suffix) = STOP, surface to Randall, do not push anything.

### Task 2: README accuracy fix

**Files:** Modify: `$SPOKE/README.md` (Setup section ~line 32; "Honest limitations" bullet ~line 73)

- [ ] **Step 1: Verify still on the feature branch with clean tree**

Run: `git -C $SPOKE status -sb`
Expected: `## feature/studio-coach-build`, no dirty lines.

- [ ] **Step 2: Edit the two stale key claims**

In Setup, replace:
`# The deployment needs a VALID OpenAI key (the currently-set one is expired):`
with:
`# The OPENAI_API_KEY on the deployment is managed in the Convex dashboard (active). To rotate:`

In "Honest limitations", replace the bullet beginning `**The OpenAI key currently on the deployment is dead**` (and its continuation lines about live coaching being blocked / unverified) with:
`- **Live coach behavior is prompt-engineered** from ``docs/coach-instructions.md`` and playtested via the 4-persona CLI harness; ``prompts/prompt-2-playtest.md`` tracks remaining live-verification work. The deployment's OpenAI key is managed in the Convex dashboard environment.`

- [ ] **Step 3: Commit**

```powershell
git -C $SPOKE add README.md
git -C $SPOKE commit -m "docs: README key-status accuracy — key lives in Convex dashboard env, active"
```

### Task 3: Add `.gitattributes`

**Files:** Create: `$SPOKE/.gitattributes`

- [ ] **Step 1: Create the file** — content exactly:

```
* text=auto
```

- [ ] **Step 2: Commit**

```powershell
git -C $SPOKE add .gitattributes
git -C $SPOKE commit -m "chore: add .gitattributes (* text=auto) per founding convention"
```

### Task 4: Create private GitHub repo and push

- [ ] **Step 1: Create repo + wire remote**

Run: `gh repo create Lokie-ree/project-studio-coach --private --source "$SPOKE" --remote origin`
Expected: repo URL printed; `git -C $SPOKE remote -v` shows origin fetch/push.

- [ ] **Step 2: Push both branches**

```powershell
git -C $SPOKE push -u origin main
git -C $SPOKE push -u origin feature/studio-coach-build
```

Expected: both succeed; `gh repo view Lokie-ree/project-studio-coach --json visibility` → `"visibility": "PRIVATE"`.

### Task 5: PR, self-merge, clean up

- [ ] **Step 1: Open the PR**

```powershell
gh pr create --repo Lokie-ree/project-studio-coach --base main --head feature/studio-coach-build --title "Studio-coach build: full prototype (13 pre-admission commits, grandfathered)" --body "Publishes the complete prototype built before STEEL admission. Per the onboarding spec, pre-admission history merges as one PR; single-concern conventions apply from admission forward.`n`n🤖 Generated with [Claude Code](https://claude.com/claude-code)"
```

- [ ] **Step 2: Self-merge with `Merge: …` title (merge commit, not squash)**

Run: `gh pr merge feature/studio-coach-build --repo Lokie-ree/project-studio-coach --merge --subject "Merge: studio-coach build — full prototype (PR #1)"`
Expected: merged.

- [ ] **Step 3: Sync local, delete merged branch**

```powershell
git -C $SPOKE checkout main
git -C $SPOKE pull
git -C $SPOKE branch -d feature/studio-coach-build
git -C $SPOKE push origin --delete feature/studio-coach-build
```

- [ ] **Step 4: Verify Concern 1 exit state (gates Concern 2)**

Run: `git -C $SPOKE status -sb; git -C $SPOKE rev-parse main origin/main`
Expected: `## main...origin/main` with no ahead/behind/dirty; the two hashes identical. If not, STOP and fix before Concern 2.

---

## Concern 2 — Register the sixth spoke (in steel)

All edits on existing branch `docs/register-studio-coach`. Commit after each task (checkpoint rule).

### Task 6: `index.md` — identity line + Local-paths row

**Files:** Modify: `$HUB/index.md` (line 3; Local paths table ~line 47)

- [ ] **Step 1: Replace line 3** (`**Purpose:** Shared brain for five Creative Lab repos. …`) with:

`**Purpose:** Workflow-governance hub for six registered repos — git conventions, session briefs, drift/state visibility (ruling 2026-07-17, [[wiki/decisions]]). Read this file first in any agent session where `steel` is in the workspace.`

- [ ] **Step 2: Append Local-paths row** (this is the machine-read enrollment point — `Get-SpokePaths` auto-enrolls the spoke in drift-check + build-context):

`| project-studio-coach | `C:/Users/rplap/OneDrive/Desktop/personal/project-studio-coach` |`

- [ ] **Step 3: Commit**

```powershell
git -C $HUB add index.md
git -C $HUB commit -m "docs(hub): workflow-governance identity + enroll project-studio-coach in Local paths"
```

### Task 7: Project card + registry table

**Files:** Create: `$HUB/projects/project-studio-coach.md` · Modify: `$HUB/projects/index.md` (lines 3, table, note ~line 13)

- [ ] **Step 1: Create the card** — full content:

```markdown
# project-studio-coach

**GitHub:** [Lokie-ree/project-studio-coach](https://github.com/Lokie-ree/project-studio-coach) (private)
**Local:** `C:/Users/rplap/OneDrive/Desktop/personal/project-studio-coach`
**Live:** — (not deployed; **standing warning:** no auth — do not deploy beyond the trusted club)
**Branch:** `main` (default; feature-branch only, never commit to main)
**Agent entry:** `CLAUDE.md` (ground truth) → `README.md` → `docs/`

## Role

AI coach that teaches students to scope a vague, oversized idea into a project they can finish, then writes what they learned back into a living, teacher-gated archetype library. Built for the voluntary, ungraded high-school club. Pedagogical thesis: ISTE+ASCD *Profile of an AI-Ready Graduate*, Learner 1.1 — the **student** does the focusing; the coach withholds the library's pre-written plans until the student's own plan exists. Not an ISTE-arc surface; workflow-governance spoke (P6).

## Stack

Convex backend (Agent, Workflow, RAG, Rate Limiter, Aggregate, Persistent Text Streaming) · OpenAI via Vercel AI SDK — all model calls server-side in Convex actions; **this repo never calls the Anthropic API** · Vite + React + TypeScript frontend. `OPENAI_API_KEY` is managed in the Convex dashboard environment (active as of 2026-07-17).

## Commands

```bash
npm install && npm run dev   # Vite :5173 + convex dev watcher
npm run typecheck            # both TS projects
npx convex run seed:run      # teacher + 24 archetypes + RAG ingest
node scripts/verify-ui.mjs   # Playwright walk of student + teacher flows
```

## Sync obligations

None — not an ISTE surface, no Tier 1 fields.

## Status (2026-07-17)

- Admitted to STEEL as sixth spoke; 13 pre-admission commits (1 bootstrap + 12 build) grandfathered (conventions apply from admission forward)
- Prototype complete on `main`; coach behavior playtested via 4-persona CLI harness
- **No authentication** — identity is "pick your name"; teacher screen is an unauthenticated route. Hard stop on deploying beyond the trusted club.
```

- [ ] **Step 2: Update `projects/index.md`** — line 3 `Five repos. One ecosystem.` → `Six repos. One ecosystem.`; append table row:

`| project-studio-coach | [[project-studio-coach]] | — (not deployed) | AI scoping coach (Convex + React), club prototype, archetype library |`

and extend the "Not in the curriculum grid" note with: `project-studio-coach — club platform outside the ISTE arc entirely; workflow-governance spoke, no Tier 1 sync fields.`

- [ ] **Step 3: Commit**

```powershell
git -C $HUB add projects/project-studio-coach.md projects/index.md
git -C $HUB commit -m "docs(projects): project-studio-coach card + registry row (sixth spoke)"
```

### Task 8: Wiki — ecosystem map count, wiki index count, decisions ruling

**Files:** Modify: `$HUB/wiki/ecosystem-map.md` (line 3) · `$HUB/wiki/index.md` (line 7) · `$HUB/wiki/decisions.md` (append row)

- [ ] **Step 1: `ecosystem-map.md` line 3** → replace with:

`Six repos: the four in the ISTE arc below, plus two workflow-governance spokes outside the arc — [[../projects/course-lab|course-lab]] and [[../projects/project-studio-coach|project-studio-coach]]. One hub, two clusters, plural rendering stacks.`

- [ ] **Step 2: `wiki/index.md` line 7** → `| [[ecosystem-map]] | How the six repos relate |`

- [ ] **Step 3: Append to `wiki/decisions.md`** (append-only — do not touch existing rows):

`| 2026-07-17 | **STEEL is a workflow-governance hub; project-studio-coach admitted as sixth spoke.** The hub governs development workflow (git conventions, session briefs, drift/state visibility) for any actively-developed project the operator registers; the ISTE arc is one cluster among spokes, not the hub's definition. studio-coach's 13 pre-admission commits (1 bootstrap + 12 build) are grandfathered — conventions apply from admission forward. | Admitting a non-ISTE, non-Creative-Lab platform forced the identity question; deciding it once beats re-litigating per project. | [[../projects/project-studio-coach]] · [[../index]] Purpose line · `docs/superpowers/specs/2026-07-17-studio-coach-onboarding-design.md` |`

- [ ] **Step 4: Commit**

```powershell
git -C $HUB add wiki/ecosystem-map.md wiki/index.md wiki/decisions.md
git -C $HUB commit -m "docs(wiki): six-repo counts + workflow-governance-hub ruling in decisions log"
```

### Task 9: drift-check skill count

**Files:** Modify: `$HUB/.claude/skills/drift-check/SKILL.md` (line 9)

- [ ] **Step 1: Line 9** — replace `git preflight covers all five` with `git preflight covers all six`. **Leave `ops/tests/HubContext.Tests.ps1:240` alone — it asserts 4 spokes against the live index.md and is already stale/failing at 5; pre-existing, out of scope for this PR (do not "fix" it here).**

- [ ] **Step 2: Commit**

```powershell
git -C $HUB add .claude/skills/drift-check/SKILL.md
git -C $HUB commit -m "docs(skills): drift-check preflight count five -> six"
```

### Task 10: Verification run

- [ ] **Step 1: Run drift-check**

Run: `pwsh $HUB/ops/drift-check.ps1`
Expected: preflight table lists **six** repos including `project-studio-coach` on `main`, 0 ahead / 0 behind / dirty False. Stage 1 shows `SKIP project-studio-coach (.hub not installed)` — expected hub-wide, not a failure. Stage 2 unchanged from the current baseline (22/0 as of 2026-07-17). Verdict may still be UNVERIFIED if iste-26 remains dirty — pre-existing, out of scope; the success criterion is ONLY the studio-coach row being present and clean.

- [ ] **Step 2: If studio-coach row is missing or errors** — the Local-paths row (Task 6) is malformed; fix the table row, do NOT patch ops scripts. If fixing requires re-reading ops script source to rediscover behavior, note it: that fires the deferred register-spoke skill trigger (`friction-spoke-registration-fanout` memory).

### Task 11: Ship the steel branch

- [ ] **Step 0: Commit this plan file onto the branch** (must precede the push)

```powershell
git -C $HUB add docs/superpowers/plans/PLAN-studio-coach-onboarding.md
git -C $HUB commit -m "docs(plans): studio-coach onboarding plan"
```

- [ ] **Step 1: Push and open PR**

```powershell
git -C $HUB push -u origin docs/register-studio-coach
gh pr create --repo Lokie-ree/steel --base master --head docs/register-studio-coach --title "Register project-studio-coach as sixth spoke (workflow-governance ruling)" --body "Executes the approved onboarding spec: identity line, Local-paths enrollment, project card, spoke-count updates (5 verified surfaces), decisions.md ruling. Spec + plan included.`n`n🤖 Generated with [Claude Code](https://claude.com/claude-code)"
```

- [ ] **Step 2: Self-merge**

Run: `gh pr merge <N> --repo Lokie-ree/steel --merge --subject "Merge: register project-studio-coach as sixth spoke"`
Then: `git -C $HUB checkout master; git -C $HUB pull; git -C $HUB branch -d docs/register-studio-coach`

### Task 12: Memory updates (outside the repo — Write tool, no commit)

**Files:** Modify: `C:\Users\rplap\.claude\projects\C--Users-rplap-OneDrive-Desktop-steel\memory\project_steel_hub.md` · `feedback_git_workflow.md` · `MEMORY.md`

- [ ] **Step 1:** `project_steel_hub.md` — description + body: six spokes; add studio-coach row (P6, not deployed, no-auth warning, admitted 2026-07-17); identity = workflow-governance hub (ISTE arc one cluster).
- [ ] **Step 2:** `feedback_git_workflow.md` — add `project-studio-coach` to the repo list line.
- [ ] **Step 3:** `MEMORY.md` — update the Steel Hub hook line to say 6 repos / workflow-governance hub.
