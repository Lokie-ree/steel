# PLAN-course-lab-roster-swap

**Repo:** `course-lab` (`C:/Users/rplap/OneDrive/Desktop/personal/course-lab`)
**Verified starting state (2026-07-11):** `src/lib/roster.ts:7-10` holds placeholders `TEST01`/`TEST02` with a PLACEHOLDER comment; `roster.test.ts` (4 tests) uses its own local `ROSTER` constant and does not reference the placeholders; `npm test` 10/10 green.
**Contract:** founding spec §8 studentCode ruling ("a typo must not mint a phantom student") and §4.6 (roster-to-name mapping lives **offline** with Randall; the app never stores a real name).
**Ordering:** run **after** PLAN-course-lab-smoke-verify (its script types `TEST01`) and **before** any student touches the deployed URL (PLAN-course-lab-deploy step 6 gates on this plan).
**Branch:** `feat/real-roster-codes`.

## Goal

Replace the placeholder roster with real opaque codes plus one documented demo code, and add guard tests so a placeholder roster can never silently ship again.

## Required operator input

The number of enrolled students across all six courses (call it N). Randall keeps the code↔name mapping offline; the executor never sees or records names.

## Steps

- [ ] **1. Branch:** `git checkout -b feat/real-roster-codes`

- [ ] **2. Generate N + 10 codes** (spares for late enrollees — appending later beats regenerating). Run in Git Bash; the charset drops the ambiguous `0 O 1 I L`:

```bash
node -e "const cs='ABCDEFGHJKMNPQRSTUVWXYZ23456789';const n=+process.argv[1];const out=new Set();while(out.size<n){out.add(Array.from({length:5},()=>cs[Math.floor(Math.random()*cs.length)]).join(''))};console.log([...out].join('\n'))" 40
```

(Replace `40` with N + 10.) Hand the list to Randall to assign codes→names **offline** (his spreadsheet, never a repo file). Only the bare code list comes back into the repo.

- [ ] **3. Write the failing guard tests.** Append to `src/lib/roster.test.ts` (add `ROSTER_CODES` to the existing import from `./roster`):

```typescript
describe("production roster", () => {
  it("contains no placeholder codes", () => {
    expect(ROSTER_CODES).not.toContain("TEST01");
    expect(ROSTER_CODES).not.toContain("TEST02");
  });

  it("codes are unique after normalization", () => {
    const normalized = ROSTER_CODES.map(normalizeStudentCode);
    expect(new Set(normalized).size).toBe(normalized.length);
  });

  it("every roster code admits itself through the real validator", () => {
    for (const code of ROSTER_CODES) {
      expect(isRosterCode(code)).toBe(true);
    }
  });
});
```

- [ ] **4. Run:** `npm test` — the "no placeholder codes" test FAILS against the current file. The other 10 stay green.

- [ ] **5. Swap the roster.** In `src/lib/roster.ts`, replace the `ROSTER_CODES` array: delete `TEST01`/`TEST02` and the PLACEHOLDER comment block (lines 5–6), insert the generated codes one per line, and keep exactly one demo entry with this comment:

```typescript
export const ROSTER_CODES: string[] = [
  // DEMO01 is the teacher-demo code — filter studentCode === "DEMO01" out of
  // any offline analysis. It exists so demos never mint a phantom student row
  // under a real code.
  "DEMO01",
  // Real codes below — assigned offline (spec §4.6); append-only, never
  // reassign a code to a different student (same rule as roundIds, §4.6).
  "XXXXX",
  // …
];
```

- [ ] **6. Run:** `npm test` — expect all green (13/13 if this lands before PLAN-course-lab-sink-hardening, 16/16 after).

- [ ] **7. Manual check:** `npm run dev` → pick a module → one real code admits; `TEST01` is now **refused**; the refusal writes no event (DevTools → Local Storage → no `course-lab:events` growth on refusal).

- [ ] **8. Commit, push, PR, self-merge:** `git commit -m "feat: real roster codes + placeholder guard tests"`. Then update the hub card `projects/course-lab.md` open-items line (roster item done — leave hub edit uncommitted) and, if the deploy exists, confirm auto-deploy shipped the new roster to production before students get the URL.

## Edge cases a weaker model would miss

- **One namespace across all six courses.** A student in two courses gets ONE code; two students must never share one. Uniqueness is per-roster, not per-course — the guard test enforces the file, Randall's offline sheet enforces the assignment.
- **Codes are append-only, like roundIds (spec §4.6).** Mid-year roster changes append new codes; a departed student's code is retired, never reassigned — reassignment silently merges two students in every historical CSV join.
- **Never let names touch the repo.** If Randall hands back a file pairing codes with names, do not commit it, do not paste it into the PR, do not leave it in the working tree. Only bare codes enter `roster.ts`.
- Codes are stored uppercase in the file; matching is trim + case-insensitive (`normalizeStudentCode`), so students can type lowercase. Do not "helpfully" store mixed-case codes — the uniqueness test normalizes, but the file convention is uppercase.
- A returning device may have `TEST01` cached in `sessionStorage` (`course-lab:studentCode`). That is harmless: the StartGate pre-fills it but re-validates on Start, so it's refused and the student retypes. Do not add cache-clearing code.
- The guard tests and the swap land in the **same PR** — the placeholder test is red until the swap, so splitting them breaks the checkpoint-commit rule (every commit green). Commit test+swap together after step 6.
- Generation must run until the `Set` reaches N+10 — the Set dedupes collisions; do not switch to an array.

## Acceptance criteria

- `npm test` green including the three new guard tests; the placeholder test proven red first (step 4).
- `TEST01` refused in the browser with zero events minted; one real code and `DEMO01` admit.
- No file in the repo or PR contains a student name.
- Hub card open-items line updated.

## Explicitly out of scope

- Roster as external data/JSON, teacher roster-editing UI (YAGNI — it is a constant array by ruling).
- Auth of any kind.
- Filtering DEMO01 inside the app (offline analysis concern).
