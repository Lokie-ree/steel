# Module Facts

Single table for Tier 1 sync checks. When in doubt, creative-lab implementation is canonical.

## Event

| Field | Value |
|-------|-------|
| Name | ISTE LIVE 2026 |
| Full string | Orlando · June 28 – July 1, 2026 |

## Grade 8 Geometry arc (M1 → M2 → M3)

| ID | Display name | Standards | Triangle | creative-lab | iste-26 hash |
|----|--------------|-----------|----------|--------------|--------------|
| M1 | Rigid Motions | 8.G.A.1–3 | A(−3,−2) B(1,−1) C(−2,1) | module `rigid-motions` | `#rigid-motions` |
| M2 | Dilations & Similarity | 8.G.A.3–5 | A(1,1) B(4,2) C(2,4) | module `dilations` | `#dilations` |
| M3 | Pythagorean Theorem | 8.G.B.6–8 | A(1,1) B(4,2) C(2,4) | module `pythagorean-theorem` | `#pythagorean-theorem` |

**Portfolio naming note:** Work cards may shorten titles (e.g. "Dilations" vs "Dilations & Similarity"). System grid uses full names above.

## Standalone demo

| ID | Name | Standards (adjacent) | Repo | URL |
|----|------|----------------------|------|-----|
| CSE | Cross-Section Explorer | 8.G.C.9 adjacent | creative-lab-demos | [creative-lab-demos.vercel.app](https://creative-lab-demos.vercel.app) |

## Deploy URLs

| Spoke | Production URL |
|-------|----------------|
| creative-lab | https://creative-lab-five.vercel.app |
| iste-26 | https://iste-26.vercel.app |
| portfolio | https://randalllapointjr.dev |
| creative-lab-demos | https://creative-lab-demos.vercel.app |

## Architecture doc locations (in repos, not copied here)

| Piece | Path (relative to creative-lab or demos) |
|-------|------------------------------------------|
| M1 | `src/components/modules/rigid-motions/ARCHITECTURE.md` |
| M2 | `src/components/modules/dilations/ARCHITECTURE.md` |
| M3 | `src/components/modules/pythagorean-theorem/ARCHITECTURE.md` |
| CSE | `demos/cross-section-explorer/ARCHITECTURE.md` |

## Pedagogy anchors (consistent tone, not verbatim sync)

- Manipulation before explanation
- Earned reveal of formal notation
- Matching IS verification (no multiple choice)
- Same scalene triangle carries M2 → M3 (familiar object, new properties)
