# PLAN-course-lab-deploy

**Repo:** `course-lab` (`C:/Users/rplap/OneDrive/Desktop/personal/course-lab`) — GitHub `Lokie-ree/course-lab` (private)
**Verified starting state (2026-07-11):** `main` clean; `npm test` 10/10; `npm run build` produces `dist/` (gitignored); no deployment exists ("Live: —" on the hub project card). Vite config is stock (`vite.config.js`, 6 lines, `base` unset = `/`).
**Deadline anchor:** production surface "decided before August" (hub project card line 5). Students arrive August 2026.
**Branch:** repo config changes (README) go on `docs/deploy-url`; the deployment itself is dashboard/CLI work, not commits.

## Goal

Put the module picker on one stable HTTPS production URL so (a) students can reach it in August, (b) real-device testing (school network, school Chromebooks) can start now. **Default surface ruling: Vercel static deploy** — Randall already operates on Vercel, the repo is a stock Vite static build, free tier suffices. If Randall vetoes Vercel, stop and surface the decision; do not silently pick another host.

## Files

- No code changes. Assert `vite.config.js` keeps `base` unset (`/`).
- Modify: `README.md` (Live URL + teacher data-collection paragraph)
- Modify (hub): `C:/Users/rplap/OneDrive/Desktop/steel/projects/course-lab.md` line 5 (`**Live:**` field)

## Steps

- [ ] **1. Pre-flight:** in the repo, run `npm run build` — expect a clean build ending in `✓ built in …`. Then `npm run preview`, open the printed URL, confirm the picker renders and one module loads behind the StartGate with `TEST01`. Stop the preview.

- [ ] **2. Deploy via the Vercel dashboard** (preferred — buys auto-deploy on every merge to `main`):
  1. vercel.com → Add New… → Project → Import Git Repository → authorize GitHub access to `Lokie-ree/course-lab` if prompted (it is a private repo; the Vercel GitHub app needs explicit access to it).
  2. Framework preset: **Vite** (auto-detected). Build command `npm run build`, output directory `dist` — accept the detected defaults, change nothing.
  3. No environment variables. No `vercel.json` — a single-page app with no client-side routing needs no rewrites.
  4. Deploy. Record the production URL (`https://<project>.vercel.app`).
  5. Project → Settings → Deployment Protection: ensure the **production** deployment is publicly reachable (students have no Vercel accounts). Preview deployments may stay protected.

  *CLI fallback if the dashboard is unavailable:* `npx vercel@latest login`, then `npx vercel --prod` from the repo root and accept detected defaults. Note: the CLI path does not set up auto-deploy on push; prefer the dashboard.

- [ ] **3. Verify on the production URL** (not a preview URL): picker renders over HTTPS; StartGate admits `TEST01`; after a couple of actions, DevTools → Application → Local Storage shows `course-lab:events` rows; the CSV export button downloads.

- [ ] **4. README:** on branch `docs/deploy-url`, add under the title: the production URL, plus a short **Teacher: collecting data** paragraph stating that telemetry lives in each device's localStorage, so the CSV export runs **per device** — students click Export and turn in the file, or the teacher exports at each machine (centralizing is the NOT-DOING backend-sink trigger, spec §6). Commit `docs: record production URL + per-device data collection note`, push, PR, self-merge.

- [ ] **5. Hub card:** in the steel vault, update `projects/course-lab.md` line 5 `**Live:**` with the URL and date-stamp the Status block ("deployed to Vercel YYYY-MM-DD; auto-deploys from main"). The steel vault forbids committing unless asked — leave the edit uncommitted for Randall.

- [ ] **6. Operator checklist — hand to Randall, do not skip:**
  - Open the production URL **from a school device on the school network** before August; district filters commonly block `*.vercel.app`. If blocked, the fix is a custom domain (Vercel Settings → Domains) — surface it, don't improvise.
  - Do **NOT** give students the URL until PLAN-course-lab-roster-swap has landed — the roster still admits only `TEST01`/`TEST02`.

## Edge cases a weaker model would miss

- **localStorage is per-origin.** Every Vercel *preview* deployment gets its own URL and therefore its own empty telemetry store. Students must only ever use the one production URL, or events scatter across origins and exports silently miss data. Say this in the README paragraph.
- **`crypto.randomUUID` requires a secure context.** The StartGate calls it on Start. HTTPS production is fine; but this is why "run `npm run dev` on the teacher laptop and have students hit `http://192.168.x.x:5173`" is NOT an acceptable fallback surface — it throws `TypeError` on the Start click for every student.
- **Auto-deploy changes the versioning stakes.** Once merges to `main` ship straight to students, spec §4.6 becomes operational: bump `MODULE_VERSION` on any pedagogically meaningful change, and `roundId`s stay append-only — otherwise cross-version joins in the collected CSVs break.
- Do not set `base` in `vite.config.js` to a subpath — that is GitHub-Pages advice and would break asset URLs on Vercel.
- Deploying a **private repo** publicly is intended: the app carries no student names, codes are opaque, privacy surface ≈ zero (spec §4.6). Do not "fix" this with auth.
- `dist/` is gitignored; never commit it. Vercel builds from source.

## Acceptance criteria

- One production HTTPS URL serves the picker; a module completes a full StartGate → action → localStorage-row → CSV-export loop on that URL.
- Pushing a trivial merge to `main` triggers an automatic production deploy (dashboard shows the build).
- README PR merged with URL + per-device collection note; hub card Live field updated (uncommitted).
- Operator checklist delivered with the two named gates (school-network check, roster gate).

## Explicitly out of scope

- Custom domain purchase (only if the school filter forces it — operator decision).
- Backend sink, dashboards, auth (NOT-DOING §6).
- Swapping roster codes (PLAN-course-lab-roster-swap).
