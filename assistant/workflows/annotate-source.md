# Workflow: Annotate a Source

Turns one paper/spec/report into a filled-in row in
`assistant/memory/source-register.md` plus a standalone annotation note, satisfying the
"Read and annotate paper" checklist items throughout `Project_To-Do List.md` §2–§4.

## When to use

Any time a to-do item says "Read and annotate paper" / "Review [X] literature" and
lists sub-bullets like "Identify actors/stakeholders", "Identify decisions", etc.

## Steps

1. Open `assistant/memory/source-register.md` and find the source's row (add one if
   missing — file + bib key + type + status).
2. Copy `assistant/templates/source-annotation-template.md` and fill it in while
   reading. The template's fields map directly to the to-do list's sub-bullets
   (actors/stakeholders, systems, objectives, costs, decisions, decision authority,
   activities, resources, information in/out, constraints, interfaces/handoffs,
   decision timescales, upstream dependencies, downstream consequences, optimization
   variables, objective functions, local-vs-system conflicts).
3. Save the filled-in note. Suggested location: alongside the source, e.g.
   `references/annotations/<short-name>.md` (create the `annotations/` folder the first
   time it's needed).
4. Update the source's row in `source-register.md`:
   - Fill in publication type if not already set.
   - Set status to `annotated`.
   - Add a one-line pointer to the annotation note.
5. If the source surfaced a new term, add it to `assistant/memory/glossary.md`.
6. If the source surfaced a new stakeholder, decision, or objective not already in
   `assistant/memory/stakeholder-register.md`, add it there (or flag it as a follow-up
   in `assistant/memory/open-questions.md` if it needs a judgment call first).
7. Go back to `Project_To-Do List.md` and check off the completed sub-bullets for that
   source. Leave "Map findings to candidate SysML elements" (or equivalent) unchecked
   until that mapping is actually done — annotation and architecture-mapping are
   separate steps.
8. If this was the last unannotated source in a literature-review batch, consider running
   `assistant/workflows/literature-review-session.md`'s wrap-up step to synthesize across
   sources instead of just leaving them as isolated notes.

## Notes

- Don't try to fill every field for every source — some papers won't have, say, an
  "optimization variables" section. Mark those `n/a` rather than leaving them blank
  (blank reads as "not yet checked"; `n/a` reads as "checked, doesn't apply").
- Confidence/limitations is not optional — always record how confident the extraction
  is and what limits it (e.g. "review paper, doesn't give primary data" or "single
  case study, may not generalize").
