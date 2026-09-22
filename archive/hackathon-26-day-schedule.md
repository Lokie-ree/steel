# 26 Days — Convex All Gas build schedule

> **Closed 2026-09-22. Submitted 09-20, and results are due 09-25.** This doc is now record and is not maintained. Gate outcomes live in [[initiatives/public-identity]] §Outcome, and the project pointer is [[projects/still-true]]. If a future hackathon reuses this schedule's shape (weekend blocks, a cut list written before the build, a working deadline two days early), copy that shape into the new event's own schedule. Don't reopen this one.

> **The product is defined in `still-true/hackathon.md`, not here** (ruled 2026-09-02). That
> file is the build log, it is scored by the judges, and it is the single source for what the
> thing does, what is built, and every decision including the reversed ones. **This doc owns
> the calendar, the gates and the cut list** — the operator-facing constraints that have no home
> in the repo. When the two disagree about the product, the repo wins; do not re-describe the
> product here beyond what a schedule needs.
>
> The vault's second copy of the product definition was archived for exactly this reason:
> [[archive/hackathon-vault-handoff]], superseded twice in three days while nobody was reading
> it. Priority lives in [[archive/2026-first-contact]]; the release gate in
> [[initiatives/public-identity]].

**Hard deadline:** Tue Sep 22, 12:00 PM PT = **2:00 PM our time**.
**Working deadline:** **Sun Sep 20, evening.** You are teaching Tuesday morning. Anything that depends on Monday night or Tuesday morning does not exist.

Everything below is built around one fact: you have a full-time job and two extra roles. The build gets weeknight scraps and four weekend blocks. Schedule the hard problems into the blocks, never into a Tuesday night.

**Realistic budget:** ~17 hours of weeknights, ~40 hours across four weekends, plus a free Labor Day. Call it 65 hours. That is enough for this scope and not a minute more, which is why the cut list is written before the build starts and not during it.

---

## Block 0 — Thu Aug 27 → Sun Aug 30
### Prove the risky part before committing to it

| Day | Work | Time |
|---|---|---|
| Thu 27 | Confirm Luma registration. Run the hackathon setup prompt. Repo created, `hackathon.md` scaffolded. Stop there. | 45 min |
| Fri 28 | Unit 1 review is your day. Evening: write the one-page spec — the four demo shots, nothing else. | 45 min |
| **Sat 29** | **The spike.** No UI, no schema design, no polish. Crawl a page with Firecrawl → store it → crawl a changed version → detect the difference → send an email through AgentMail. Hardcoded and ugly is the goal. | 5–6 hrs |
| Sun 30 | Finish the spike or call it. If it works, write down where it breaks. If it doesn't, this is your one free pivot day — take the fallback. | 3–4 hrs |

**Gate, Sun 30, 9 PM.** *Can a change on a source page trigger an email, end to end, ugly?* Yes → proceed. No → drop to the no-inbox fallback and re-plan Monday. Write the answer down either way.

This is deliberately front-loaded. The staleness flip is the shot the entire video exists for. If it can't work, you need to know on August 30 with 23 days left, not on September 15 with 7.

---

## Block 0.5 — Mon Aug 31 → Tue Sep 1
### The dry submission, which this document did not have

Reconciled 2026-08-30. `sprint/2026-first-contact.md` carries this at **priority 0** and it is
the first row of the release gate in `initiatives/public-identity.md`. Neither this schedule
nor the gate table mentioned it, so the earliest deadline in the project was the one the
working docs were blind to.

**The test is not the app, it is the pipeline.** Multiple submissions are allowed by the
rules, so an early bad one costs nothing and retires the only failure mode with a precedent
in the archaeology. Content quality is explicitly not what is being checked.

| Day | Work | Time |
|---|---|---|
| Mon 31 | Repo pre-flight, then flip it public. Convert the anonymous Convex deployment to a real cloud project and deploy the board to `convex.site`. Social post #1, already scheduled for today. | 90 min |
| Tue 1 | Record 90 seconds of the staleness flip. File the vibeapps form. Then stop — do not start improving it. | 60 min |

**Pre-flight before the repo goes public.** The vault's founding convention makes public a
deliberate choice, so it gets a checklist rather than a toggle.

- **Secrets:** verified clean 2026-08-30 — `.env.local` untracked, no key material in any ref.
  Re-run the scan after any commit made between now and the flip.
- **Vendored third-party files:** 41 tracked files under `.agents/` plus the Convex hackathon
  skill under `.claude/`, none carrying a LICENSE. They regenerate with
  `npx convex ai-files install`, so untrack and gitignore them rather than republishing
  someone else's files under your name. It also shrinks what a judge browses.
