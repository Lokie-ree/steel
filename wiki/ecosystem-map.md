# Ecosystem Map

Four repos, one pedagogical arc, two visual languages.

```
                    ┌─────────────────────────────────┐
                    │           steel (hub)            │
                    │  sprint · sync-registry · ops    │
                    └───────────────┬─────────────────┘
                                    │ coordinates
          ┌─────────────────────────┼─────────────────────────┐
          ▼                         ▼                         ▼
   ┌──────────────┐          ┌──────────────┐          ┌──────────────┐
   │ creative-lab │          │   iste-26    │          │  portfolio   │
   │  (canonical) │─────────▶│  lab guides  │          │  the door    │
   │  M1 M2 M3    │  URLs    │  print-style │◀─────────│  previews    │
   └──────────────┘          └──────────────┘  System  └──────┬───────┘
          │                         grid                      │
          │                                                     │ Live Demo
          │                                                     ▼
          │                                            ┌──────────────┐
          └───────────────────────────────────────────▶│ demos (CSE)  │
                     same pedagogy, different code     │  standalone  │
                                                       └──────────────┘
```

## Layer model (portfolio System section)

| Layer | Repo | Audience |
|-------|------|----------|
| Interactive | creative-lab | Students manipulate geometry |
| Lab Guide | iste-26 | Teachers + students reflect (predict / sketch / synthesize) |
| Live Demo | creative-lab-demos | Visitors sample CSE before reading |
| Door | portfolio | Educators experience then understand |

## Dependency rules

1. **creative-lab wins** on module behavior, round structure, earned reveals
2. **iste-26 wins** on printable teacher implementation notes and discovery log prompts
3. **portfolio wins** on professional narrative and preview choreography
4. **demos wins** on CSE interaction logic (`classifyShape`, completion gates)

## What steel adds

Repos don't know about each other. Steel holds:

- Which repo to open for a given task
- What must stay aligned ([[../sync-registry]])
- What's in flight ([[../sprint/2026-iste-40d]])

## Research layer (not in diagram)

`iste-narrative.md` and `iste-alignment-findings.md` inform conference conversations. They do not drive code. See [[../index#Research boundary]].
