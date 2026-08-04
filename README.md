# steel

A workflow-governance hub for six repositories, built as an Obsidian vault.

Not a notes folder. The markdown here is the coordination layer for a solo developer's
codebase: an append-only decision log, one card per repo, a cross-repo drift checker with
its own test suite, and a contract that AI coding agents load automatically at the start
of every session.

**Operator:** Randall LaPoint, Jr. — high school math teacher and district technology
facilitator. The repos steel governs are classroom software, and the north star is a real
room: two preps, Algebra II and Algebra III, in the 2026–27 school year.

---

## Why a hub exists at all

Six repos, one person, and the same facts written in six places — module names, standards
citations, deployed URLs, a triangle's coordinates. Those drift silently, and the drift is
only discovered in front of students.

The first attempt at solving this was an "AI co-founder" agent crew meant to keep strategy
grounded in the actual codebase. It never ran. What replaced it is this: markdown, a
PowerShell module, and Pester tests. The problem was real; the framework was not the
answer to it. That story is in [`wiki/journey.md`](wiki/journey.md).

---

## What's in here

| Path | What it holds |
|---|---|
| [`CLAUDE.md`](CLAUDE.md) | The agent contract — loaded automatically in any session where this vault is in the workspace |
| [`index.md`](index.md) | Vault map and session protocol (the operator's entry point) |
| [`wiki/decisions.md`](wiki/decisions.md) | Append-only architecture decision log. Entries are never edited; corrections land as new entries |
| [`wiki/patterns.md`](wiki/patterns.md) | Patterns harvested from seventeen repos of prior work |
| [`projects/`](projects/index.md) | One card per governed repo — paths, stack, status |
| [`sprint/`](sprint/index.md) | The current working window and a session log |
| [`initiatives/`](initiatives/index.md) | Forward direction; future sprints get cut from these |
| [`ops/`](ops/index.md) | `drift-check.ps1`, `repo-state.ps1`, and `lib/HubContext.psm1` — the logic, with Pester tests in `ops/tests/` |

---

## Three rules that earned their place

Each of these exists because something went wrong first. They are the transferable part.

**Derive state, never transcribe it.** Git state — branch, ahead/behind, dirty — is never
written into a doc as prose. It is produced by running `ops/repo-state.ps1` at read time.
A hand-typed fact about a live system is stale the moment it is written, and the reader
trusts the document. The same rule later caught a stale tool path in a plan, and a network
check that had been recorded without naming the network it ran on.

**Extend, don't create.** Before adding a doc, audit what already covers the ground. A new
file has to state, in one sentence, the gap no existing doc covers. This README's gap: the
vault's own entry point is written for Obsidian and for agents, and its links don't render
on GitHub.

**Claims close on artifacts, not sentences.** A ruling gets reopened by a document, a test
run, or a screenshot — not by someone saying it should be. Applied to AI agents working in
this repo, and to the operator.

---

## Reading this on GitHub

The vault is Obsidian-native, so most internal links are `[[wikilinks]]`, which GitHub
renders as literal text. Links in *this* file are ordinary relative links and work here.
For everything else, clone it and open the folder in Obsidian.

---

## Scope

This repo is public and contains no student information — no names, no identifiers, no
per-student records, and nothing pseudonymous that could be re-identified. Classroom
software governed from here stores what it collects on the device, and the projects
described here describe needs generically. That line does not move.

Everything in here is one person's working system, published because the practice is
worth more than the notes. It is not a template, and it is not advice.
