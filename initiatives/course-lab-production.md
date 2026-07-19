# Initiative — course-lab Production

**Vision:** The 2026–27 six-course room runs on course-lab from the first day of school: modules live, rosters real, data surviving school Chromebooks, families able to see what happens.

**Current state (2026-07-18):** Sink-hardening merged (PR #10, 13/13 tests, scripted browser pass). Remaining pre-August plan set, in order, in `course-lab/docs/superpowers/plans/`: smoke-verify → deploy → roster swap (`TEST01`/`TEST02` are placeholders — hard gate before student use) → registry guard → family coverage. Deploy surface undecided.

**Harvested inputs:** [[../wiki/patterns]] §6 (resilient sink — already applied), §7 (persona playtests — apply to the roster/family flows), §10 (append-only analytics if the measurement spine goes server-side). Anti-pattern on record: EdCoachAi's deleted E2E ([[../archaeology/edcoachai]]) — verification stays scripted-replay, never a CI gate that begs deletion.

**First sprint-sized slice:** already in the active sprint — run PLAN-course-lab-smoke-verify, then the deploy decision. This initiative doc exists so post-runway sprints (family coverage, measurement review, second-semester modules) have a home to be cut from.
