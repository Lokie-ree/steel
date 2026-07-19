# iste-outreach-tracker

**Identity:** Single self-contained HTML file (`iste-tracker-final.html`, 771 lines): a personal CRM tracking outreach to ~11 ISTE 2026 presenters (Tier 1/2/Backup, status, handles, notes). Not a git repo; file dated 2026-05-06. **Finished single-use tool.**
**Stack:** Zero-dependency vanilla HTML/CSS/JS; `localStorage` persistence (`iste26_tracker_data`); OKLCH dark-amber theme via CSS custom properties.
**Patterns worth keeping:**
- **Seed-data + localStorage overlay** — static seed object, `initializeData()` hydrates from localStorage or falls back to seeding (`iste-tracker-final.html:614-630`). Clean no-backend persistence for small personal tools; same family as course-lab's sink work.
- Transient save-indicator UX — `showSaveIndicator()` flashes "Saved" 2s on mutation (`:643-647`).
- OKLCH design-token palette (`:root`, `--color-amber` …) — reusable single-file theme.
**Dead ends & lessons:** None — does one thing and stops.
**Verdict candidate:** **close** — event-specific and done; keep the OKLCH palette + seed/localStorage snippet as reference.
