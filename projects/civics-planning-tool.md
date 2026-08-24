# civics-planning-tool — Iberville lesson planning (Civics pilot)

**Not a spoke.** No repo. Technology-facilitator work: a lesson-planning tool being built
with one pilot teacher, tracked here so hub sessions know it exists. The context stack
itself lives outside the vault; this card is the pointer and the constraint list.

**Opened 2026-08-13.**

## Role

The tool assembles a district-template weekly lesson plan from a small intake block,
coded against Louisiana Civics standards. First pilot: **the pilot Civics teacher**
(unnamed here, deliberately — see Editorial constraints).

## Context stack

Five layers — **Process, Standards, Curriculum, Reconciliation, Calibration.** Four are
built. The Calibration layer now holds the **LDOE HS Civics Scoring Notes.**

## The Scoring Notes are a Column 2 source

They **supersede reverse-engineering success criteria from textbook quiz items.**
Structure: 5 units, 13 topics; each topic carries a framing question, a
constructed-response prompt, and LDOE's own exemplar content.

This is the closest thing yet to an answer on what **"must-do" means in Column 5.**

## Tool requirements

Findings from one validation week, recorded as **requirements on the tool** — never as an
assessment of anyone's plans. This framing is the rule, not a softening of one.

1. **Crosswalk seam.** The district template header names an LDOE unit title while the
   week's content follows the textbook's chapter numbering. **The district is already
   planning in both maps simultaneously.** This is evidence for flipping the project's
   source anchor from textbook-centered to standards-centered — see Needs ratification.
2. **Substandard precision — the tool codes per day.** The validation week carried one
   substandard code across all five days; the content actually spans **C.8a** (purpose of
   government), **C.8b** (systems and structures, including direct vs. representative),
   and **C.11.a** (duties and responsibilities of citizens).
3. **Typology mismatch is a standing flag, not a one-off.** C.8b names its own typology —
   constitutional republic/autocracy, direct/representative, presidential/parliamentary,
   unicameral/bicameral, unitary/federal/confederate. The textbook teaches a different
   set. **Column 1 uses the standard's typology;** the textbook's set may appear as
   vocabulary.
4. **Rigor floor, confirmed against a real artifact.** Objectives written at "define" and
   "identify" against standards that say "compare and contrast" and "analyze". **The tool
   flags under-rigor rather than smoothing it.**

## Editorial constraints

Hard rules for anything written about this project in this repo, which is public:

- **The pilot teacher is unnamed.** Write "the pilot Civics teacher."
- **Do not record source filenames** — they contain her name.
- **Validation findings are tool requirements, never assessments.** "The tool must code
  per day," not "the plan miscoded four days."
- **No publisher content.** LDOE's public review findings are in scope; the textbook's
  lesson text, page numbers, and objectives are not. The district's position on uploading
  licensed publisher materials to an external tool is **still open** (see Open).
- **No student information, ever, in any form** — [[../CLAUDE]], the one line not to
  soften.

## Needs ratification — not decided

- **Flipping the source anchor** from textbook-centered to standards-centered
- **Adding a source field** to the weekly intake block

## Open

- Verify the per-lesson Lesson Plan resource is enabled in the district's Realize instance
- Verify the pilot Civics teacher's Claude for Teachers account
- District position on uploading licensed publisher materials to an external tool
- Dry run before handoff
- Confirm LEAP Civics assessment requirements
- **PelicanEd is uncharacterized** — do not treat any AI-supplied description of it as
  reliable
- **No crosswalk exists** between the LDOE unit/topic framework and the textbook's
  numbering

## Sync obligations

None. Introduces no `sync-registry.md` fields; nothing for `drift-check`.