- **Seed data stays synthetic**, and obviously so. The library in the current seed is invented;
  keep it plainly invented rather than plausibly real.

**Deploy gotcha, same class as the Firecrawl one and it will bite in exactly the same way:**
deployment environment variables do not travel. The Firecrawl and AgentMail keys are set on the
anonymous local deployment only. Set them again on the cloud deployment or every action fails
in production while working perfectly on the laptop.

**Settled 2026-08-31 by the deploy itself: the live URL is `*.convex.site`.** Monday's deploy
returned `https://impressive-marten-163.convex.site`, and it serves the board.

The 2026-08-30 correction — that static hosting publishes to `*.convex.app` and `convex.site` is
only the HTTP-actions domain — is **withdrawn**. It described a different mechanism than the one
this project uses. `still-true/convex/convex.config.ts` mounts the static-hosting component *on
the HTTP router* (`app.use(staticHosting, { httpPrefix: "/" })`), so the site is served from the
HTTP-actions domain by construction. Both statements can hold for different hosting paths; only
one describes this build.

The four places that recorded `convex.site` were right all along, including the release-gate row
in `initiatives/public-identity.md` that P0 is measured against. The correction is what needed
unwinding, not the original record. Lesson for the remaining gates: a served capability doc
describes the product, the repo's own config describes *this* deployment, and where they
disagree the config wins.

Two more things the same doc makes clear, both of which need the operator's own hands: claiming
the anonymous deployment into the cloud is an interactive sign-in, and publishing runs through a
moderation gate as a privileged action — an agent never holds the deploy key. Budget for a human
in the loop rather than a scripted deploy.

**Gate, Tue Sep 1.** *Is anything filed on vibeapps?* Not "is it good." Write the answer down.

**Answered Tue Sep 1: NO — deliberately.** Nothing was filed. The board was seeded and the
deploy verified, but the build is not demo-ready: the only footage available would have been
two invented gists and a hash comparison run by hand, and it would have been discarded at the
first real rebuild. The rules allow multiple submissions, so deferring spends nothing. The
failure mode this gate exists to retire is *never submitting*, and that risk is unchanged as
long as the real submission stays on schedule.

---

## Amendment — 2026-09-01: the claim changed, and Blocks 1–3 have not caught up

Two findings, in order.

**Nothing watches anything.** Editing a watched page produced no change on the board, because
nothing invokes `spike:check` — no cron, no scheduled function, no HTTP route anywhere in the
project. A watched page has no path to the database. Both seeded sources still carry an empty
`contentHash` and a `lastCheckedAt` equal to their insert timestamp, so no crawl has ever run
against production. This is missing work, not a regression: the scheduled re-crawl sits in
Block 2 below and was never written. But it means the product's central claim currently has no
implementation outside a hand-run spike.

**The hero claim changed.** From *flags answers stale when the source page changes* to **the
answer repairs itself**. The old shape hashes a whole page, so any byte that moves — a nav
tweak, a footer year — marks every answer on that source stale. The alerts become noise, and
the email can only say "re-verify," which hands back the exact labor the product exists to
remove. The new shape judges a change against the facts an answer actually depends on,
re-extracts the answer from the new page, and involves a human only when that cannot be
verified. Firecrawl's own `changeTracking` supersedes the hand-rolled hashing; repairs are
gated on a verbatim quote checked against the crawled text rather than on a confidence score;
and OpenAI enters the product for the first time.

**Read Blocks 1–3 below as history until further notice.** They are written against the
superseded claim — Block 1's gate asks only whether email in produces an answer out, and the
differentiator sits in Block 2 behind it. Under the new claim the order inverts. They are
deliberately **not** rewritten here, because the reordering depends on a research day that has
not been run: which Convex components carry the pipeline, whether an `httpAction` route can
coexist with static hosting mounted at `/`, and how `changeTracking` scopes its previous
scrape. Rewriting the plan before that lands would transcribe a decision nobody has made —
the same failure as writing derived state into a document.

The research day was called on 2026-09-01 for a stated reason: the project twice reached for
custom code where the stack already provides the capability — the hashing above, and a
crawl/extract/repair pipeline over four flaky third-party APIs written as loose internal
actions while no Convex component is in use. Its agenda lives in the `still-true` handoff note
and its output belongs in `hackathon.md`, which already carries the reframe as of this date.

---

## Amendment — 2026-09-02: the research ran, the domain changed, Blocks 1–3 rewritten below

