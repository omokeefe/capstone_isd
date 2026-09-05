# Note Types

The smallest set of note types this workspace actually uses, inferred from existing
material rather than imposed from a generic template. Not every type needs every field
below every time — use judgment.

## Project index

`projects/nas-sos-capstone/index.md`. Answers: what outcome is being pursued, why it
matters, what's in/out of scope, current state, decisions made, what's uncertain, next
actions, and which knowledge/evidence/people/systems/artifacts are relevant. The single
file that should let you resume the project after months away.

## Concept note

`knowledge/concepts/glossary.md`. Defines an enduring term in this project's own words,
distinguished from neighboring terms. Currently one file with ~50 short entries, not
atomized — see `_system/maintenance.md` for when that would change.

## Model note

`knowledge/models/*.md` (stakeholder-register, stakeholder-personas,
candidate-systems-inventory, conops-scenarios, interface-exchange-draft). A durable,
structured representation of some part of the problem (stakeholders, candidate systems,
scenarios, interfaces) that architecture work draws on directly.

## Claim note

`knowledge/claims/`. Contains: the claim, scope/qualifications, supporting evidence,
contradicting evidence, confidence, interpretation, related claims, practical
implications, open questions. Create one only when a claim is important, contestable,
reusable, or evidence-dependent — not for every sentence. See
`knowledge/claims/README.md` for the current (empty) state and how to add the first one.

## Source summary

`evidence/literature-notes/summaries/<rating> - <bib-key>.md`. Fast triage: what the
source is, which project parts it serves, a 0-5 rating with justification, flags
(duplicates, unverifiable fields), read depth, date.

## Source annotation

`evidence/literature-notes/annotations/<bib-key>.md`. Deep field-by-field extraction
(actors, decisions, constraints, information flows, optimization variables,
local-vs-system conflicts) for a source actively feeding architecture or ontology work.
Distinct from a summary — a source can be fully summarized while still unannotated.

## Decision note

`decisions/decisions-log.md`, one `## D-00N` section per decision (single file, ADR
template at the bottom). Contains: decision, date/status, context, alternatives
considered, criteria/rationale, evidence used, consequences, and conditions that would
justify revisiting it.

## Question note

`knowledge/questions/open-questions.md`, single parking-lot file grouped by topic.
Delete a question once resolved — move the resolution into the project index or the
decisions log rather than leaving it to linger unanswered-looking.

## Inbox capture

`inbox/`. A quick excerpt, pasted text, or half-formed note that needs to be captured
before triage, not a finished note of any other type. See `inbox/README.md`.

## Workflow / persona / template

`workflows/*.md`, `personas/*.md`, `templates/*.md`. Process recipes and reusable voices,
tool-agnostic, wrapped by `.claude/skills/*/SKILL.md` for Claude Code but not dependent on
that wrapping.

## Session log / journal entry

`projects/nas-sos-capstone/sessions/*.md` (formal, one per session, append-only) vs.
`projects/nas-sos-capstone/journal/*.md` (informal, one per day, multiple entries per
file). See the journal's own README for the distinction.
