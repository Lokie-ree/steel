# Sync Registry

Fields that **must stay aligned** across spokes. If you change one, update every spoke in the same session.

**Policy through June 28:** fix user-facing drift only. Do not unify code or design systems.

---

## Tier 1 — User-facing (fix immediately)

### Module catalog

| Field | Spokes to update |
|-------|------------------|
| Module display names | creative-lab `modules.ts`, iste-26 lab guide titles, portfolio `SYSTEM_ROWS` + Work cards |
| Standards strings | same three + iste-26 teacher Standards pages |
| Live URLs | iste-26 guide footers, portfolio hrefs, any hardcoded vercel links |

**Canonical values:** [[wiki/module-facts]]

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

### ISTE event string

`Orlando · June 28 – July 1, 2026` — portfolio ISTE section, iste-26 guide footers (`ISTE LIVE 2026`)

---

## Tier 2 — Narrative (manual review, not auto-sync)

Pedagogy one-liners and handshake sentences. Source of truth for **conversation prep** is `iste-narrative.md` (research-only). Repo copy should feel consistent but does not need word-for-word match.

Examples to keep philosophically aligned:

- "Challenge before explanation"
- "Understanding precedes notation"
- creative-lab URL paired with "design philosophy" attribution in iste-26 guides

---

## Tier 3 — Intentionally NOT synced

Do not treat these as drift. Do not merge before ISTE.

| Concern | creative-lab / iste-26 | portfolio / demos |
|---------|------------------------|-------------------|
| Color tokens | Eurorack `--lab-*`, phosphor green | Amber `oklch`, Fraunces + DM Sans |
| R3F preview code | Full modules | Portfolio mini previews (reimplemented) |
| Fonts | Inter Tight + JetBrains Mono | Fraunces + DM Sans |
| philosophy.md | creative-lab `docs/` | iste-26 `docs/` (duplicate files, OK for now) |

---

## Drift check (run before ISTE deploy)

- [ ] Module names match in portfolio `SYSTEM_ROWS`, iste-26 covers, creative-lab hub
- [ ] Standards strings identical across three curriculum spokes
- [ ] All four deploy URLs load and match hrefs in portfolio
- [ ] Hash routes on iste-26 resolve to correct guide
- [ ] Lab guide footers still point to creative-lab-five.vercel.app

---

## Post-ISTE candidates (do not start now)

- Shared `@creative-lab/module-facts` package or JSON
- Token unification (unlikely — two visual languages are intentional)
- Single philosophy.md source with sync script
