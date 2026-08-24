# Plans & Specs — the build record

> **Gap this file covers:** these twenty documents are the record of what got built and why,
> and until 2026-08-23 **not one of them had a single inbound link.** They were cited as bare
> paths in backticks, which Obsidian's graph and backlinks pane cannot see. Every other folder
> in the vault has an index; this one did not, so *"have we designed this before?"* had no
> entry point.

**These are historical and frozen.** An executed plan stays untouched as the record of what
was actually run ([[../../CLAUDE]] §Documentation). Read them for precedent, never as current
instructions — several carry tooling paths and verified starting states that were true on the
day they ran and are not true now.

A **spec** is the design decision; a **plan** is the sequenced implementation. Where both
exist for one piece of work the spec came first, and the ruling it produced is in
[[../../wiki/decisions]].

## Specs — design decisions

| Spec | Repo | Ruling it produced |
|---|---|---|
| [[specs/2026-07-19-transformations-ptr-design]] | course-lab | **D-2026-07-19** — the module's home |
| [[specs/2026-07-18-portfolio-consolidation-design]] | steel | **D-2026-07-18a/b/c** — the 17-repo dig ([[../../archaeology/index]]) |
| [[specs/2026-07-17-studio-coach-onboarding-design]] | steel | **D-2026-07-17** — sixth spoke admitted |
| [[specs/2026-07-07-friction-rules-design]] | steel | — · **caveat:** its transcripts all predate course-lab, so it hardened the old 4-spoke workflow ([[../../CLAUDE]] audit note) |
| [[specs/2026-05-30-hub-context-pipeline-design]] | steel | — · **what it designed was deleted**, D-2026-07-26 |

## Plans — sequenced implementation

Grouped by the repo each ran against. The names are descriptive; the Note column carries only
what a name does not say.

| Plan | Repo | Note |
|---|---|---|
| [[plans/PLAN-course-lab-transformations-ptr]] | course-lab | First EdgeEx module. Shipped 2026-07-24, course-lab PR #16 |
| [[plans/PLAN-course-lab-sink-hardening]] | course-lab | The hardened storage sink in [[../../wiki/patterns]] §6 |
| [[plans/PLAN-course-lab-deploy]] | course-lab | |
| [[plans/PLAN-course-lab-registry-guard]] | course-lab | |
| [[plans/PLAN-course-lab-family-coverage]] | course-lab | |
| [[plans/PLAN-course-lab-roster-swap]] | course-lab | |
| [[plans/PLAN-course-lab-smoke-verify]] | course-lab | |
| [[plans/PLAN-creative-lab-closeout]] | creative-lab | |
| [[plans/PLAN-rigid-motions-rm04-ped01]] | creative-lab | Runs after the closeout plan's PR 1 |
| [[plans/PLAN-cse-classifier-regression]] | creative-lab-demos | |
| [[plans/PLAN-portfolio-m3-standards-landing]] | portfolio | |
| [[plans/PLAN-studio-coach-onboarding]] | steel + project-studio-coach | Both sides of the admission, one plan |
| [[plans/PLAN-friction-rules-implementation]] | steel | Sequences the 2026-07-07 spec; adds nothing to it |
| [[plans/PLAN-steel-hub-hygiene]] | steel | Runs after the friction-rules plan |
| [[plans/2026-05-30-hub-context-pipeline]] | steel | Built the `.hub` pipeline. **Deleted 2026-07-26** (D-2026-07-26) — it never ran in a single spoke |

## Citing these

A path under `docs/superpowers/` is **steel-relative**. A plan that also lives in the spoke it
ran against is cited with the spoke prefix — `course-lab/docs/superpowers/plans/…` — as
D-2026-07-22b does. Both copies of `PLAN-course-lab-transformations-ptr` exist; the prefix is
the only thing that says which one is meant.

Prefer a wikilink over a backticked path for anything in this folder, so the build record stays
visible in the graph.
