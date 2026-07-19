# course-lab

*(Distilled from vault docs + sprint history; not re-mined — it is the live P1.)*

**Identity:** Production module library for the 2026–27 six-course room — PTR / Bind-and-Justify / Assume-Fit-Reflect frameworks + measurement spine + remediation suites. Founded 2026-07 under steel's ratified conventions; the first repo built *for students in the operator's own room* rather than for a conference or a market. P1 of Fall Runway.
**Stack:** Plain JavaScript/JSX + SVG — deliberately not R3F (repo boundary = stack boundary); localStorage-family data sink, recently hardened (PR #10: never-throwing sink, memory fallback for cookie-blocked Chrome, two-step clear control; 13/13 tests + scripted browser verification).
**Patterns worth keeping:**
- **Never-throwing storage sink with graceful fallback** — the sink-hardening pattern (memory fallback when localStorage is blocked) is the mature descendant of iste-outreach-tracker's seed+localStorage overlay; portable to any no-backend classroom tool.
- **Plan-set discipline** — ordered pre-August plans in `docs/superpowers/plans/` (smoke-verify → deploy → roster swap → registry guard → family coverage): sprint-sized slices written before code.
- Scripted-browser verification replacing manual QA steps (Playwright replay of a plan's manual pass).
**Dead ends & lessons:** Roster codes still placeholders (`TEST01`/`TEST02`) — flagged before student use.
**Verdict candidate:** **keep (active P1)** — the production center of gravity; its initiative doc = the existing plan set + deploy decision.
