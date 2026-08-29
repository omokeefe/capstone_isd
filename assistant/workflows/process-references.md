# Workflow: Process References

A fast triage pass over `references/` — distinct from (and a prerequisite to) the deep
extraction in `assistant/workflows/annotate-source.md`. Run this whenever the user says
something like "process my references" / "check for new references." The goal: every
file in `references/` has a complete bib entry, a short written summary, and an honest
0-5 rating, and the register knows when it was last checked.

## Step 1 — Find what's new

1. Read `assistant/memory/source-register.md`'s **Processing Ledger** — note the "Last
   full sweep" date and which files already have an entry.
2. List the actual contents of `references/` (top-level files only; skip
   `references/summaries/` and `references/annotations/` — those are outputs, not
   sources). Compare against the ledger.
3. Classify each file as:
   - **Already processed** — in the ledger with a rating and summary. Skip unless the
     user asks for a re-review or the file has visibly changed.
   - **New** — on disk but not in the ledger at all.
   - **Ledger stub without a file** — in the ledger (or the annotation tables) marked
     "no PDF yet" but the file has now appeared. Treat like "new."
4. Report the new/changed count to the user before processing a large batch (more than
   ~5 files) — reading many PDFs takes a while; let them confirm scope or ask for a
   subset first.

## Step 2 — Process each new file

For each new file:

1. **Read it** (at least the abstract/intro/conclusion for a long paper; the whole thing
   for anything short). Extract: title, authors, year, venue/publisher, DOI if present.
2. **Bibliography** — check `references/references.bib` for an existing stub entry
   matching this file (some bib entries predate their PDF). If one exists, fill in any
   missing fields; if not, add a new entry using the existing key convention
   (`lastname+year+shorttitle`, lowercase, no spaces — e.g. `schultz2017turnaround`).
   Match the formatting already used in the file (see existing entries for field order
   and style). If bibliographic details are ambiguous or unconfirmed from the PDF alone,
   it's fine to use `WebSearch` to verify title/authors/venue/DOI — but if a detail
   can't be confirmed, leave a `note = {...}` flag on the entry saying so (matching the
   existing pattern on `yan2008integrated`) rather than guessing.
3. **Check for duplicates** — compare the new title/topic against existing entries
   (`source-register.md` and `references.bib`). If it looks like a near-duplicate of an
   existing source (e.g. a conference version vs. journal version of the same work,
   which has already happened once in this register — see the two aircraft-engine-inlet
   MBSE papers), flag it explicitly in the summary rather than silently rating it as if
   independent.
4. **Write the summary** — copy
   `assistant/templates/reference-summary-template.md` to
   `references/summaries/<bib-key-or-slug>.md` and fill it in:
   - What the reference is (1-2 sentences: type of source, scope, methodology).
   - What's valuable in it and for which part of the project — be specific: does it feed
     a `Project_To-Do List.md` section (§2-§4 literature review, §6 decomposition, §7-§9
     stakeholder/objective work, §11-§13 optimization), the glossary, the stakeholder
     register, or MBSE methodology/technique for the architecture itself? A source can
     serve more than one; name all that apply, not just the most obvious one.
   - A 0-5 rating per the scale in `source-register.md`'s Processing Ledger, with a
     one-line justification — rate for *usefulness to this specific capstone*, not
     general academic quality.
   - Read depth (skimmed vs. fully read) and today's date.
   - Any flags: possible duplicate, missing/unverifiable bib fields, low confidence.
5. **Update the ledger row** in `assistant/memory/source-register.md`: bib key, rating,
   a link to the summary file, and today's date in "Last processed."
6. **Naming convention** — after writing the summary file, rename it to include the
   rating as a numeric prefix: `<rating> - <bib-key-or-slug>.md` (e.g.
   `4 - bartolomei2012esmdm.md`, `5 - clarke1998irregular.md`, `2 - luDesignOntologyMBSE2020.md`).
   This makes file listings sort by relevance and signals importance at a glance.
6. If the summary surfaced something belonging in `assistant/memory/glossary.md`,
   `assistant/memory/stakeholder-register.md`, or `assistant/memory/open-questions.md`,
   add it — but keep this lightweight; deep extraction is `annotate-source.md`'s job, not
   this workflow's.

## Step 3 — Close out the sweep

1. Update the Processing Ledger header in `source-register.md`: "Last full sweep" date
   and the "N of M processed" count.
2. If any new source scored 4-5 and its to-do section (§2-§4) hasn't been started yet,
   mention it to the user — it's a candidate to prioritize in the next literature-review
   session.
3. If any source scored 0-1, say so plainly and ask whether to keep it in `references/`
   or flag it for removal — don't silently bury a low rating.
4. Log the sweep in `assistant/tasks/sessions/` per
   `assistant/workflows/session-wrap-up.md` if this was a standalone session (date, how
   many files processed, ratings distribution, anything flagged).

## Notes

- This is a triage pass, not a literature review — a 15-30 minute read per source is
  normal; don't try to extract every field `annotate-source.md` asks for.
- Re-running this on an already-processed file (no user request to re-review) should be
  a no-op — check the ledger first, don't re-read PDFs unnecessarily.
- If `references/summaries/` doesn't exist yet, create it and add a one-line
  `references/summaries/README.md` noting these are generated by this workflow.
