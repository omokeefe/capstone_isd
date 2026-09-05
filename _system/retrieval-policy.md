# Retrieval Policy

How to find things in this workspace, and where each retrieval mode is actually served.
A baseline test (below) confirmed these paths work well cold — keep this policy in sync
if a future reorg changes where things live.

## Known-item retrieval (you know roughly what you want)

Start from `CLAUDE.md` → the relevant top-level folder from
`_system/workspace-map.md` → grep within it. For a specific source, bib key, or rating,
`evidence/source-register.md` is the fastest single lookup — it indexes everything else.

## Contextual retrieval (everything relevant to a project or decision)

Start at `projects/nas-sos-capstone/index.md`, follow its links to
`decisions/decisions-log.md` and `knowledge/questions/open-questions.md`. This chain is
deliberately short — if assembling context for a decision takes more than 3-4 file reads,
something in the chain is missing a link back to this file; fix it rather than accepting
the scatter.

## Associative retrieval (adjacent, conflicting, or analogous ideas)

Less structurally supported than the other three — currently found via grep across
`knowledge/models/` (stakeholder personas name conflicts explicitly, e.g. the
trajectory-vs-throughput tension) plus `projects/nas-sos-capstone/to-do-list.md`'s §7-§9
sections, which name planned conflict-analysis work even before it's done. As
`knowledge/claims/` fills in with real claim notes, this should get faster — a claim
note's "related claims" and "contradicting evidence" fields are the intended mechanism.

## Exploratory retrieval (you don't know what you're looking for yet)

Start at `evidence/source-register.md` (indexes every source by topic-adjacent to-do
section) or `knowledge/concepts/glossary.md` (indexes terms). Both are designed to make a
loosely-remembered topic discoverable without knowing the exact filename in advance.

## Baseline (2026-09-05, pre-reorg structure)

Four cold Explore-agent runs, no prior context, real questions:

| Mode | Tool calls | Result |
|---|---|---|
| Known-item (Cinar duplicate bib key) | 4 | Clean, dated, unambiguous |
| Contextual (D-001 pivot decision) | 8 | Tight chain, no scattering |
| Associative (trajectory-vs-throughput) | 9 | Explicitly framed, found via stakeholder-personas.md |
| Exploratory ("something about digital twins") | 6 | Found via source-register.md index in one pass |

Re-run periodically (e.g. at a maintenance review) and compare tool-call counts — a
regression means a pointer chain broke somewhere.
