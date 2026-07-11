# PLAN-course-lab-smoke-verify

**Repo:** `course-lab` (`C:/Users/rplap/OneDrive/Desktop/personal/course-lab`)
**Verified starting state (2026-07-11):** `main` clean; `npm test` 10/10 green (roster 4, telemetry 6). Session 2 emit wiring merged 2026-07-10 (PRs #5–#9). Memory records: "no in-browser smoke test yet." Roster codes are placeholders `TEST01`/`TEST02` (`src/lib/roster.ts:7–10`).
**Contract:** `docs/course-lab-founding-spec.md` §4 (schema, emission rule, instrumented-events table §4.5). Read §4 before starting.

## Goal

Verify — in a real browser, end to end — that the wired telemetry spine actually produces the events §4.5 promises, and record the result. This is verification, not construction: expect ZERO code changes. If you find a defect, file it in the report and stop — do not fix inline (fixes get their own single-concern PR after Randall sees the report).

## Steps

1. `npm run dev`. Open the module picker.
2. **StartGate:** confirm the studentCode prompt appears once per browser session; `TEST01` (and lowercase ` test01 ` with whitespace — roster matching is trim + case-insensitive) admits; an off-roster code (`ZZZ99`) is refused and must NOT mint events (check localStorage after refusal).
3. **Standalone module pass:** open one PTR module (e.g. QuadraticsPTR). Confirm from localStorage (the spine's sink) that: `round_enter` fired on entry (per §4.5, from the prompt-dismissal handler for mount-live modules), `check` carries a `result` (`match`/`miss` only — course-lab has no `close` tier), `reveal_earned` fires at the reveal moment (commit-gated per the 2026-07-09 ruling), `complete` fires at completion, and every event carries `studentCode`, `sessionId`, `moduleId`, `moduleVersion`, `ts`.
4. **Suite grain pass:** open one remediation suite (Algebra or Geometry) and enter two different internal modules. Confirm `moduleId` uses the `<suite>/<internal>` form (§8 internal-grain ruling), `MODULE_VERSION` differs per internal module, and `sessionId` stays constant across internals within one suite mount.
5. **CSV export:** trigger the teacher CSV-export button on the picker. Confirm a flat event log — one row per LabEvent (§8 CSV ruling) — with a header row matching the schema fields, and that the rows match what you saw in localStorage.
6. **Parallel layer non-interference:** in the suite, confirm the pre-existing `useSessionReport` → SessionExport clipboard flow still works (ruled to run in parallel; the subsume trigger is "the two layers report different numbers for the same session" — if you observe that, it's a headline finding).
7. Write results to `course-lab/docs/smoke-test-2026-07.md` — table of §4.5 events × observed/missing per module tested, browser + date, defects found. (New-doc justification per extend-don't-create: no existing doc records runtime verification results; the founding spec is a contract, not a log.) Commit on branch `docs/session2-smoke-results`, PR, self-merge.

## Edge cases to probe (cheap, high-value)

- Refresh mid-module: does a new `sessionId` mint (it should — per-mount per §4.2)?
- Two modules in one browser session: studentCode should NOT re-prompt (once per session), but each mount gets a fresh `sessionId`.
- `reset` events: course-lab resets are post-reveal "start over" — §4.5 says structurally zero mid-round resets here; observing zero `reset` rows is CORRECT, not a bug.

## Acceptance criteria

- Every §4.5 event observed (or its documented-zero noted) for one standalone + two suite internals.
- CSV export opens in a spreadsheet with one row per event and correct `<suite>/<internal>` moduleIds.
- Report committed. Any defect described with repro steps, NOT fixed.

## Explicitly out of scope

- Swapping real roster codes (operator-only data — `roster.ts:5` placeholder comment).
- Deployment (production surface is an open operator decision, project card line 5).
- Any NOT-DOING row (backend sink, dashboard, drag telemetry — founding spec §6).