The 09-01 amendment above said Blocks 1–3 stay unrewritten *until the research day lands*. It
landed, and it moved further than expected. Four direction questions were settled in one day,
three of them on evidence. The full record is in `still-true/hackathon.md`; the parts that
change this calendar:

**Two predeclared probes fired no decision rule, and both were recorded as no-fires.** Probe v1
coded a school-handbook corpus; an external assessment then found four method errors in it,
including a `GO` called on codes invented after seeing results. Probe v3 was committed *before
a single document was fetched* — taxonomy, expectation lists, all three thresholds — precisely
so that could not happen twice. It also fired nothing, and the reason is the finding: a keyword
sweep cannot assign `AMBIG` (*stated, but not in terms a person could act on*), which is the
distinction the entire product turns on. **The extractor is the instrument.** No further sweep
has information value, which ends the probing phase on evidence rather than on impatience.

**The front door changed: forward a document.** Not a page you curated — a lease, a
terms-of-service update, an insurance renewal that a stranger emails in as an attachment or a
link. The reply says what that document requires of them, every claim quoted from the source
with the line it came from, and says plainly where the document is silent and how many lines
it searched. CC it on a thread and the same cited reply lands in the thread.

**Why this and not the school build.** The corpus problem disappears. No handbook discovery, no
seed URLs, no curation, no hand-fixing — which was the single largest remaining risk on every
prior plan, and the thing the archived vault handoff spent four open questions on. Users bring
their own documents.

**Nothing built is lost.** The engine is domain-agnostic and the corpus is config: line-index
grounding, the PDF reflow pass, the TOC dot-leader filter, Firecrawl `changeTracking`, the
Convex cron, the reactive board, and AgentMail — now carrying two real jobs instead of one
bolted-on alarm. **The written STOP fallback:** if extraction on legalese proves unreliable in
Block 1, the identical code points at the Jefferson Parish handbook, where the omissions are
already found and quoted (`still-true/docs/probe.md`). The downside is bounded by work already
done, which is why this was safe to commit to on day 6.

**A public unauthenticated mutation was live on production for four days.** `npx convex dev` had
been pushing to a *local* deployment while reporting success every time, so P0's schema
replacement existed only on one machine and `answers:publish` stayed writable by anyone who
found the name. Now closed, verified from outside the CLI. The lesson is narrower than "verify
deploys": a success message from the tool you just ran is not evidence about the system you
meant to change.

**The hero claim is now grounding, not staleness.** The model never writes the answer text — it
returns **line numbers**, and the quote is pulled out of the source by index. The system cannot
display a sentence that is not in your document. That is a structural guarantee rather than a
prompt instruction, and it is what the Sep 13 video has to land. Staleness is demoted to the
third feature, on url-backed documents only.

---

## Block 1 — Wed Sep 2 → Mon Sep 7
### The core loop: document in, cited answer out

P0 is shipped — schema, read API, production deployment carrying no public writes. The ingest
path, extraction, the reply and the watch are not built.

| Day | Work | Time |
|---|---|---|
| Wed–Thu | One thing per night: AgentMail inbound webhook (signed, idempotent on `messageId`) · attachment fetch · Firecrawl parse with the reflow and TOC passes. | 60–90 min each |
| Fri 4 | Off. Actually off. | — |
| Sat 5 | **The extractor.** Constrained OpenAI call returning line indices and an explicit refusal verdict — never answer prose. Then the index lookup that turns indices into quotes, which is the guarantee. | 6–8 hrs |
| Sun 6 | Document in → cited reply out, end to end. Not pretty. | 5–6 hrs |
| **Mon 7** | **Labor Day.** The `not_stated` path: refuse to guess, count the lines searched, write it to the board. **Plus P1's exit measurement** — run the real extractor over probe v3's corpus, which is the measurement the keyword sweep could not take. | Full day |

**Gate, Mon 7, 9 PM.** *Can you forward a document to the address and get back a reply whose
every claim carries a quote and the line it came from?* If no, everything else stops until this
works. There is no version of this project that ships without it.

**Carried in from probe v3, unresolved:** the lease corpus is still untested — all three lease
fetches failed, including HUD's model lease at 15 chars. Leases are where omission was most
likely and are the more sympathetic demo. Resolve it Wednesday with a real PDF attachment
rather than a URL, since the attachment path is confirmed and the fetch path is what failed.

Labor Day is your only free weekday. It is slack, not a bonus.

---

## Block 2 — Tue Sep 8 → Sun Sep 13
### The two things nobody else demos

