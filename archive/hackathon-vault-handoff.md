# Convex All Gas — vault handoff

> **Archived 2026-09-02 — superseded, not closed on schedule.** This doc was written against a
> product that no longer exists: a monitor that watched public pages you curated and flagged
> answers stale. `still-true` pivoted twice after it was last edited — to self-repairing
> answers on 09-01, then to **the forwarded document** on 09-02. All four of its "open
> questions the vault exists for" are void: there is no seed organization (users bring their
> own documents), no crawl-first / gap-first choice, no owner receiving alerts. Its gate table
> tests a staleness demo that is no longer the demo.
>
> **The single source is now [`still-true/hackathon.md`](https://github.com/Lokie-ree/still-true/blob/main/hackathon.md)**,
> the build log in the repo, which is scored by the judges and better maintained than any vault
> copy was. The vault keeps the calendar and the gates in [[hackathon-26-day-schedule]] and
> the priority in [[../sprint/2026-first-contact]]; it no longer keeps a second copy of the
> product definition.
>
> **What was still true when this was archived**, and lives on in the schedule doc: the working
> deadline of Sun Sep 20, the Aug 25 eligibility floor, the everyday-app-not-developer-tool
> constraint, all four sponsors load-bearing, zero student data, and the four submission
> requirements. Read everything below as the record of a direction that was tested and dropped,
> not as current work.

---


Everything settled, everything still open, and the decisions the setup prompt is about to ask for.

---

## Locked. Do not spend vault time here.

- **Working deadline: Sun Sep 20, evening.** Official close is Tue Sep 22, 12:00 PM PT / 2:00 PM Central, and you are teaching that morning. Mon 21 and Tue 22 are buffer, not build time.
- **Nothing built before Aug 25 qualifies.** No adaptation, no dressing up. Zero.
- **Everyday app, not a developer tool.** Generators, meta-infrastructure, and anything `steel`-shaped scores low by the published criteria.
- **All four sponsors load-bearing.** Convex for state and live queries, Firecrawl for crawl and change detection, AgentMail as the front door, OpenAI for matching and extraction. If pulling one out doesn't break the app, it isn't earning its place.
- **Zero student data.** Not in the app, not in the repo, not in the video, not in a background shot.
- **Do not seed with your own district.** Public pages or not, a permanent public repo implying your employer's information is stale is not a risk worth taking. Same line you drew on LACUE.
- **Submission requires:** public repo · `hackathon.md` at root · live URL a stranger can open without a login · video ≤ 3:00.
- **Deliverables are the four demo shots.** Anything outside them is not work.

---

## Open. This is what the vault is for.

**1. The seed organization** — resolve by **Fri Sep 4**
Highest leverage question in the project. The answer-bank build on Sep 5 needs a real site with real messy pages. Domain-neutral reads as generic, and your only durable edge is knowing one domain from the inside. Candidates worth testing: city or parish government, state agency, public library system, university department, utility. Criteria: genuinely public pages, pages that visibly change, no employment relationship to you.

**2. Crawl-first or gap-first** — resolve with #1, same session
Two products in one system. *Crawl-first*: good public pages that rot, staleness flip is the star, demos beautifully. *Gap-first*: the answer was never published, the star is the unanswered-question register aging with a named owner — what you actually built by hand twice. You aren't picking the product, you're picking what the demo leads with. The seed org decides it.

**3. What counts as an "answer"** — resolve by **Fri Sep 4**
Fact, policy, number, date, deadline, contact? The tighter this definition, the better extraction works. A loose definition is exactly how this becomes a chatbot that says plausible things. Biggest risk after the spike, and it's a thinking problem, not a coding one.

**4. What the owner does with a stale alert** — resolve by **Fri Sep 11**
If the alert lands in a void, the loop isn't closed and judges will feel it without being able to name it.

**Not worth vault time:** the name, the UI, the architecture. They settle themselves once 1–3 are answered.

### Amendment — 2026-09-01: the hero claim changed

From *flags answers stale* to **the answer repairs itself**. A whole-page hash marks every
answer on a source stale whenever any byte moves, so alerts become noise and the email can
only say "re-verify" — handing back the labor the product exists to remove. What that does to
the four questions above:

- **#2 is largely settled toward crawl-first.** Repair only has meaning where an answer existed
  and the page moved under it; a gap-first register has nothing to repair. #1 still decides the
  seed org, but it no longer decides the product.
- **#3 gets a sharper definition for free.** An answer is one that carries a **verbatim
  supporting sentence** from a live page. That is not a style preference — the repair gate is a
  check that the model's quoted evidence actually appears in the newly crawled text, so an
  answer without locatable evidence cannot be repaired or published. This is the direct defense
  against becoming a chatbot that says plausible things.
- **#4 changes shape and gets easier.** The owner mostly receives *"this changed, the answer was
  updated, no action needed"* — a notification, not a task. The alert-into-a-void problem shrinks
  to the minority case the system could not verify, which is where a named owner genuinely earns
  their place.
- **The Sep 13 gate wording is superseded.** "Does the staleness shot land?" was the right
  question for the old claim. The shot is now the answer rewriting itself with a new verified
  date and the old value still visible.

Still open, and now the sharpest question in the project: **what triggers a re-crawl, and where
does it live?** Nothing invokes the crawl today — no cron, no scheduler, no route. A research
day was called 2026-09-01 to answer that, along with which Convex components carry the pipeline
and how Firecrawl's `changeTracking` scopes its previous scrape.

---

## The gates

One yes-or-no question each, answered in writing. A gate you talk past is worse than no gate.

| When | Question |
|---|---|
| **Sun Aug 30, 9 PM** | Can a change on a source page trigger an email, end to end, ugly? *No → drop to the no-inbox fallback and re-plan Monday.* |
| **Tue Sep 1** | Is anything filed on vibeapps? *Not "is it good."* |
| **Mon Sep 7, 9 PM** | Can you email the address and get back an answer with its source and date? *No → everything else stops until this works.* |
| **Sun Sep 13, 9 PM** | Does a rough three-minute video exist, and does the staleness shot land? |
| **Sat Sep 19, night** | Does it survive real seed data? |

**The Sep 1 row was missing from this table until 2026-08-30.** It is priority 0 in
`sprint/2026-first-contact.md` and the first row of the release gate in
`initiatives/public-identity.md` — the earliest gate in the project was the one the working
docs did not carry. Requirements: public repo · `hackathon.md` at root · a live `convex.site`
URL · a 90-second video · the vibeapps form filed. Multiple submissions are allowed, so an
early bad one costs nothing and retires the only failure mode with a precedent.

**Gate 1 answered 2026-08-30: YES.** Verified end to end against a live public page — baseline
crawl stored a hash, an unchanged re-crawl matched it, a one-line edit produced a new hash,
flipped two answers to `stale`, and delivered an email confirmed sent in the AgentMail inbox.
Firecrawl and AgentMail are both live and load-bearing. No fallback needed.

Two constraints discovered, both now in `still-true/hackathon.md`: Firecrawl v2 serves cached
scrapes unless `maxAge: 0` is passed, and detection latency is bounded by the source page's own
CDN cache rather than by crawl frequency — which is a sentence the demo video should say out
loud rather than pretend away.

---

## Environment setup — decisions the prompt will ask for

Tonight is setup only. The prompt says explicitly: do not build, deploy, or commit the app. 45 minutes.

**Frontend host: choose `convex.site`.**
The prompt will ask. Reasons: it's the cross-agent path, it keeps hosting inside the same deployment you're already running, and `chatgpt.site` requires ChatGPT desktop or web for publication — an extra dependency and an extra failure point on the final weekend. It also defaults to private, meaning a judge could hit a login wall if you forget one toggle. Not a risk worth carrying into Sep 20.

Recorded in `hackathon.md` as: `Frontend: Convex static hosting`
Deploy produced, 2026-08-31: **`https://impressive-marten-163.convex.site`**. The 2026-08-30
`*.convex.app` correction is **withdrawn** — it described a different hosting mechanism. This
project mounts the static-hosting component on the HTTP router
(`app.use(staticHosting, { httpPrefix: "/" })`), which serves the site from the HTTP-actions
domain. The original `convex.site` record stands and the hosting decision was never in question.

**Expect a restart.** Convex integration and the hackathon skill may not load until the next session. That's normal. Don't let a restart-pending status read as a failed install.

**`hackathon.md` rules.** Event field exactly `Convex All Gas Hackathon`. No secrets, no tokens, no personal information. For you specifically: no student data and no district identifiers, ever, because this file goes public with the repo.

**`/hackathon` after every meaningful session.** Judges read that file. It is a scored artifact, not bookkeeping.

**Submit at:** https://vibeapps.dev/judging/convex-all-gas-hackathon-openai/submit

---

## The question to keep open

*Am I actually solving this problem, or the one I'm fluent in?*

Recognizing this problem instantly is earned. It's a strong signal about the problem and a weak signal about the solution. The failure mode when you build the thing you personally suffer from is optimizing for your own fluency instead of a stranger's first thirty seconds. Ask this again on Sep 13 when you watch the rough video back.
