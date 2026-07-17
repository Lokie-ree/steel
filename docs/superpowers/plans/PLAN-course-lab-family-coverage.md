# PLAN-course-lab-family-coverage

**Repo:** `course-lab` (`C:/Users/rplap/OneDrive/Desktop/personal/course-lab`)
**Verified starting state (2026-07-11):** 12 module files / 29 pedagogical units on `main`; module headers carry standards codes (e.g. `F-LE.A.2`, `A-REI.D.11`, `LEAP.II.GM.1`). No document maps courses to modules anywhere in course-lab or the steel vault (searched 2026-07-11).
**Contract:** founding spec §7 names this exact item: "Six-course **family-coverage mapping** (which interaction families cover which of the six courses) — design session, zero code, before August."
**Branch:** `docs/family-coverage`. Zero code changes — this plan produces one document.

## Goal

Produce `docs/family-coverage.md`: a grid of the six 2026–27 courses × the 29 pedagogical units, so coverage gaps surface **now**, while there is still lead time to build modules before August. The executor builds the evidence and the scaffold; Randall fills the judgment cells. The deliverable is a decision surface, not decisions.

**New-doc gap statement (friction rule R4, required):** no existing document maps course coverage — the two docs in `docs/` (`algebra-summer-remediation-design.md`, `geometry-summer-remediation-design.md`) are per-suite design docs, and the founding spec is a contract, not an inventory.

## Required operator input

The six course names. Only the endpoints are recorded anywhere ("Math Essentials → BRCC dual-enrollment college algebra"). Ask Randall for the list **before starting**; if unavailable, scaffold with `Math Essentials`, `COURSE-2 ☐`, `COURSE-3 ☐`, `COURSE-4 ☐`, `COURSE-5 ☐`, `BRCC College Algebra` and flag the placeholders at the top of the doc — the PR still lands as a scaffold.

## Steps

- [ ] **1. Branch:** `git checkout -b docs/family-coverage`

- [ ] **2. Build the unit inventory.** For each of the 12 files in `src/modules/`, record: filename, `moduleId` (from `MODULES` in `src/App.jsx:9-22`), interaction family (PTR / Bind-and-Justify / Assume-Fit-Reflect / remediation-suite), and standards codes. Extraction commands (run from the repo root, Git Bash):

```bash
# Standards codes cited in module headers (CCSS + LEAP patterns):
grep -oE "\b[A-Z]+-[A-Z]{2,3}\.[A-Z]\.[0-9]+[a-z]?\b|\bLEAP\.[IVX]+\.[A-Z]+\.[0-9]+\b" src/modules/*.jsx | sort -u

# The suites' internal modules (the 11 + 8 units inside the two Remediation files):
grep -nE "forModule\(" src/modules/AlgebraRemediation.jsx src/modules/GeometryRemediation.jsx
```

Read each suite file around those hits to list every internal `moduleId` (`algebra-remediation/<internal>` × 11, `geometry-remediation/<internal>` × 8). The inventory must total **29 rows** (10 standalone units + 11 + 8). Standalone `PredictTestReconcile.jsx` and the 6 other PTR files are one unit each; check `AssumeFitReflect.jsx` and `BindTheParts.jsx` headers for whether they carry multiple rounds — rounds are not units; count files/internals, not rounds.

- [ ] **3. Write `docs/family-coverage.md`** with exactly these sections:

```markdown
# Family coverage — 2026–27 six-course room

**Status:** scaffold, awaiting Randall's judgment cells · **Date:** YYYY-MM-DD
**Source:** src/modules/ inventory at commit <short-sha> · founding spec §7 item 1

## 1. Unit inventory (29 units)
| moduleId | File | Family | Standards cited |
（29 rows, mechanical — from step 2）

## 2. Coverage grid
| moduleId | Math Essentials | <course 2> | <course 3> | <course 4> | <course 5> | BRCC College Algebra |
Cells: ✔ (fits as-is) · ~ (fits with adaptation) · blank (no fit) · ☐ (Randall to judge)
Pre-fill only what the standards make obvious (e.g. geometry-remediation/* → the geometry-bearing course; A-SSE/F-IF/F-LE units → algebra-bearing courses). Everything else is ☐.

## 3. Gaps and build/adapt/skip decisions
One row per course whose column has no ✔: | Course | Gap description | Build new / adapt existing / skip (☐ Randall) | Lead time note |

## 4. Method note
How the inventory was extracted (commands), what ✔/~/☐ mean, and that this doc is
append-updated as decisions land — do not fork a v2.
```

- [ ] **4. Sanity-check the grid arithmetic:** 29 inventory rows = 29 grid rows; every grid cell is exactly one of the four marks; every course column is represented in §3 unless it has at least one ✔.

- [ ] **5. Commit** (`docs: family-coverage scaffold — 29-unit inventory + six-course grid`), push, PR, self-merge. Then tell Randall which `☐` cells and §3 decision rows await him, and update the steel hub card `projects/course-lab.md` Status block with one line ("family-coverage scaffold landed YYYY-MM-DD, judgment cells open") — leave the hub edit uncommitted.

## Edge cases a weaker model would miss

- **Units ≠ files ≠ rounds.** 12 files, 29 units: the two suite files contain 11 and 8 internal modules respectively — each internal module is its own row. Multiple `roundId`s inside one module (e.g. `AssumeFitReflect`'s `study-hours` / `battery-drain` / micro-model) are still **one** unit.
- **Do not invent course-to-standard mappings.** Pre-fill a ✔ only where the cited standard is unambiguous for a course that exists in the input list; when in doubt, ☐. A wrong confident cell is worse than an empty one — Randall trusts the grid or the whole doc is dead weight.
- **This is a zero-code plan.** If you find yourself editing anything under `src/`, stop — you have left the plan.
- The doc lives in **course-lab** `docs/`, not the steel vault: it is production planning for this repo's library, and the R4 gap statement above is its creation license. The hub card gets a one-line pointer, not a copy (extend-don't-create).
- creative-lab modules (M1–M3, rigid motions, dilations) are **out of this grid** — different repo, ISTE arc. If a gap's best fix is "adapt a creative-lab module", write that in §3 as a decision option; do not add creative-lab rows to the inventory.

## Acceptance criteria

- `docs/family-coverage.md` merged with all four sections; inventory has exactly 29 rows; every standards code in §1 actually appears in the named file (spot-check 5).
- Six course columns present (real names, or flagged placeholders + a top-of-doc REQUIRED INPUT banner).
- §3 lists every course lacking a ✔, each with a build/adapt/skip decision row.
- Zero diffs under `src/`.

## Explicitly out of scope

- Building or adapting any module (that work is scoped by the decisions this doc enables).
- Curriculum sequencing/pacing within a course.
- creative-lab inventory.
