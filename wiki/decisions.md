# Decisions

Append-only architecture decision log for the ecosystem. Gap this file covers that no existing doc does: cross-repo rulings had no durable home — they lived in conversation memory and spoke-local docs, invisible at the hub. One entry per ruling; never edit past entries, append corrections as new entries.

| Date | Ruling | Why | Where it binds |
|------|--------|-----|----------------|
| 2026-07-06 | **course-lab is a new spoke repo** — not housed in creative-lab-demos (identity is ISTE demos, this is production) and not in creative-lab (its conventions are R3F-shaped). | The two rendering stacks stay separate at the repo boundary: R3F/GSAP in creative-lab, plain JSX/SVG in course-lab. Hard rule: `three` / `@react-three/*` / `gsap` never appear in course-lab's `package.json`. | [[../projects/course-lab]] · founding spec §2–3 (`course-lab/docs/course-lab-founding-spec.md`) |
