# PLAN-course-lab-sink-hardening

**Repo:** `course-lab` (`C:/Users/rplap/OneDrive/Desktop/personal/course-lab`)
**Verified starting state (2026-07-11):** `main` clean; `npm test` 10/10 green (roster 4, telemetry 6). Session 2 emit wiring merged.
**Contract:** `docs/course-lab-founding-spec.md` §4.3 (sink interface), §4.4 (emission rule). Read both before starting.
**Branch:** `feat/sink-hardening` — create it before the first edit. Never commit to `main`. PR + self-merge when green.

## Goal

Telemetry must never break pedagogy. Today three storage failures can hurt a live lesson:

1. `telemetry.ts:103` — `store.setItem` inside `write()` is uncaught. A `QuotaExceededError` (or any storage failure) propagates up into the module's click handler mid-lesson, aborting the student's action.
2. `App.jsx:26` — `createLocalStorageSink()` defaults its store to `globalThis.localStorage`, and in Chrome with cookies/site-data blocked **the property access itself throws SecurityError** — at module scope, so the whole app renders nothing.
3. The teacher CSV export (`exportCsv`) deliberately does not clear the buffer, but there is no way to clear it at all from the UI — day 2's export re-contains day 1's rows forever on that device.

Fix all three: never-throwing sink, safe store resolution with in-memory fallback, and a two-step (no `window.confirm` — dialogs block browser automation) clear control on the picker.

## Files

- Modify: `src/lib/telemetry.ts` (lines 86–114, the `createLocalStorageSink` block)
- Modify: `src/lib/telemetry.test.ts` (append a `describe`)
- Modify: `src/App.jsx` (teacher footer, lines 160–166)

## Steps

- [ ] **1. Branch:** `git checkout -b feat/sink-hardening`

- [ ] **2. Write the failing tests.** Append to `src/lib/telemetry.test.ts` (the `memoryStore` helper already exists at the top of the file):

```typescript
describe("hardening — telemetry never breaks pedagogy", () => {
  it("write never throws when the store rejects the write", () => {
    const store = memoryStore();
    store.setItem = () => {
      throw new Error("QuotaExceededError");
    };
    const emit = createEmitter(createLocalStorageSink(store), context);
    expect(() => emit(partial)).not.toThrow();
  });

  it("falls back to an in-memory buffer when no store is available", () => {
    const sink = createLocalStorageSink(null);
    createEmitter(sink, context)(partial);
    expect(sink.flush()).toHaveLength(1);
  });

  it("flush returns the events even when the store rejects the clear", () => {
    const store = memoryStore();
    createEmitter(createLocalStorageSink(store), context)(partial);
    store.removeItem = () => {
      throw new Error("SecurityError");
    };
    expect(createLocalStorageSink(store).flush()).toHaveLength(1);
  });
});
```

- [ ] **3. Run:** `npm test` — expect the first two new tests to FAIL (`write` throws; `null` store crashes on `store.getItem`). The pre-existing 10 must still pass.

- [ ] **4. Implement.** In `src/lib/telemetry.ts`, replace the `createLocalStorageSink` function (keep `STORAGE_KEY`, `StringStore`, and everything above it unchanged) with:

```typescript
// Chrome with cookies/site-data blocked throws on the localStorage property
// access itself — resolve the default store defensively.
function defaultStore(): StringStore | null {
  try {
    return globalThis.localStorage ?? null;
  } catch {
    return null;
  }
}

function memoryFallbackStore(): StringStore {
  const map = new Map<string, string>();
  return {
    getItem: (k) => map.get(k) ?? null,
    setItem: (k, v) => {
      map.set(k, v);
    },
    removeItem: (k) => {
      map.delete(k);
    },
  };
}

export function createLocalStorageSink(
  store: StringStore | null | undefined = defaultStore(),
  key: string = STORAGE_KEY
): TelemetrySink {
  // No usable store → buffer in memory: events survive the mount, not a
  // refresh. Degraded telemetry beats a blocked student (spec §4.4 spirit).
  const s: StringStore = store ?? memoryFallbackStore();
  const read = (): LabEvent[] => {
    try {
      const raw = s.getItem(key);
      const parsed = raw ? JSON.parse(raw) : [];
      return Array.isArray(parsed) ? parsed : [];
    } catch {
      return []; // corrupt buffer never blocks new events
    }
  };
  return {
    write(event) {
      try {
        const events = read();
        events.push(event);
        s.setItem(key, JSON.stringify(events));
      } catch {
        // A storage failure drops the event, never the student's action.
      }
    },
    flush() {
      const events = read();
      try {
        s.removeItem(key);
      } catch {
        // The caller still gets the events; the buffer just didn't clear.
      }
      return events;
    },
    exportCsv() {
      return toCsv(read());
    },
  };
}
```

