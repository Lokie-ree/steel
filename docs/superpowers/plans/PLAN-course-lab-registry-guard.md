# PLAN-course-lab-registry-guard

**Repo:** `course-lab` (`C:/Users/rplap/OneDrive/Desktop/personal/course-lab`)
**Verified starting state (2026-07-11):** `main` clean; `npm test` 10/10. `src/App.jsx:9` defines `const MODULES = [...]` (12 entries, un-exported). Every module file exports `MODULE_VERSION` and `TELEMETRY_ENTRY` (verified by grep 2026-07-11); no module file touches browser globals at module scope, so they import cleanly in Vitest's node environment.
**Contract:** founding spec §4.2 (moduleId convention, `<suite>/<internal>` grain), §4.6 (versioning).
**Branch:** `test/registry-guard`.

## Goal

One cheap test file that guards the wiring contract across all 12 module files: every registered module exports a semver `MODULE_VERSION` and a well-formed `TELEMETRY_ENTRY`, ids are unique kebab-case, suites use the `<suite>/<internal>` grain, and no module file exists outside the registry. Today a wiring regression (typo'd entry, forgotten export on a new module) is only catchable in a browser; after this, `npm test` catches it.

This is **not** test backfill for module behavior (NOT-DOING §6) — it tests the spine's wiring contract, which is new Session-2 surface.

## Files

- Modify: `src/App.jsx` line 9 (add `export` — one word)
- Create: `src/registry.test.jsx`

## Steps

- [ ] **1. Branch:** `git checkout -b test/registry-guard`

- [ ] **2. Write the test first.** Create `src/registry.test.jsx`:

```jsx
import { describe, expect, it } from "vitest";
import { MODULES } from "./App.jsx";

// Wiring-contract guard (spec §4.2, §4.6): registry ↔ module-file exports.
// Not behavior tests — module behavior earns tests when next touched (§6).

const SUITE_IDS = ["algebra-remediation", "geometry-remediation"];
const SEMVER = /^\d+\.\d+\.\d+$/;

describe("module registry", () => {
  it("registers every module file exactly once", () => {
    const files = Object.keys(import.meta.glob("./modules/*.jsx"));
    expect(MODULES).toHaveLength(files.length);
    expect(new Set(MODULES.map((m) => m.id)).size).toBe(MODULES.length);
  });

  it("uses kebab-case ids (spine moduleId convention, spec §4.2)", () => {
    for (const m of MODULES) {
      expect(m.id).toMatch(/^[a-z0-9]+(-[a-z0-9]+)*$/);
    }
  });
});

describe("module exports (spine wiring contract)", () => {
  for (const m of MODULES) {
    it(`${m.id} exports MODULE_VERSION and a valid TELEMETRY_ENTRY`, async () => {
      const ns = await m.load();
      expect(typeof ns.default).toBe("function");
      expect(ns.MODULE_VERSION).toMatch(SEMVER);

      const entry = ns.TELEMETRY_ENTRY;
      expect(entry).toBeTruthy();
      expect(typeof entry.roundId).toBe("string");
      expect(entry.roundId.length).toBeGreaterThan(0);
      expect(typeof entry.guideState).toBe("string");
      expect(entry.guideState.length).toBeGreaterThan(0);

      if (SUITE_IDS.includes(m.id)) {
        // Suites are live at an internal module on mount (§8 internal-grain
        // ruling): entry carries '<suite>/<internal>' + that internal's version.
        expect(entry.moduleId).toMatch(new RegExp(`^${m.id}/[a-z0-9]+(-[a-z0-9]+)*$`));
        expect(entry.moduleVersion).toMatch(SEMVER);
      } else {
        // Standalones inherit moduleId/version from the registry + file.
        expect(entry.moduleId).toBeUndefined();
      }
    });
  }
});
```

- [ ] **3. Run:** `npx vitest run src/registry.test.jsx` — expect FAIL at the import: `MODULES` is not exported from `./App.jsx`. (This is the fail-first proof.)

- [ ] **4. Export the registry.** In `src/App.jsx` line 9, change `const MODULES = [` to `export const MODULES = [`. Nothing else.

- [ ] **5. Run:** `npm test` — expect all files green: 10 pre-existing + 14 new (2 registry + 12 per-module). Exact count may differ if other plans landed first; the point is zero failures.

- [ ] **6. If any per-module test fails, treat it as a finding, not a fixup.** A failure here means the Session-2 wiring has a real defect (missing export, malformed entry, non-kebab internal id). Record the exact failure in the PR description and fix **only** the defective export line to match the contract — do not restructure the module.

- [ ] **7. Verify the guard bites:** temporarily change one module's `MODULE_VERSION` to `"1.0"` → run → that one test fails; revert → green. (Do not commit the sabotage.)

- [ ] **8. Run** `npm run build` (the App.jsx edit must not break the build), **commit** (`test: registry + wiring-contract guard across all 12 modules`), push, PR, self-merge.

## Edge cases a weaker model would miss

- `import.meta.glob` is a **Vite** feature that Vitest transforms natively — it works in this repo's tests without config. Do not replace it with `fs.readdirSync` (path-fragile) and do not add `{ eager: true }` (eagerly importing all 12 modules at collection time is slower and unnecessary — only the keys are used; the per-module tests import via the registry's own `load()` thunks, which is exactly the code path the app uses).
- Importing `App.jsx` executes `createLocalStorageSink()` at module scope. In Vitest's node environment `globalThis.localStorage` is undefined — sink **creation** does not touch the store, so this is safe today; if it ever throws, that is a real app bug in cookie-blocked Chrome (see PLAN-course-lab-sink-hardening), not a test problem to mock away.
- The per-module `it`s are generated in a `for` loop at collection time — `MODULES` must be imported statically for that to work; do not move the import inside `describe` callbacks or make it dynamic.
- Suite entries carry `moduleId`/`moduleVersion`; standalone entries must **not** (the StartGate falls back to registry id + file version — `App.jsx:66-70`). The asymmetry is the contract; don't "normalize" it.
- The file is `.jsx` under the default Vitest include glob — no `vitest.config` changes, no jsdom, no `environment` pragma. If you find yourself editing `vite.config.js`, stop.
- Test count breathes with other plans (sink-hardening adds 3, roster-swap adds 3). Assert "all green", never a hardcoded total.

## Acceptance criteria

- `npm test` green with the 14 new tests listed in output; `npm run build` clean.
- Fail-first proven at step 3 and guard-bite proven at step 7.
- Diff touches exactly two files, and the `App.jsx` diff is one word.

## Explicitly out of scope

- Behavior/interaction tests for any module (NOT-DOING §6 trigger: next real modification).
- jsdom, React Testing Library, or any new devDependency.
- Renaming ids or restructuring `MODULES`.
