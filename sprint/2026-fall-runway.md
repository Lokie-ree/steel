# Sprint — Fall Runway

**Window:** 2026-07-17 → **2026-08-10, first day for students** (confirmed 2026-07-31). **Teachers return 2026-08-03** — a full week in the building, on school devices, on the district network, before any student arrives. The runway is therefore three desk days (Jul 31 – Aug 2) and five building days (Aug 3–7), not one undifferentiated countdown.
**Goal:** course-lab production-ready for students (done — live, 30/30, guarded); first EdgeEx-aligned build shipped; hub baseline reflects the post-ISTE identity — the teacher who builds with/for students, across all active repos.

**Assignment correction (2026-07-22):** the 2026–27 room is **two preps** — Algebra II and Algebra III on EdgeEx — not six. The infrastructure already built was sized for the larger workload, so the shrink is slack: fewer, deeper builds, gated on real student data ([[../wiki/decisions]] 2026-07-22).

Update this file at the **start and end** of each work session.

**North star:** Algebra II/III on EdgeEx (see [[../wiki/edge-ex-courses]]). Builds are the supplemental agile layer on top of the district curriculum — never a replacement. ~20 lessons overlap between the two courses: build once, serve both preps.

---

## Priority stack

| P | Repo | Why |
|---|------|-----|
| 1 | **course-lab** | ~~Execute `PLAN-course-lab-transformations-ptr`~~ — **shipped 2026-07-24 (PR #16)**, as specced: four rounds, two families, earned sandbox, live in production. What's left is not code: run it with real students. Pre-August plan set complete (PRs #10–#15). |
| 2 | **steel** | ~~Depth criteria doc~~ — **written 2026-07-24** ([[../wiki/depth-criteria]]): four signals off existing telemetry, two thresholds. The gate is now waiting on students, not on writing. |
| 3 | **portfolio** | ~~Parked branch `docs/dilations-card-copy`~~ — **closed 2026-07-24**: already merged upstream (PR #12), branch was stale locally. Dormant, clean on master. |
| — | **creative-lab** | **Live spoke, no fall build** — by ruling, not neglect ([[../wiki/decisions]] 2026-07-22). R3F/CSG stays a shipping capability; neither EdgeEx course has spatial content to aim it at. |
| — | **iste-26** | Dormant. Voice docs homed via PR #7 (2026-07-17); drift check clean. Touch only if something breaks. |
| — | **creative-lab-demos** | Dormant. Touch only if something breaks. |
| — | **project-studio-coach** | Dormant. Spoke stays registered; no sprint work. |

---

## Per-repo status

### course-lab — P1

- **Live git state:** `pwsh ops/repo-state.ps1`
- **Pre-August plan set COMPLETE** — six single-concern PRs, 2026-07-17 → 07-19: sink-hardening (#10), smoke-verify (#11), real roster codes (#12), deploy (#13), registry guard (#14), family coverage (#15). Live at `course-lab-two.vercel.app`, auto-deploy from `main`, 30/30 green, registry guard bites on a typo'd row. Randall assigns codes→names offline before student use.
- **`transformations-ptr` shipped 2026-07-24** (PR #16), as specced; `beatId` dual-semantics note followed (PR #17). 31/31, live in production.
- **Next: one operator-only item.** The school-network check passed (2026-07-26) and the collection protocol is written ([[../wiki/collection-protocol]]). What remains is the `DEMO01` dry run in the building. Then run the module with students and read it against [[../wiki/depth-criteria]].
- **`storage health` shipped 2026-07-26** (PR #18): the sink now probes whether it can round-trip a write, and the picker and start gate say so. The "next: nothing in code" line above was wrong on one point — the silent-telemetry-loss risk recorded in [[../wiki/depth-criteria]] was a code problem the sink could already answer, and answering it is what made the protocol short.
- **`family-coverage.md`: do not rebuild.** The six-course grid did its job (surfaced gaps while there was lead time). Add one dated header note — assignment changed to Algebra II/III, other four columns are historical — and move on. Renovating it is bookkeeping.

### creative-lab — live spoke, no fall build

- **State:** M1–M3 stable; ISTE exhibit concluded; drift check clean
- **Ruling 2026-07-22:** no fall build targets R3F/CSG because neither EdgeEx course has spatial content. The spoke stays live and the capability stays shipping — this is a scope decision, not decay. See [[../wiki/decisions]].

### steel — P2

- **Complete this sprint:** `wiki/edge-ex-courses.md` (2026-07-17); `wiki/journey.md` + `archaeology/` + `wiki/patterns.md` + `initiatives/` + ratified verdicts (2026-07-18); stale ISTE-40d framing swept from live docs (2026-07-19); registry drift swept (PR #14, 2026-07-22); two-course rulings landed (2026-07-24)
- **Next:** nothing until the first class period — the gate is written and the vault is current
- **Not doing:** the Fable standards-mapping audit as originally scoped (29 units × 6 courses — dead with the shrink). Useful residue is one narrow question: do `systems-ptr` and `predict-test-reconcile` actually earn their standards citations? Shrink to that or leave it closed; don't run the original prompt out of momentum.

### portfolio — P3

- **State:** clean on master, no parked work. `docs/dilations-card-copy` closed 2026-07-24 — it had already merged upstream as PR #12; ten stale local branches pruned.
- **Next:** nothing this sprint

### iste-26 — P5 (maintenance)

- **State:** clean on master; `iste-narrative.md` + `lab-guide-rubric.md` merged via PR #7 (2026-07-17)
- **Next:** nothing this sprint

---

## This week's suggested focus

1. ~~**Clear the drift verdict**~~ — done 2026-07-17: iste-26 docs homed (PR #7), drift check PASS
2. ~~**course-lab: pre-August plan set**~~ — done 2026-07-19, all six PRs (#10–#15)
3. ~~**Transformation explorer brainstorm**~~ — done 2026-07-19: spec + PLAN-course-lab-transformations-ptr shipped; home ruled course-lab (decisions log)
4. ~~**Land the two-course rulings in vault truth**~~ — done 2026-07-24: decisions log, initiative doc, this sprint doc
5. ~~**Execute `PLAN-course-lab-transformations-ptr`**~~ — done 2026-07-24 (PR #16), live in production
6. ~~**Depth criteria doc**~~ — done 2026-07-24 ([[../wiki/depth-criteria]]); read it once on the first real run's CSV
7. ~~**portfolio `docs/dilations-card-copy`**~~ — done 2026-07-24: already merged upstream, stale branch pruned

**Live as of 2026-07-25 — both operator-only, both gate-blocking, both deadlined by the first day of school.** Neither is code, which is why a build-heavy July left them invisible; they were recorded only inside a spoke card's Status block until now.

8. **School-network check** — open <https://course-lab-two.vercel.app> from a school device on the district network. If `*.vercel.app` is filtered, the fix is a custom domain: DNS plus propagation, so it cannot be improvised on day one. **This is the item that fails latest and costs most.** Do it the next time you are in the building.
9. ~~**Collection protocol**~~ — **written 2026-07-26** ([[../wiki/collection-protocol]]). Two findings shrank it: the storage failure is now visible before a student starts (course-lab PR #18), and the four signals split across two independent paths — the reconcile prose travels by clipboard from React state and survives a fully storage-blocked device, so there is a floor the gate can stand on regardless of the CSVs.

10. ~~**Reconcile calibration set**~~ — **written 2026-07-26** ([[../wiki/reconcile-calibration]]). Sort the 15 blind before the first CSV; disagreements get resolved there, not mid-read.
11. ~~**Shell paint**~~ — **shipped 2026-07-26** (course-lab PR #19), with `docs/design-brief.md` as the constraints doc. Not a new design skill: what was missing was the brief, which is what a skill would mostly have contained. Package one only if a semester's repetition earns it.

9b. **One `DEMO01` dry run — the last gate-blocking item.** [[../wiki/collection-protocol]] §The DEMO01 dry run: seven checks, on a **school** device on the **district** network. Everything in the protocol is reasoned from the code and the 2026-07-26 network check; none of it has run in the building. The gate does not open on a protocol that has only ever run on this laptop. One student, one device, fifteen minutes.

> **Scheduled: teacher week, Aug 3–7 — and early in it, Mon/Tue.** Teacher week compresses toward the end as meetings and PD fill it; a fifteen-minute task that needs a specific device on a specific network is exactly what gets squeezed out on Thursday. It does not need a student — `DEMO01` is the demo code.
>
> **Superseded 2026-08-04 — do not run this until 8b is answered.** The Mon/Tue urgency assumed the network was known. It is not. A dry run on an unidentified network produces a PASS that cannot be reused and reads as settled six weeks later. **Answering 8b first is not a delay, it is the difference between a result and a rumor.** Slipping past Tuesday is now the cheaper error.

**Update 2026-07-26 — item 8 CLOSED.** Operator ran the check on a school Chromebook on the district wifi: site loads, module runs. The custom-domain/DNS branch is dead; the item that "fails latest and costs most" is off the board. **Item 9 is now the only gate-blocking item**, and it was not tested during the same visit.

8b. **Which network does the room actually run on? — OPEN 2026-08-04, and it now gates 9b.** The room is moving into the community college and it is unknown whether it runs on district wifi or on the college's own network and filtering. **Item 8 above is not reversed — it is scoped.** That check was correct for the network it ran on; what no longer holds is the inference that it predicts the room students will sit in, including the conclusion that the custom-domain/DNS branch is dead. Different network, different vendor, different allowlist.

> **Answer it by asking, not by testing** — whoever is standing up that room knows, it costs a conversation, and it needs no Chromebook. Then run 9b and **record the network name in the result row** ([[../wiki/collection-protocol]] §Which network, §The DEMO01 dry run step 0).
>
> The general rule this earns, worth more than the item: **a network result is only as portable as the network it was observed on.** Same family as *git state is derived, never transcribed* — an environment-dependent fact recorded without its environment decays into folklore, and item 8 spent nine days looking more settled than it was.

**Not a focus item: polishing `transformations-ptr`'s flow.** [[../wiki/depth-criteria]] rules against smoothing the path pre-data — the operator's own run is n=1 and expert, and load is indistinguishable from friction from the inside. Shell-level polish (picker, typography, spacing, the teacher export screen) is fine; the PTR path's affordances, reading volume, and producer stage wait for the first CSV.

---

## Session log

| Date | Repo | What happened |
|------|------|---------------|
| 2026-07-17 | steel | Sprint opened. EdgeEx PDFs ingested → wiki/edge-ex-courses.md; ISTE-40d sprint archived |
| 2026-07-17 | steel | Session started |
| 2026-07-17 | iste-26 | Voice docs (`iste-narrative.md`, `lab-guide-rubric.md`) committed + merged via PR #7; drift check now a clean PASS |
| 2026-07-17 | course-lab | `feat/sink-hardening` landed (PR #10): 13/13 tests, build clean, plan step-8 manual pass replayed via scripted Playwright; merged local branches pruned |
| 2026-07-18 | steel | Session started |
| 2026-07-18 | steel | Portfolio consolidation: 17-repo archaeology (`archaeology/`), verdicts ratified (Pelican spine absorbed; portfolio stays the door; nine bulk rulings), `wiki/journey.md` + `wiki/patterns.md` written, five initiative docs opened (`initiatives/`) |
| 2026-07-18 | course-lab | PLAN-course-lab-smoke-verify executed via scripted Playwright (Chrome extension down — fallback recipe): PASS, zero defects, report merged (PR #11) |
| 2026-07-18 | course-lab | PLAN-course-lab-roster-swap executed: 40 real codes + DEMO01, guard tests red→green, browser-verified, merged (PR #12) |
| 2026-07-18 | course-lab | PLAN-course-lab-deploy executed: live at course-lab-two.vercel.app (Vercel CLI, git-connected for auto-deploy), production loop verified with DEMO01, README URL merged (PR #13) |
| 2026-07-18 | course-lab | PLAN-course-lab-registry-guard executed: 14 wiring-contract tests, fail-first + guard-bite proven, 30/30 green, merged (PR #14) |
| 2026-07-19 | course-lab | PLAN-course-lab-family-coverage executed: 29-unit inventory + six-course grid merged (PR #15) — pre-August plan set COMPLETE; operator judgment cells open |
| 2026-07-19 | steel | Transformation explorer brainstormed to spec + plan (2 reviewer passes); home ruled course-lab; P2 planning item closed |
| 2026-07-19 | steel | Wrap-up: stale ISTE framing swept from live docs (P3 complete); vault shipped current for mentor review 2026-07-20 |
| 2026-07-22 | steel | Session started |
| 2026-07-22 | github-readme | Profile README rewritten for a builder audience around the Steel hub architecture (PR #1): three-facet frame replaces the ISTE two-arc framing, six-spoke diagram, course-lab + studio-coach added, lineage/patterns from the consolidation |
| 2026-07-22 | github-readme | Design layer shipped (PRs #2 → #3): bespoke header SVG from portfolio `tokens.ts` (light/dark via `<picture>`, mark = the A(1,1) B(4,2) C(2,4) fixture), two-design-systems panel making the Tier 3 never-unify rule visible, amber-themed mermaid. PR #2 was mis-based on the content branch and never reached `main` — #3 carried it across |
| 2026-07-22 | steel | Registry drift swept (PR #14): course-lab live URL in `projects/index`, two stale "(private)" labels. None are Tier 1 fields, so `drift-check.ps1` never saw them — the gap is that spoke-card metadata has no mechanical check |
| 2026-07-24 | steel | Session started |
| 2026-07-24 | course-lab | PLAN-course-lab-transformations-ptr executed (PR #16): `transformations-ptr` — three PTR rounds + trap-round reconcile, producer round, earned sandbox. Registry row failed the guard first; 31/31 + clean build; scripted-browser pass (Playwright fallback, extension down) on the exact 11-event sequence with silent sliders; live in production. Screenshots caught one real defect — the Plane clamped out-of-range y and drew a flat line along the frame — fixed to clipping in the same PR |
| 2026-07-24 | steel | Depth criteria written ([[../wiki/depth-criteria]]) before any student data exists, so the thresholds are judgment rather than post-hoc fitting: round-2 miss band 40–75%, a third of reconciles naming the mechanism, rounds 1/3 ≥ 70% against a low round 2, producer median 2–4 retries with ≤ 25% ghost path. Any one of four failure shapes sends build one back instead of starting build two |
| 2026-07-24 | steel | Two-course rulings landed in vault truth: `wiki/decisions.md` (R3F has no fall surface / creative-lab stays live; fewer-deeper + first-student-data-is-a-gate), `initiatives/edgeex-build-family.md` refreshed to the gated two-build slate, this sprint doc's goal line + priority stack + focus list de-staled |
| 2026-07-24 | portfolio | P3 closed: `docs/dilations-card-copy` was already merged upstream as PR #12 — the branch was stale locally, not unfinished. Synced master and pruned ten fully-merged local branches; portfolio is clean on master with no parked work |
| 2026-07-24 | course-lab | `beatId` dual-semantics note written on the schema (PR #17), closing a crumb outstanding across several sessions: constant phase marker on single-check stages vs. true discriminator where several checks share a roundId+guideState. Analysis groups by roundId+guideState+beatId, never beatId alone — which matters now that the depth criteria read producer retries off that log |
| 2026-07-24 | steel | **Client-side stays** ([[../wiki/decisions]]): course-lab keeps `localStorage` + memory fallback; NOT-DOING a backend. studio-coach's Convex was required by RAG and by plan-gating at the query projection — course-lab has no server-side logic to protect, and client-side buys no district data agreement, no auth surface, no PII off the Chromebook. Two named triggers reopen it: collection fails in a real class period, or a second teacher adopts course-lab |
| 2026-07-24 | steel | **Gate-blocking open item recorded** ([[../wiki/depth-criteria]] §OPEN): the four depth signals read across a class, but events live per-browser under `course-lab:events` and there is no written protocol for collecting ~40 Chromebooks. Named risk — on shared/wiped school profiles `localStorage` can be blocked, the memory fallback then loses the session silently at tab close, so the one dataset authorizing build two is the most exposed. Closeout = a written protocol plus one DEMO01 dry run; deliberately not designed this session |
| 2026-07-24 | steel | Derived-not-transcribed rule extended to tooling paths (`ops/claude.md` Documentation): the transformations-ptr plan carried a stale Playwright executable path while `~/.claude/CLAUDE.md` had it right — same failure mode as hand-typed git state. Paths get referenced from the convention, never pasted into a plan. No plan template exists, so the rule has one home. Executed plan docs left untouched as historical record |
| 2026-07-25 | steel | Session started |
| 2026-07-25 | steel | Context-rot audit. Six-course framing swept from four live docs (`index.md` north star, `wiki/ecosystem-map`, `initiatives/index`, `initiatives/course-lab-production`); the initiative doc was frozen at 07-18 and still listed the shipped plan set as remaining. Sprint doc's Per-repo status de-staled to match its own priority stack (it still said "execute PLAN-course-lab-transformations-ptr" and "portfolio parked"), session-log table un-fragmented. **The two operator-only gate-blocking items — school-network check and collection protocol — promoted from a spoke card's Status block to live focus items 8–9**: the focus list had been seven struck-through entries and no live action, eight days from the first day of school |
| 2026-07-26 | steel | Session started |
| 2026-07-26 | course-lab | **Focus item 8 closed** — school-network check passed on a district Chromebook (site loads, module runs). No custom domain needed. Item 9 (collection protocol) untested during the same visit and is now the sole gate-blocking item |
| 2026-07-26 | course-lab | Storage health shipped (PR #18): `TelemetrySink.persistent` set by a real probe round trip — presence is not persistence, since Chrome hands back a `localStorage` object on a wiped profile and throws on use, and a store can also accept a write and silently drop it. Picker + start gate render the answer (`role="alert"` when blocked, worded at the student). Export filename carries the student code. 35/35, scripted-browser pass at 1366×768 in both states. This turned [[../wiki/depth-criteria]]'s "Named risk — the failure is silent" from a procedural problem into an observable one |
| 2026-07-26 | steel | Collection protocol written ([[../wiki/collection-protocol]]), closing depth-criteria §OPEN. **The finding that shrank it:** §OPEN assumed one collection problem; there are two independent paths. Signal 2 (reconcile prose — the only signal needing human reading) is assembled by `useSessionReport` from React state and travels by clipboard, never touching `localStorage`, so it survives a fully storage-blocked device; signals 1/3/4 want the CSV but also arrive in prose on the same paste. The clipboard path is a floor the gate stands on even if every device blocks storage. Dry run in the building is the only item left |
| 2026-07-26 | steel | Governance layer scoped to what is still alive (PR #23, net −152 lines): `.hub` pipeline **deleted not installed** — it generated geometry facts into six repos, two without geometry, and never ran in a single spoke (`SKIP` 6/6 on every drift check ever run). `.cursor/rules/steel-hub.mdc` rewritten — it was `alwaysApply:true`, pointed at an archived sprint, and carried a dead "Through June 28: freeze repo structure." sync-registry scoped to the three dormant geometry spokes with course-lab deliberately excluded; drift-check, its skill, and session-start now all state a PASS says nothing about course-lab. Two ISTE research docs archived. Drive-by: a pre-existing red test that asserted a literal spoke count of 4. 25/25 Pester (was 24+1 fail), drift 22/0 |
| 2026-07-26 | steel | Reconcile calibration set written (PR #24) — 15 pre-sorted samples closing depth-criteria Signal 2's one soft spot: the only signal that is a judgment rather than a number, exercised once, alone, with no worked examples. Three rulings carry it, the load-bearing one being **a memorized rule is not a mechanism** ("a plus inside does the opposite" → Restates). Distribution lands at exactly 33.3%, on the threshold on purpose |
| 2026-07-26 | course-lab | Shell painted (PR #19) + `docs/design-brief.md` written — the constraints a general design tool can't know (1366×768 Chromebook, projector-legible, no webfonts on a district network, no new deps, light theme always). Governing rule: **the shell must not compete with the module**, whose palette carries meaning. Teacher controls moved behind a disclosure — a student could previously click "Clear device telemetry" from the same paragraph they pick a module in. 10/10 scripted-browser checks at 1366×768, 35/35 unit. Measuring beat eyeballing: the UA's 8px body margin plus a `100vh` child is 16px of guaranteed scroll, which put the teacher strip below the fold |
| 2026-07-31 | steel | **First day of school confirmed: 2026-08-10** (Monday, nine days out) — closing the sprint header's last unknown. The runway is now a countable number rather than "mid-August" |
| 2026-07-31 | steel | `initiatives/issue-ledger.md` opened — the intake layer the other five initiatives all start *after*. Sized against the binding constraint the operator confirmed this session: **two Algebra II/III preps AND the technology-facilitator role are live simultaneously**, which rules out a solicited district-wide envelope. Three conflated questions separated (supervisor's district pulse → read incidentIQ, already logging it; the operator's solve-count → passive arrivals; pedagogical depth → his own two preps). **Key collapse: three of the four depth lenses are already instrumented by [[../wiki/depth-criteria]]** — `reveal_earned` uptake is the gamification question, ghost-path rate + PR #18's storage probe is the equity one, round-2/reconcile is engagement-as-thinking. Only personalization lacks an instrument, and it is both the most expensive to build and the most likely to be covered by EdgeEx. The depth year is a CSV read through four lenses, not four workstreams |
| 2026-07-31 | steel | Account topology resolved: the **IPSB New Teacher Tech Station** (delivered 2026-07-29, `answers.json` + 29 district-leadership review items) lives on the Claude for Teachers account and is **not on this machine** — depth-9 filesystem sweep found only the generalized skeleton at `personal/new-teacher-tech`, with every file renamed on extraction. It is a **living system with a supervisor stakeholder**, not a closed record: she has asked to reuse it as a running pulse on district tech across the year. Steel holds the pointer only — both projects independently forbid transcribed counts (steel: *derive state*; Tech Station: *never state a count from memory, run `make status`*) |
| 2026-07-26 | — | Fixed `~/.claude/hooks/check-pr-base.js`: it resolved the default branch in the hook process's cwd (steel → `master`) rather than the guarded command's directory, so it blocked the correct `--base main` in **every** spoke and only passed in steel. Now parses a leading `cd <dir>`, falling back to the payload cwd. Six cases verified — still blocks a genuinely wrong base in both repos |
| 2026-08-03 | steel | Strategy session held **outside the vault** (mentor chat, no repo state changed). Build surface narrowed to **Algebra II, 50-minute block, one existing module, one door** — entered with "the entire math spectrum." Three rulings ratified ([[../wiki/decisions]] 2026-08-03); the second-door prescription held pending the load-bearing question. The geometry ruling was reopened on a verbal claim and re-closed by the v2 schedule inside one turn — **an artifact closed it, a sentence did not** |
| 2026-08-03 | steel | IPSB Tech Station debrief filed into [[../initiatives/issue-ledger]] (extension, not a new card). The chat-side card offered for the vault was **discarded**: it duplicated `project-handoff.md` while claiming to index it, and printed `make status` counts as prose — the exact defect its own body memorializes, three days after the rule against it was ratified. Minified hub build + `verify-min.py` carried in as a pending ruling; the second-adult trigger recorded as **not fired for course-lab** |
| 2026-08-04 | steel | **Item 8 scoped, not reversed — the room is moving into the community college and the live network is unidentified** (new item 8b, which now gates the `DEMO01` dry run). The 2026-07-26 check passed on district wifi at the old building; nine days later it was still being read as "the school network works," including the conclusion that the custom-domain/DNS branch is dead. Both are correct *for the network they were observed on* and neither transfers. `collection-protocol` gains §Which network, a step 0 on the dry run — **name the network before starting** — and the network question at the top of Facts-to-confirm. Reverses this session's own earlier ranking: running the dry run on an unnamed network scores a PASS that cannot be reused, so slipping past Tuesday is now the cheaper error. General rule: **a network result is only as portable as the network it was observed on** |
| 2026-08-03 | steel | **Audit of mentor-chat output, filed as a session in its own right.** Three defects caught before anything reached a decisions file: stale paste targets (`sprint/2026-iste-40d.md`, `projects/public-identity.md` — neither exists), an IPSB card proposed for a slot [[../initiatives/issue-ledger]] already occupies, and the counts violation above. A fourth was caught in the *other* direction: the chat "corrected" 2026-07-31 to 2026-08-03 and would have falsified three good sprint rows — the notebook and the transcript both say separate sessions. **Every file path in that briefing is untrusted; its rulings and evidence status are not.** The auditing agent also mislocated M1–M3 in course-lab, a repo the founding spec forbids from containing R3F — same failure one layer up, so the auditor is not trusted over the repo either |

---

## Explicitly out of scope (this sprint)

- ISTE 27/28 planning (deferred indefinitely, revisit winter)
- Guide-dependent pacing/assessment work — blocked until EdgeEx student/teacher guides release
- Monorepo / shared packages
- New studio-coach features (spoke stays registered, no sprint work)
- Post-ISTE portfolio System graph (still specced, still deferred)
- **Rebuilding `course-lab/family-coverage.md`** — one dated header note, not a renovation
- **The Fable standards-mapping audit as originally scoped** — 29 units × 6 courses died with the shrink; only the `systems-ptr` / `predict-test-reconcile` citation question survives
- **A third transformation family in transformations-ptr** — depth goes into student data, not features
