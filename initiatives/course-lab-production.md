# Initiative — course-lab Production

**Vision:** The 2026–27 room — **Algebra II and Algebra III on EdgeEx** ([[../wiki/decisions]] D-2026-07-22b; the six-course framing is historical) — runs on course-lab from the first day of school: modules live, rosters real, data surviving school Chromebooks, families able to see what happens.

**Current state (2026-07-25):** The pre-August plan set is **complete** — six single-concern PRs 2026-07-17 → 07-19 (sink-hardening #10, smoke-verify #11, real roster codes #12, deploy #13, registry guard #14, family coverage #15), plus the first EdgeEx build `transformations-ptr` (#16) on 07-24. Live at <https://course-lab-two.vercel.app>, auto-deploying from `main`, 31/31 green. Architecture ruled client-side, backend NOT-DOING ([[../wiki/decisions]] D-2026-07-24).

**What is left is not code.** Two operator-only items, both gate-blocking, both with a first-day-of-school deadline:

1. **School-network check** — open the live URL from a school device before August. District filters may block `*.vercel.app`; the fix is a custom domain, which costs DNS propagation time and cannot be improvised on day one.
2. **Collection protocol + one DEMO01 dry run** — [[../wiki/depth-criteria]] §OPEN. Events live per-browser under `course-lab:events`; on a storage-blocked profile the sink falls back to memory and loses the session silently at tab close. Without a written protocol, the first class period produces no readable data and the build-two gate cannot open regardless of how the module performs.

**Harvested inputs:** [[../wiki/patterns]] §6 (resilient sink — applied), §7 (persona playtests — applied to the roster/family flows), §10 (append-only analytics if the measurement spine ever goes server-side; currently NOT-DOING). Anti-pattern on record: EdCoachAi's deleted E2E ([[../archaeology/edcoachai]]) — verification stays scripted-replay, never a CI gate that begs deletion.

**Next sprint-sized slice:** not a build. A classroom run of `transformations-ptr`, then one read against [[../wiki/depth-criteria]]. Post-runway slices (measurement review, second-semester modules) get cut from here; the build family itself lives in [[edgeex-build-family]].
