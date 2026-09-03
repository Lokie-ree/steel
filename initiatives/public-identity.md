# Initiative — Public Identity

**Vision:** One door, the operator's own: the ground-up `portfolio` (business-card URL) evolves as the public face of the post-ISTE identity — *the teacher who builds with and for students* — absorbing the best harvested concepts without ever becoming someone else's fork ([[../wiki/decisions]] D-2026-07-18b).

**Current state (2026-07-18):** `portfolio` parked on `docs/dilations-card-copy` (sprint P4: finish or fold). github-readme freshly rewritten as the builder narrative (absorbed as the canonical constellation map). portfolio-markdown-site and sanity-ai-portfolio closed, concepts harvested. The journey narrative now exists ([[../wiki/journey]]) as raw material for public retelling.

**Standing note (2026-08-03):** `creative-lab` and `creative-lab-demos` remain the most distinctive assets in the constellation and must not end up buried behind lower-signal work when the portfolio content pass runs. *No fall build* is a scope ruling about the calendar ([[../wiki/decisions]] D-2026-07-22a, re-closed 2026-08-03) — it is not a statement about their value as public evidence, and the two should not be conflated when deciding what the door leads with.

**Harvested inputs:** [[../wiki/patterns]] §1 (markdown-as-canonical — if the portfolio grows written content, author in markdown + sync, don't hand-edit pages), §10 (append-only analytics), plus two portfolio-markdown-site concepts worth re-implementing *in the operator's own architecture*: the AEO/LLM discovery surface (`/llms.txt`, `/raw` markdown mirrors) and project pages fed from frontmatter. The deferred System graph spec remains the parked showpiece idea.

**First sprint-sized slice (when a sprint picks this up):** close the parked branch (finish or fold `docs/dilations-card-copy` — it's the P4 sprint item), then a one-session content pass: the portfolio tells the Era III story (course-lab, studio-coach) instead of stopping at ISTE 26. Everything else (AEO surface, System graph) waits behind that.

---

## Release gate — All Gas Hackathon (added 2026-08-26)

Ruled in [[../wiki/decisions]] **D-2026-08-26**: the hackathon is this initiative's first instance, and the vault's first gate whose default is release.

**Gap this fills:** the vault has no gate whose default is release. This is that gate, and the hackathon is its first instance. Unlike an admission bar, **a missed date is the failure — "not ready" is not an acceptable output.**

| Date | Gate | Failure condition |
|---|---|---|
| **2026-09-01** | Dry submission filed. Repo public, `hackathon.md` at root, live `convex.site` URL, 90-second video, vibeapps form submitted. | Nothing submitted. Not "nothing good submitted." |
| **2026-09-08** | Scope frozen. Feature list written down and closed. | The list is still open, or it grew. |
| **2026-09-15** | Persona playtest run against the live URL, transcript committed ([[../wiki/patterns]] §7). | No transcript. |
| **2026-09-20** | Final submission filed, two days of slack held deliberately. | Anything unsubmitted on 09-21. |

**Row 1 missed — 2026-09-01.** Nothing was filed. The repo was public, `hackathon.md` was at
the root and current, and the live `convex.site` URL was seeded and serving; the video and the
form were not done. The deferral was deliberate and the reasoning was that the only available
footage — two invented gists and a hash comparison run by hand — would be discarded at the
first real rebuild.

**This table's own terms make the reasoning irrelevant.** The failure condition on row 1 is
"Nothing submitted. Not 'nothing good submitted,'" and the rule above it is that a missed date
is the failure, with "not ready" explicitly not an acceptable output. Recording this as a miss
rather than as a reasonable postponement is the only way the gate keeps meaning anything —
this gate exists because a well-reasoned deferral has already been tested once and lost.

What is and is not at risk: the hackathon allows multiple submissions, so the entry itself is
not spent, and rows 2–4 are unchanged. Row 4 (2026-09-20) is the row that decides the outcome.
The specific thing given up is the early proof that the submission pipeline works end to end,
which is what row 1 was for; that proof now happens for the first time under deadline.

**Row 1's URL confirmed 2026-08-31, and this row needed no change.** The deploy serves at
`https://impressive-marten-163.convex.site` — `convex.site`, as this table always recorded it. A
2026-08-30 correction in the working docs claimed `*.convex.app` and has been withdrawn there.

**Row 2 got harder on 2026-09-02, and the date does not move.** The note above says rows 2–4 are
unchanged. Row 2 is unchanged as a *date* and materially harder as a *task*: the product pivoted
to the forwarded document, and the working schedule now puts the first end-to-end proof — a
document in, a cited answer out — on **Mon Sep 7, 9 PM**, one day before the scope freeze. A
feature list closed the day after the core loop first works is closed on one day of evidence.

That is uncomfortable and it is still correct. Moving row 2 to buy evidence is the same move as
deferring row 1 for better footage, which this table has now recorded as a miss. **The gate is
the date; what goes on the list is the operator's problem.** If Sep 7 fails, the list gets
frozen smaller — which is the gate working, not the gate breaking.

**One rule for the whole window.** A worse app that is submitted beats a better app that is not, and this table exists because that sentence has already been tested once and lost.

**Social proof is a scored criterion, not self-promotion** — posts on X or LinkedIn tagging the four sponsors count toward the judging. The announcement already made is the first one; treat the rest as a deliverable rather than a mood.
