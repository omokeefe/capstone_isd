# Workflow: Literature Review Session

For a session where the goal is to make a dent in `to-do-list.md` §2, §3, or §4
(airline planning, turnaround, or OCC/dispatch literature) — processing several sources
in one sitting rather than one at a time.

## Steps

1. Bootstrap per `workflows/new-session-bootstrap.md`.
2. Open `evidence/source-register.md`, filter to the relevant to-do section
   (§2/§3/§4), and pick 2-4 `not started` sources with available PDFs. Prefer clearing
   "no PDF yet" blockers first if easy, but don't let that stall the session — skip and
   flag in `knowledge/questions/open-questions.md` if a source can't be located quickly.
3. For each source, run `workflows/annotate-source.md`.
4. After the batch, do a **synthesis pass** across the sources just read:
   - What actors/systems/decisions showed up in more than one source? (Convergent
     evidence is stronger — worth prioritizing in the architecture.)
   - What conflicts or contradictions appeared between sources?
   - What's still missing that this batch didn't cover?
   - Did any source suggest a stakeholder objective, conflict, or decomposition angle
     not yet in `stakeholder-register.md` or `index.md`? Add it.
5. Check off the relevant boxes in `projects/nas-sos-capstone/to-do-list.md` for each
   source processed.
6. Wrap up per `workflows/session-wrap-up.md`, noting in the session log which
   sources were processed and what the synthesis pass turned up.

## Notes

- Batch by to-do section, not arbitrarily — §2/§3/§4 each build toward a specific part
  of the ConOps (§5), so keeping sources grouped makes the synthesis pass more useful.
- If a source turns out to be off-topic or lower-value than expected, say so directly in
  its annotation note's confidence/limitations field rather than skipping the row
  entirely — a documented "low value, here's why" is more useful later than a silent gap.
