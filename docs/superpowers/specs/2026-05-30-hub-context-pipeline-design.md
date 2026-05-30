# Hub Context Pipeline — Design

**Date:** 2026-05-30
**Operator:** Randall LaPoint, Jr. (solo)
**Status:** Approved (brainstorming) → ready for implementation plan
**Hard deadline context:** ISTE LIVE 2026 · June 28, 2026 (≈29 days out). Built under the freeze policy in `index.md` / `sync-registry.md`.

---

## Problem

`steel` is meant to be the up-to-date brain across four spoke repos (creative-lab, iste-26, portfolio, creative-lab-demos), but today:

1. **Canonical facts live in two places.** `wiki/module-facts.md` is declared the source of truth, but `ops/drift-check.ps1` hardcodes the same strings — a second copy that can itself drift.
2. **The drift check can't actually detect drift.** It uses `Select-String -Quiet`, checking whether a literal exists *somewhere* in each file independently. If all spokes drifted to the same wrong value, all checks still pass. It verifies presence, not cross-spoke agreement.
3. **Tier 1 triangle coordinates are listed as synced but never checked.**
4. **The vault has no visibility into git state.** Sprint status (e.g. "iste-26 local behind origin") is hand-typed and stale. Validation can silently run against out-of-date local working copies while GitHub has newer commits.
5. **Deployed code can't consume the brain.** Repos re-declare module names / standards / URLs in their own source instead of importing one shared artifact.

## Goal (this slice — "rung 1")

A **one-directional, vault-authoritative knowledge pipeline** with a verifiable contract:

- The vault *generates* a canonical artifact and pushes it **into** each repo (`vault → repo`, never back).
- Repos consume it two ways: code **imports** the JSON; Claude Code **reads** the context prose.
- A rewritten drift check proves every repo conforms to the one canonical artifact.
- A git-state preflight makes staleness **visible and blocking** so the vault never silently validates stale local code.

This earns its keep two independent ways: (a) drift safety + truthful briefings before ISTE, and (b) it is the foundational primitive the longer-term "brain" vision is built on.

## Non-goals (explicitly out of scope — post-ISTE "rungs 2–4")

- URL liveness checks, auto-regeneration on commit, a combined pre-deploy gate skill (rung 2)
- Additional knowledge types: architecture maps, design tokens, richer guidance (rung 3)
- Compiling facts into shared npm packages / generated code repos depend on (rung 4)
- Any repo → vault writeback (two-way sync) — permanently excluded by design
- Committing **sprint/priority state** into repos — it changes daily; stays live-read at session-start only
- Monorepo, token unification, repo merges (forbidden by the freeze)

---

## Architecture

```
CANONICAL SOURCES (vault, hand-edited)
  wiki/module-facts.md      → Tier 1 facts (names, standards, coords, hashes, URLs, event string)
  wiki/ pedagogy + deps     → distilled shared vision
  projects/<repo>.md        → per-repo "canonical for" + dependency direction
        │
        ▼
  ops/build-context.ps1     ← generator (run when canonical facts change)
        │  reads sources → deterministic output
        ▼
PER-REPO BUNDLE (committed into each spoke, vault-owned)
  <spoke>/.hub/module-facts.json   ← identical across all 4 repos
  <spoke>/.hub/context.md          ← universal vision + THIS repo's guidance block
        │
        ├──▶ code imports module-facts.json   (deployed artifact uses real values)
        └──▶ Claude Code reads context.md     (agent works from shared vision)

  ops/repo-state.ps1         ← git preflight, gates the two scripts above/below
  ops/drift-check.ps1        ← two-stage validation against the canonical JSON
```

### Two-stage drift model

1. **Bundle freshness** — does each repo's `.hub/module-facts.json` `sourceHash` equal the vault's *current* canonical hash? (Detects "forgot to regenerate after editing facts.")
2. **Code conformance** — does each repo's actual source (`modules.ts`, `App.tsx`, lab guides) contain the canonical `displayName`, `standards`, `iste26Hash`, deploy URLs, **and triangle coords**? (Detects "code drifted from the facts.")

