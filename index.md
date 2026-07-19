# Steel — Agentic OS Hub

**Purpose:** Workflow-governance hub for six registered repos — git conventions, session briefs, drift/state visibility (ruling 2026-07-17, [[wiki/decisions]]). Read this file first in any agent session where `steel` is in the workspace.

**Operator:** Randall LaPoint, Jr. — solo developer.

**North star:** the 2026–27 classroom — course-lab in production for the six-course room, EdgeEx-aligned builds (Algebra II/III) as the agile layer on top. ISTE LIVE 2026 concluded; the arc is archived ([[archive/2026-iste-40d]], [[wiki/journey]]).

---

## Session start (dual-pane)

You work in **both** Obsidian (`steel`) and Cursor (one spoke repo). At session start:

1. Read [[sprint/index]] → the current sprint doc — what gets attention today
2. Skim [[sync-registry]] — if your edit touches a synced field, update all spokes listed
3. Open the spoke's [[projects/index|project card]] for paths, branch, and agent entry point
4. Implement in the **spoke repo** (`personal/<repo>/`), not in `steel`

Research docs (`iste-narrative.md`, `iste-alignment-findings.md`) are **research-only** — do not treat them as canonical for repo changes or agent instructions.

---

## Vault map

| Path | Role |
|------|------|
| [[projects/index]] | Spoke registry — one card per repo |
| [[sync-registry]] | Cross-repo fields that must stay aligned |
| [[sprint/index]] | Sprint docs — current window and session log |
| [[wiki/index]] | Distilled facts (module names, coords, URLs, ecosystem map) |
| [[archaeology/index]] | One dossier per repo — the 2026-07-18 portfolio dig (evidence layer) |
| [[initiatives/index]] | Forward initiative docs — future sprints get cut from these |
| [[ops/index]] | Agent rules, scripts, vault config |
| [[agentic-os/index]] | Three-layer framework reference (background only) |
| `iste-narrative.md` | ISTE narrative research (not canonical) |
| `iste-alignment-findings.md` | Framework alignment research (not canonical) |

---

## Local paths

| Spoke | Path |
|-------|------|
| creative-lab | `C:/Users/rplap/OneDrive/Desktop/personal/creative-lab` |
| iste-26 | `C:/Users/rplap/OneDrive/Desktop/personal/iste-26` |
| portfolio | `C:/Users/rplap/OneDrive/Desktop/personal/portfolio` |
| creative-lab-demos | `C:/Users/rplap/OneDrive/Desktop/personal/creative-lab-demos` |
| course-lab | `C:/Users/rplap/OneDrive/Desktop/personal/course-lab` |
| project-studio-coach | `C:/Users/rplap/OneDrive/Desktop/personal/project-studio-coach` |

---

## Drift policy

**Document sync points; derive state.** When user-facing strings drift (names, standards, URLs, triangle coords), fix all spokes listed in [[sync-registry]] in the same session. Monorepo / shared-package extraction stays out of scope (sprint ruling; revisit only if a sprint puts it in scope). Harvested cross-repo patterns live in [[wiki/patterns]]; forward direction lives in [[initiatives/index]].
