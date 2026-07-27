# Sync Registry

Fields that **must stay aligned** across spokes. If you change one, update every spoke in the same session.

**Policy:** fix user-facing drift only. Do not unify code or design systems (monorepo/shared packages remain out of sprint scope).

---

## Scope note (2026-07-26) — read this before using the table below

This registry governs **one thing**: the three-module grade-8 geometry arc as it is
presented across `creative-lab`, `iste-26`, and `portfolio`. That fan-out existed
because three repos showed the same three modules to a conference audience. **The
conference concluded and all three repos are dormant by ruling** ([[wiki/decisions]]
2026-07-22).

What remains below is a **regression tripwire on frozen repos** — cheap to keep,
already written, and it fires if someone edits one of the three and forgets the other
two. It is not a signal about current work.

**course-lab is deliberately not in this registry.** It is the one live product, and
it has no cross-repo surface: one repo, one URL, one consumer. Cross-repo drift is a
fan-out problem, and the fan-out collapsed to one. Adding a course-lab Tier 1 would be
re-arming for a war that ended.

**What this registry structurally cannot see:** vault-internal metadata — spoke-card
fields, live URLs in `projects/`, status labels. That is what actually drifted in July
(PR #14), and no Tier 1 field covered it. If a mechanical check is ever worth building,
build that one, not another cross-repo scanner.

**Removed 2026-07-26:** the ISTE event-string row (the event has concluded) and the
`.hub` bundle-freshness stage (the pipeline never ran in a single spoke; deleted along
with `build-context.ps1`).

---

## Tier 1 — the dormant geometry arc

Checked mechanically by `ops/drift-check.ps1`. Canonical values: [[wiki/module-facts]].

### Module catalog

| Field | Spokes to update |
|-------|------------------|
| Module display names | creative-lab `modules.ts`, iste-26 lab guide titles, portfolio `SYSTEM_ROWS` + Work cards |
| Standards strings | same three + iste-26 teacher Standards pages |
| Live URLs | iste-26 guide footers, portfolio hrefs, any hardcoded vercel links |

### Triangle coordinates

| Module | Triangle | Spokes |
|--------|----------|--------|
| M1 Rigid Motions | A(−3,−2) B(1,−1) C(−2,1) | creative-lab, iste-26 RigidMotions guide |
| M2 Dilations | A(1,1) B(4,2) C(2,4) | creative-lab, iste-26 Dilations guide |
| M3 Pythagorean | A(1,1) B(4,2) C(2,4) | creative-lab, iste-26 PythagoreanTheorem guide |

### Deploy URLs

| Surface | URL |
|---------|-----|
| Interactive modules | `https://creative-lab-five.vercel.app` |
| Lab guides | `https://iste-26.vercel.app` + hash routes |
| Portfolio | `https://randalllapointjr.dev` |
| CSE demo | `https://creative-lab-demos.vercel.app` |

---

## Tier 2 — Narrative (manual review, not auto-sync)

Pedagogy one-liners. Repo copy should feel consistent but does not need word-for-word
match. Keep philosophically aligned:

- "Challenge before explanation"
- "Understanding precedes notation"
- creative-lab URL paired with "design philosophy" attribution in iste-26 guides

Conference-conversation framing is archived (`archive/iste-narrative.md`) and is no
longer a source of truth for anything.

---

## Tier 3 — Intentionally NOT synced

Do not treat these as drift.

| Concern | creative-lab / iste-26 | portfolio / demos |
|---------|------------------------|-------------------|
| Color tokens | Eurorack `--lab-*`, phosphor green | Amber `oklch`, Fraunces + DM Sans |
| R3F preview code | Full modules | Portfolio mini previews (reimplemented) |
| Fonts | Inter Tight + JetBrains Mono | Fraunces + DM Sans |
| philosophy.md | creative-lab `docs/` | iste-26 `docs/` (duplicate files, OK) |

course-lab shares nothing with any of them and is not a Tier 3 exception — it is
simply outside this registry's scope.

---

## Running the check

`pwsh ops/drift-check.ps1` — git preflight, then conformance. A PASS means the three
dormant repos still agree with each other. It says nothing about course-lab.