### Staleness handling (the git preflight)

`ops/repo-state.ps1` runs `git fetch` (read-only) per spoke and reports `branch · ahead · behind · dirty`. It **never auto-pulls** (pulling could clobber uncommitted work — that stays the operator's call).

- `build-context.ps1` runs it first; if a repo is behind/dirty it **stops and asks** before writing a fresh bundle onto a stale branch.
- `drift-check.ps1` runs it first; **if any repo is behind origin it refuses to issue a "passing" verdict** — validating stale local code is worse than not validating.
- `session-start` reports real ahead/behind instead of the hand-typed line.

---

## Artifacts

### `.hub/module-facts.json` (identical in all four repos)

Parsed deterministically from `wiki/module-facts.md`.

```json
{
  "_generated": { "from": "steel/wiki/module-facts.md", "on": "2026-05-30", "sourceHash": "<sha256>" },
  "event": { "string": "Orlando · June 28 – July 1, 2026", "name": "ISTE LIVE 2026" },
  "modules": [
    { "id": "M1", "displayName": "Rigid Motions", "standards": "8.G.A.1–3",
      "triangle": { "A": [-3,-2], "B": [1,-1], "C": [-2,1] },
      "creativeLabModule": "rigid-motions", "iste26Hash": "#rigid-motions" },
    { "id": "M2", "displayName": "Dilations & Similarity", "standards": "8.G.A.3–5",
      "triangle": { "A": [1,1], "B": [4,2], "C": [2,4] },
      "creativeLabModule": "dilations", "iste26Hash": "#dilations" },
    { "id": "M3", "displayName": "Pythagorean Theorem", "standards": "8.G.B.6–8",
      "triangle": { "A": [1,1], "B": [4,2], "C": [2,4] },
      "creativeLabModule": "pythagorean-theorem", "iste26Hash": "#pythagorean-theorem" }
  ],
  "demo": { "id": "CSE", "name": "Cross-Section Explorer", "url": "https://creative-lab-demos.vercel.app" },
  "deployUrls": {
    "creative-lab": "https://creative-lab-five.vercel.app",
    "iste-26": "https://iste-26.vercel.app",
    "portfolio": "https://randalllapointjr.dev",
    "creative-lab-demos": "https://creative-lab-demos.vercel.app"
  }
}
```

**Intentional invariant:** M2 and M3 share triangle `A(1,1) B(4,2) C(2,4)` by design ("same scalene triangle carries M2 → M3"). M1 differs. Drift-check must *expect* M2≡M3, not flag it.

**Canonical-source gap to close in implementation:** `event.string` (`"Orlando · June 28 – July 1, 2026"`) does **not** currently exist in `wiki/module-facts.md` — only the shorter `"ISTE LIVE 2026"` appears (hardcoded in the old drift-check). The implementation must add the full event string to `module-facts.md` and have the generator parse it from there. Do **not** hardcode it in `build-context.ps1` — that would recreate the exact second-copy anti-pattern this design exists to kill.

**Portfolio naming note:** Work cards may shorten titles ("Dilations" vs "Dilations & Similarity"). `displayName` is the full System-grid name; the short form is a portfolio-local choice and is NOT drift.

### `.hub/context.md` (universal vision + per-repo block)

```
<!-- GENERATED by steel/ops/build-context.ps1 — DO NOT HAND-EDIT -->
# Shared Context — <repo>

## This repo's role        ← from projects/<repo>.md
<canonical-for + dependency direction>

## Shared vision (all 4 repos)    ← from wiki pedagogy anchors + dependency rules
- Manipulation before explanation · Earned reveal of notation · Matching IS verification
- Same scalene triangle carries M2 → M3
- creative-lab wins on behavior · iste-26 on teacher notes · portfolio on narrative

## Using these facts
Import values from `.hub/module-facts.json`. Do not hardcode module names, standards, coords, or URLs.
To change them: edit steel/wiki/module-facts.md → regenerate. Never hand-edit .hub/.
```

---

## Components

### `ops/repo-state.ps1` (new)
- **Input:** the four spoke paths from the **"Local paths" table in `index.md`** (the authoritative path source; `projects/index.md` holds the spoke *cards*, not resolved paths).
- **Behavior:** `git -C <path> fetch --quiet`; compute ahead/behind vs upstream; `git status --porcelain` for dirty.
- **Output:** table `repo · branch · ahead · behind · dirty`; non-zero exit / flag if any repo is behind origin or dirty.
- **Never** pulls or modifies any working tree.

### `ops/build-context.ps1` (new — generator)
1. Preflight via `repo-state`; if behind/dirty, stop and ask before writing.
2. Parse `wiki/module-facts.md` → canonical object; compute `sourceHash` over canonical sources.
3. Read each `projects/<repo>.md` for the per-repo block — the `## Role` section plus the dependency direction from `projects/index.md` ("canonical for" column). The implementation must confirm these fields are present and parseable in every card before relying on them (the portfolio card has `## Role` + `## Sync obligations`; verify the other three match this shape). Read wiki pedagogy anchors + dependency rules for the universal vision block.
4. Write `.hub/module-facts.json` + `.hub/context.md` into each spoke. **Deterministic:** re-running with no source change produces zero diff.
5. Report per-repo `git diff --stat` so the operator sees changes before committing in each spoke.

### `ops/drift-check.ps1` (rewrite)
1. Preflight via `repo-state`; **refuse a passing verdict if any repo is behind origin.**
2. Load canonical JSON (vault truth, recomputed from `module-facts.md`).
3. **Stage 1 — bundle freshness:** each repo's `.hub/module-facts.json` `sourceHash` == vault current hash.
4. **Stage 2 — code conformance:** for each module, assert repo source contains canonical `displayName`, `standards`, `iste26Hash`, deploy URLs, and triangle coords; M2≡M3 expected.
5. Summary: git-state line, Stage 1 results, Stage 2 results, each separated; list every FAIL with file + expected value + which other spokes share it.

---

## One-time setup / rollout

1. Land the three scripts in `steel/ops/`.
2. Run `build-context.ps1`; review the generated `.hub/` diff in each spoke.
3. In each spoke repo: commit `.hub/` and add one pointer line to its `CLAUDE.md` — "Canonical shared facts live in `.hub/` (generated by steel; do not hand-edit)." This is a one-time manual edit; the generator never touches `CLAUDE.md`.
4. Optionally refactor each repo's hardcoded values to import from `.hub/module-facts.json` (incremental, per repo, not required for drift-check to work — Stage 2 still validates source strings).

## Skill changes

- **drift-check** skill: update steps to describe the two-stage model and the git preflight gate.
- **session-start** skill: add the `repo-state` line to the briefing; keep sprint state live-read (not committed).
- **New `build-context`** skill (thin): "regenerate the hub bundle" → runs `build-context.ps1`, summarizes diffs, reminds to commit `.hub/` in each spoke.

## Error handling

- Spoke path missing → `repo-state`/scripts report SKIP with the path, continue, never crash.
- `git fetch` fails (offline) → warn "could not verify against origin — reading local only"; drift-check downgrades its verdict to "unverified," not "pass."
- `module-facts.md` unparseable → generator aborts before writing any `.hub/` (fail closed; no partial bundles).
- `.hub/` missing in a repo → Stage 1 reports "bundle not installed," Stage 2 still runs against source.

## Verification

- Generator is idempotent: run twice, second run yields zero git diff in every spoke.
- Mutate a value in `module-facts.md`, regenerate → Stage 1 flags the repo not yet re-pulled / committed.
- Hand-edit a module name in a repo's source → Stage 2 flags exactly that repo with the canonical expected value.
- Put a spoke behind origin → drift-check refuses a passing verdict and names the repo.

## Out of scope (restated)

Rungs 2–4 (automation, more knowledge types, shared packages), repo→vault writeback, committing sprint state, and anything forbidden by the freeze.