*"Summarize my contract"* is crowded. Three things separate this build and the video must show
all three: fabrication is **structurally impossible** rather than merely unlikely, it reports
**what the document does not say**, and it **keeps watching** after you have stopped caring.
Block 1 delivers the first two. This block delivers the third and makes all three legible.

| Day | Work | Time |
|---|---|---|
| Tue 8 | **Scope freeze** (release gate row 2). Write the feature list down and close it. | 30 min |
| Tue–Thu | The board: Convex live queries against `findings`, each cell showing the quote, the line, the date checked — or the refusal and its line count. Interface designed here (P3), not guessed at earlier. | 60–90 min each |
| **Sat 12** | The watch. Convex cron → Firecrawl `changeTracking` on url-backed documents → re-extract → the `previousAnswer` / `changedAt` diff → the change notice into the thread. | 8 hrs |
| **Sun 13** | Re-deploy. Then **record a rough three-minute video** of whatever exists. | 6 hrs |

**Gate, Sun 13, 9 PM.** *Is there a rough video, and does the citation shot land?* — not the
staleness shot. The shot is a claim in the reply, clicked, resolving to the exact line of the
source document.

The rough cut is non-negotiable and it will be bad. That is the entire point: it shows you, with
a full week left, which shot does not work yet.

---

## Block 3 — Mon Sep 14 → Sun Sep 20
### Harden, polish, ship

| Day | Work | Time |
|---|---|---|
| Mon–Thu | Fix **only** what the rough video exposed. No new features. The cut list is in force. | 60–90 min each |
| Sat 19 | **Run it against a document nobody chose.** Not the probe corpus — a real PDF handed over cold, which is the actual first-use case. Fix what real content breaks. Final video. | 8 hrs |
| **Sun 20** | **Submit.** Repo public · `hackathon.md` current · live URL open to strangers · video under 3:00 · form submitted · social posted. | 4 hrs |

**Gate, Sat 19, night.** *Does it survive a document you did not pick?*

**Mon 21 – Tue 22:** buffer. No new code.

---

## Standing rules

**One thing per weeknight.** If you are wrestling a hard problem on a Wednesday, you scheduled
it wrong. Move it to the weekend and do something small instead.

**Run `/hackathon` after every session.** `still-true/hackathon.md` is the single source of truth
for this project and it is what judges read. It is a scored artifact, not overhead.

**The cut list, decided now:** auth of any kind · multi-tenant onboarding · mobile layout ·
analytics · theming · document types beyond lease and consumer agreement · any interpretation,
advice or judgment about a document. The last one is a product boundary, not a scope cut: this
tool quotes and it counts, and it is not legal advice.

**Four gates, one yes-or-no question each.** Sep 7, Sep 13, Sep 19, plus the release-gate rows in
[[initiatives/public-identity]]. Answer them in writing. A gate you talk yourself past is worse
than no gate — and this project has now recorded two probes that fired no rule rather than
negotiating one, which is the standard to hold.

**Social proof is scored.** Three posts, not one: Aug 31 (done) · Sep 13 (the citation clip) ·
Sep 20 (launch). Tag @convex, @OpenAI, @firecrawl, @agentmail.

**The school-day promise wins.** If the build starts costing your students, the build loses.

---

## What kills this, ranked

1. **Beautiful and half-finished on Sep 22.** The most common hackathon death. The gates exist entirely for this.
2. **Finished with a bad video.** Second most common. The Sep 13 rough cut is the insurance.
3. **Reading as one more "summarize my contract" app.** Newly first-class after the pivot. Mitigated only by showing all three differentiators, and the video is where that happens or does not.
4. **A school week that eats a weekend.** One of them will. Labor Day is the reserve.
5. **Scope creep wearing polish as a disguise.** Anything not in the four shots is not work, it is avoidance.

---

## The four shots, for reference

Rewritten 2026-09-02 with the product. Every scheduling decision above serves these and nothing else.

1. **Forward a real consumer agreement** — AT&T's is 51,654 words, 3 h 37 m of reading, and people click *I agree* on it. A cited reply comes back.
2. **Click a claim → it resolves to the exact line of the source.** The model returned an index, not prose. Say out loud that fabrication is structurally impossible here, because that is the sentence the other document-summarizer demos cannot say.
3. **Ask something the document never says** — it refuses to guess and tells you how many lines it searched. The arbitration opt-out sitting at the 89th percentile of PayPal and Spotify is the fact that makes this land.
4. **The document at its URL changes → the specific thing you asked about moves, and you are told.** One sentence, no architecture diagram.
