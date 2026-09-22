# Lessons — how the operator works, harvested at project close

Gap this doc fills: [[patterns]] holds what gets *built* again. Nothing held what the *builder* keeps relearning, so those lessons were re-recorded in sprint rows, repo logs, and Claude's local memory, and weren't acted on. The sponsor-issue delay was written down three times in one build log. Opened 2026-09-22 by the first project-close harvest ([[../projects/still-true]]).

**Admission rule:** a lesson is recorded on **two or more separate occasions**, in one project or across several. One occurrence is an anecdote and goes in the project's own log. **Every lesson names the check that catches it.** A lesson with no check is a mood.

**Lifecycle:** *open* → *graduated* once a rule (`CLAUDE.md`) or a hook enforces it, and then it no longer needs remembering. The goal is for this file to shrink.

---

## Open

### 1. Shipping finished work costs more than building it

**Evidence:**
- The first hackathon, a year earlier, built aida to a quality later ratified as canonical and never submitted.
- All Gas release gate row 1 (the dry submission) was missed on 2026-09-01, while the build itself ran ahead of schedule.
- Two sponsor issues sat draft-ready from 09-10 to 09-21 with nothing blocking them. still-true's log recorded this three times and called it "the finding rather than the anecdote."

**The check:** a dated release gate whose default is release ([[../initiatives/public-identity]] §Release gate). It worked on the row that decided the outcome. **Still missing:** a gate for the *small* finished things (issues, posts, write-ups) that no deadline ever forces.

### 2. A correction lands on the file being edited, not on the files that quote it

**Evidence:**
- still-true logged six instances by 09-20: the demo length (2:42 vs 2:43) across four files, the README trust section a gate short, `og.jpg` outliving a retracted number twice, and the five shoot-mechanics sections.
- In the vault: a plan carried a stale Playwright path while `~/.claude/CLAUDE.md` had the right one (2026-07-24). A sprint doc also ran thirteen days past its window.

**The check:** **grep the value across the whole repo, not just the file you came to fix** (still-true 09-20). Structurally, reference a value, don't paste it (`CLAUDE.md` §Tooling paths). **Partially graduated:** the vault's "derived, never transcribed" rule covers git state and tool paths, but not numbers quoted in prose.

### 3. Read the artifact, not the note about the artifact

**Evidence:**
- still-true 09-03: production was nine commits behind while dev and the docs looked correct.
- still-true 09-20: "172 was never measured," concluded by grepping notes, while `og.jpg` itself showed 172.
- still-true 09-21: a sponsor issue went live with a mangled title, and the command's exit code said success.
- The same class drove the vault's git-state rule: state is output of `ops/repo-state.ps1`, never prose.

**The check:** open the thing a stranger would open: the live URL, the filed issue, the rendered card. An exit code, a note, or a grep of your own prose is not a receipt.

### 4. Predeclare the threshold before the data, and record a no-fire as a no-fire

**Evidence:**
- still-true probe v3 was committed before a single fetch, because an earlier GO had been called on codes invented after seeing results.
- still-true's shell-page detectors ran against a zero false-positive budget, and all three died with no threshold rescue (09-07).
- H10 was closed as one field after a ten-minute predeclared measurement (09-16).
- In the vault: [[depth-criteria]] set build two's gate before any student data existed, and loop-bench's predicted failure point was written before the student was watched.

**The check:** the threshold is committed (a git timestamp) before the first measurement. **Behaves as graduated in practice:** it's in how the operator already works. Keep it here until a second non-hackathon project confirms that.

### 5. Reach for what the stack ships before writing it

**Evidence:**
- still-true 09-02: a SHA-256 change-hash scheme was designed around Firecrawl's `changeTracking`, which already existed. A four-API pipeline had no Convex components at all until the operator caught it.
- Earlier, sped-sync's hand-rolled `documentChunks` table is the "before" picture in [[patterns]] §2.

**The check:** before designing on a stack, read that stack's own skills and component catalog. That's local Claude memory for now, which is why it's repeated here.

---

## Graduated

- **A stacked PR merges into its base branch and lands nothing on `main`.** Portfolio, 2026-07; still-true, 2026-09-07, when four PRs read MERGED and one reached `main`. **Enforced** by a `PreToolUse` hook that blocks a non-default base.

## Candidates: one occurrence, waiting for a second

- **A readiness score should fall when someone looks harder.** still-true's score fell almost every time an audit looked harder, across eighteen passes (58 → 24). The number measures scrutiny, not safety. The file's "do not re-flag" and "listed, not scored" lists kept later sessions from rediscovering closed findings or "fixing" deliberate simplifications. Promote this if the next build keeps a readiness file and it does the same job.
