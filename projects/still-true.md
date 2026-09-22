# still-true — Convex All Gas Hackathon entry

**Pointer card, not a spoke.** It has a repo, but no drift-check enrollment, no Local-paths row, and no
`sync-registry.md` fields. It was registered this way on 2026-09-22 so that a finished build did not
set off the eight-file spoke fan-out ([[../wiki/decisions]] D-2026-08-26 admitted it as a
public-identity surface, not a teaching one).

**Canonical doc:** `still-true/hackathon.md` at `C:/Users/rplap/OneDrive/Desktop/personal/still-true`.
It was ruled the single source on 2026-09-02. This card never restates the product, the build
state, or the flag scores. When the two disagree, the repo wins.

## What it is, in one line

Forward it a document and it replies with what that document requires of you. Every claim quotes
its source line, and it states plainly where the document is silent.

## Where to look

| Need | Go to |
|------|-------|
| Product, build log, every decision including reversed ones | `hackathon.md` |
| Open flags and what the score measures | `docs/READINESS.md` |
| Claims the repo makes about itself, checked against production | `npm run gate` (read-only) |
| Calendar, gates, cut list | [[../archive/hackathon-26-day-schedule]] (closed) |
| Release gate outcome | [[../initiatives/public-identity]] §Release gate |
| Public surfaces | Repo `github.com/Lokie-ree/still-true` · live `impressive-marten-163.convex.site` · video `youtu.be/HofqXKI8KJs` · listing `vibeapps.dev/s/still-true` |

## Status

**Submitted 2026-09-20. The log closed 2026-09-22. Results are due 2026-09-25.** Production stays
up and the daily cron keeps running. That is deliberate: the watch is the product, and a judge may
still open it.

## Harvest (2026-09-22): the first project close under the three-slot model

| Slot | Went to | What |
|------|---------|------|
| Reusable pieces | [[../wiki/patterns]] | §3 gained a third instance (line-index grounding) and a sharpening: state which field the structure protects. **New §12** (claims as executable checks, one question per script) cleared the ≥2-repos bar with steel's own ops scripts as the second repo |
| Lessons | [[../wiki/lessons]] (new) | Five open lessons, each with two or more occurrences and a named check. One graduated (stacked PRs, now hook-enforced). One candidate held back (the readiness score), because it has only one occurrence |
| Story | [[../wiki/journey]] | A **draft** section, "After the room," marked unedited. The voice and the era call are the operator's |

**Deliberately not harvested:** the per-sponsor technical findings (M6, H10, AgentMail). They're repo facts, and they live in `READINESS.md` and in the filed issues. The shoot mechanics are event-specific. The one-PR-in-flight rule is already in the repo's `CLAUDE.md`, and it's the same lesson as the graduated stacked-PR one.

Post-submission items the repo names but has not done, for example the `og.jpg` → SVG fix, live in
`hackathon.md`, not here. Don't copy them into this card.