- [ ] **5. Run:** `npm test` — expect 13/13 PASS.

- [ ] **6. Commit:** `git add src/lib/telemetry.ts src/lib/telemetry.test.ts && git commit -m "feat: harden localStorage sink — write/flush never throw, memory fallback"`

- [ ] **7. Add the clear control to the picker.** In `src/App.jsx`, inside `App()`, add a state next to the existing two (line ~115):

```jsx
const [confirmingClear, setConfirmingClear] = useState(false);
```

Then replace the teacher footer `<p>` (lines 160–166) with:

```jsx
<p style={{ marginTop: "32px", fontSize: "13px", color: "#666" }}>
  Teacher:{" "}
  <button onClick={exportTelemetryCsv} style={{ fontSize: "13px" }}>
    Export telemetry CSV
  </button>{" "}
  (flat event log, one row per event — spec §8){" "}
  {!confirmingClear ? (
    <button onClick={() => setConfirmingClear(true)} style={{ fontSize: "13px", marginLeft: "8px" }}>
      Clear device telemetry…
    </button>
  ) : (
    <span>
      <button
        onClick={() => {
          sink.flush();
          setConfirmingClear(false);
        }}
        style={{ fontSize: "13px", marginLeft: "8px", color: "#a3261f" }}
      >
        Really clear — export first
      </button>
      <button onClick={() => setConfirmingClear(false)} style={{ fontSize: "13px", marginLeft: "4px" }}>
        Cancel
      </button>
    </span>
  )}
</p>
```

- [ ] **8. Manual verification** (no jsdom in this repo; do not add component-test infrastructure — that renovation is out of scope):
  1. `npm run dev`, open the picker, enter a module with `TEST01`, click through a couple of actions, return to the picker.
  2. DevTools → Application → Local Storage: `course-lab:events` has rows.
  3. Click **Export telemetry CSV** — file downloads; `course-lab:events` still present (export is non-destructive).
  4. Click **Clear device telemetry…** → **Cancel** — key untouched.
  5. Click **Clear device telemetry…** → **Really clear** — `course-lab:events` key is gone.
  6. Enter a module again — new events write fine after a clear.

- [ ] **9. Run** `npm test && npm run build` — both green.

- [ ] **10. Commit, push, PR, self-merge:** `git add src/App.jsx && git commit -m "feat: two-step clear-telemetry control on the picker"` then `git push -u origin feat/sink-hardening` and open the PR.

## Edge cases a weaker model would miss

- **Do NOT use `window.confirm`/`alert`** for the clear control. Native dialogs block browser-automation smoke runs and are worse UX; the two-step inline button is the ruling.
- The clear button sits on a student-reachable page. The two-step label ("export first") is the guard; do not hide it behind teacher auth — that's renovation (spec §5) and privacy surface is ≈ zero anyway (§4.6).
- `flush()` must return the events **before** attempting the clear, so data is never lost to a failing `removeItem`.
- The `store ?? memoryFallbackStore()` resolution must happen **once, at sink creation** — not per call — so the memory fallback accumulates across writes.
- `createLocalStorageSink(null)` must type-check: the parameter type widens to `StringStore | null | undefined`. Do not silence with `as any`.
- Existing tests pass a `memoryStore()` explicitly — they must keep passing unchanged. If one breaks, you changed behavior, not just safety.
- The suites' `useSessionReport`/SessionExport clipboard layer is a **parallel instrument** (spec §8 ruling) — do not touch it here.

## Acceptance criteria

- `npm test`: 13/13 green (10 pre-existing + 3 new).
- `npm run build`: clean.
- Manual pass in step 8 fully observed, including writes-after-clear.
- Zero changes outside the three named files.

## Explicitly out of scope

- Backend sink, buffer size caps, multi-tab coordination (NOT-DOING §6 — small n).
- jsdom / component tests for App.jsx.
- Any module file.
