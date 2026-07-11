# Decisions

Append-only architecture decision log for the ecosystem. Gap this file covers that no existing doc does: cross-repo rulings had no durable home — they lived in conversation memory and spoke-local docs, invisible at the hub. One entry per ruling; never edit past entries, append corrections as new entries.

| Date | Ruling | Why | Where it binds |
|------|--------|-----|----------------|
| 2026-07-06 | **course-lab is a new spoke repo** — not housed in creative-lab-demos (identity is ISTE demos, this is production) and not in creative-lab (its conventions are R3F-shaped). | The two rendering stacks stay separate at the repo boundary: R3F/GSAP in creative-lab, plain JSX/SVG in course-lab. Hard rule: `three` / `@react-three/*` / `gsap` never appear in course-lab's `package.json`. | [[../projects/course-lab]] · founding spec §2–3 (`course-lab/docs/course-lab-founding-spec.md`) |
| 2026-05-30 | **M2 and M3 intentionally share the same canonical triangle** — A(1,1) B(4,2) C(2,4). Not drift; the shared object lets M3 reuse a triangle the student has already met in M2, then reveal a new property (the Pythagorean relationship) on familiar geometry. | `HubContext`'s parser and test suite (`ops/tests/HubContext.Tests.ps1`) treat M2≡M3 as intentional and would otherwise flag it as a Tier 1 mismatch. | [[../sync-registry]] · [[../wiki/module-facts]] |
