# Steel — Vault Agent Rules

Instructions for AI agents when `steel` is in the workspace (Obsidian or Cursor multi-root).

> Lives at the root so it loads in every session, not only ones that touch `ops/`.
> Keep it here ([[wiki/decisions]] D-2026-07-31).

## Role

`steel` is the **hub**. Repos under `personal/` are **spokes**. Do not implement product code in `steel` unless explicitly asked to edit hub docs.

## Session protocol

1. Read `index.md` at vault root
2. Read `sprint/index.md` → the current sprint doc for priorities
3. If the task touches cross-repo facts, read `sync-registry.md` and `wiki/module-facts.md`
4. Switch context to the correct spoke repo before editing TS/TSX/CSS

## Research boundary

The ISTE research docs are **archived** (`archive/iste-narrative.md`,
`archive/iste-alignment-findings.md`) as of 2026-07-26. They are historical: useful if a
future conference or PD conversation needs the TLP mapping, not canonical for anything.

Do not copy research prose into repo READMEs or user-facing copy without explicit user approval.

## Dual-pane workflow

- **Obsidian:** planning, sprint updates, sync-registry maintenance, session notes
- **Cursor:** implementation in the active spoke repo (`CLAUDE.md` in that repo is the implementation contract)

When both are open, hub docs win for *what to work on*; spoke `CLAUDE.md` wins for *how to implement*.

## Navigation (index highway)

Before reading many files, check folder `index.md` files:

- `projects/index.md` — spoke cards
- `wiki/` — distilled facts (not full architecture copies)

Do not recursively list the vault. Snake through indices.

## Drift policy

- **Do not** propose monorepos, shared npm packages, or token unification unless the user asks
- **Do** flag when an edit changes a field in `sync-registry.md`
- **Do** list which other spokes need the same change

## Skills

`session-start` and `drift-check` live in `.claude/skills/`. Their names and
descriptions are already in every session's skill listing — not repeated here, so
there is one place to change them.

`wiki/module-facts.md` is canonical; `drift-check` validates that creative-lab, iste-26,
and portfolio still agree with it and each other. Pure logic lives in
`ops/lib/HubContext.psm1` (Pester-tested in `ops/tests/`).

**A drift PASS says nothing about course-lab.** Those three repos are dormant by ruling
([[wiki/decisions]] D-2026-07-22a); the check is a regression tripwire on frozen code, not
a status signal. Do not lead a session briefing with it.

**Removed 2026-07-26:** the `.hub` bundle pipeline (`build-context.ps1`, the
`build-context` skill, drift-check Stage 1). It was designed for a fan-out — three repos
presenting the same three modules to a conference — that no longer exists, and it never
ran in a single spoke. See `ops/index.md`.

## Git

- Never commit in `steel` unless the user asks
- Spoke repos: follow each repo's `CLAUDE.md` git workflow (feature branches, no direct commits to main/master)
- **Founding a new repo** (ratified 2026-07-09, from the course-lab init):
  - Default branch is `main` (steel stays `master`; do not retrofit existing repos)
  - The bootstrap root commit — README, `.gitignore`, `.gitattributes`, docs only — may land on `main`. This is the one named exception to feature-branch-only; everything after it lands via ordered single-concern PRs
  - Root commit includes `.gitattributes` with `* text=auto` (kills LF/CRLF warning noise and phantom diffs on Windows)
  - Solo PRs are self-merged, with a merge commit titled `Merge: …`
  - New repos start **private**; public is a deliberate later choice

### Git state is derived, never transcribed

Never write git state (branch, ahead/behind, dirty, "needs pull") into
the sprint doc, session logs, or project cards as prose. State those
facts only as output of `ops/repo-state.ps1`, run at read time. If a doc
contains hand-typed git state, treat it as unverified and re-derive.

## This repo is public

`steel` is a public GitHub repo. Everything committed here is published under the
operator's real name and tied to a named employer. That is deliberate — see `README.md` —
and it sets one hard line:

**No student information, ever, in any form.** No names, no initials, no roster codes, no
per-student records, no anecdote specific enough to re-identify a kid in a small district.
Describe needs generically. This extends the IPSB Tech Station's own strictest editorial
rule to the vault, and it is the one line not to soften.

Employer-referencing project detail (district name, role, service work, delivered
artifacts) is in scope and already published. Anything that reads as an evaluation of a
named colleague is not — write it somewhere else or not at all.

## Documentation

Extend, don't create. Before generating any new doc or guide, audit
ARCHITECTURE.md, the iste-26 guides, and the vault wiki for overlap. If
existing coverage is even partial, extend the existing file or recommend
deferral. A new file must state, in one sentence, the gap no existing
doc covers.

### Tooling paths are referenced, never pasted

When a plan or spec needs a local tool path (browser executables, global
installs, SDK locations), **reference the convention that holds it — do
not paste the literal path into the plan.** Same failure mode as
transcribed git state above: the value is live, the document is not, and
the reader trusts the document. Observed 2026-07-24 —
`PLAN-course-lab-transformations-ptr` carried a stale Playwright
executable path while `~/.claude/CLAUDE.md` had the correct one; the
executing agent followed the plan and hit a missing-binary error.

Executed plan docs stay untouched as historical record; the rule applies
to plans authored from here on.

> **Audit note (2026-07-07):** the friction-rule audit (`docs/superpowers/specs/2026-07-07-friction-rules-design.md`) used transcripts that all predate course-lab — it hardened the old 4-spoke workflow; the course-lab migration still needs its own review.
