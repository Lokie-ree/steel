# Projects — Spoke Registry

Six repos. One ecosystem. Each spoke card is the agent entry point when that repo is the active spoke. Three **non-spoke** cards sit below the table — work with no repo behind it.

| Repo | Card | Live | Canonical for |
|------|------|------|---------------|
| creative-lab | [[creative-lab]] | [creative-lab-five.vercel.app](https://creative-lab-five.vercel.app) | Interactive modules M1–M3, pedagogy docs, module architecture |
| iste-26 | [[iste-26]] | [iste-26.vercel.app](https://iste-26.vercel.app) | Lab guides (teacher + student), ISTE presentation surface |
| portfolio | [[portfolio]] | [randalllapointjr.dev](https://randalllapointjr.dev) | Professional door, R3F preview cards, System grid |
| creative-lab-demos | [[creative-lab-demos]] | [creative-lab-demos.vercel.app](https://creative-lab-demos.vercel.app) | Standalone interactives (CSE only) |
| course-lab | [[course-lab]] | [course-lab-two.vercel.app](https://course-lab-two.vercel.app) | Production module library for the 2026–27 room — **Algebra II / Algebra III on EdgeEx** ([[../wiki/decisions]] D-2026-07-22b; the six-course framing is historical). PTR / Bind-and-Justify / Assume-Fit-Reflect suites, measurement spine |
| project-studio-coach | [[project-studio-coach]] | — (not deployed) | AI scoping coach (Convex + React), club prototype, archetype library |

**Not in the curriculum grid:** creative-lab-demos — featured on portfolio as Live Demo, not in M1–M3 System rows. course-lab — production for the 2026–27 room (two preps, not six), not an ISTE surface; no Tier 1 sync fields. project-studio-coach — club platform outside the ISTE arc entirely; workflow-governance spoke, no Tier 1 sync fields.

**Dependency direction:** creative-lab → iste-26 / portfolio (derivative surfaces). demos → portfolio (embed only).

---

## Not spokes

Course-authoring, classroom-build, and facilitator-role work with **no repo to switch
into.** Cards exist so hub sessions know the work exists. For the first two the canonical
document lives outside the vault and the card is a pointer, never a log. **loop-bench is
the exception** — its files carry no docs of their own, so its card *is* the canonical
record of the rulings. None of the three introduces `sync-registry.md` fields or anything
for `drift-check`.

| Card | What | Canonical doc |
|------|------|---------------|
| [[algebra2-course-plan]] | Algebra II Sem A, Fall 2026 — Edmentum, two sections, 4–20 mA anchor | `Fall 2026 Course Plan.md`, in the Claude project |
| [[civics-planning-tool]] | Lesson-planning tool built with one pilot teacher | The context stack, outside the vault |
| [[loop-bench]] | 4–20 mA current-loop bench — the Algebra II applied layer, one face of six | **This card.** Files staged in `~/Downloads`, no repo yet |
