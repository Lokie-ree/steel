# ts-google-automation

**Identity:** TypeScript CLI (`pelican-beta`) generating Google Docs and Forms from Markdown templates for the Pelican AI beta program — welcome kits, framework docs, feedback surveys — then exporting resulting URLs as constants for a Convex email backend. Built Oct 2025; two commits (initial 2025-11-26, `fix: Resolve Google Form generation issues` 2026-01-07 with a success screenshot). **Finished for its one-shot purpose.**
**Stack:** Node/TS (ESM), commander, googleapis + `@google-cloud/local-auth`, marked + gray-matter, chalk/ora, tsx. No tests.
**Patterns worth keeping:**
- Layered CLI with sequential-dependency orchestration — `src/cli.ts:44-86`: forms → framework doc (needs survey URL) → welcome kit (needs all URLs).
- **Markdown-as-template-DSL** — `src/parsers/survey-parser.ts:6-80`: `**Type:**`/`**Options:**`/`**Rows:**` markdown parsed into typed survey questions via a small line-state parser. Reusable for any markdown→structured-form conversion.
- Cross-tool handoff via codegen — `src/generators/link-manager.ts:46-55` emits ready-to-paste Convex constants.
**Dead ends & lessons:** Google Forms API is fiddly (inverted choice-grid rows/columns, exact JSON shapes, OAuth `invalid_grant` pain); with no tests, all found at runtime. 172-line parser fix commit documents it.
**Verdict candidate:** **absorb** — harvest the markdown→Forms parser and codegen-handoff patterns; the tool itself is a spent one-shot tied to a finished beta launch.
