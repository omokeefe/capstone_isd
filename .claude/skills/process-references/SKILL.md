---
name: process-references
description: Scan references/ for new or unprocessed files, add/complete their bibliography entries, write a summary of each, and rate its relevance 0-5. Use when the user asks to process, check, or update references, or mentions new papers added to the references folder.
---

Follow `assistant/workflows/process-references.md` exactly. Check
`assistant/memory/source-register.md`'s Processing Ledger first to see the last sweep
date and which files are already done — only process files that are new or explicitly
flagged for re-review. For each new file: read it, add/complete its
`references/references.bib` entry, write a summary to `references/summaries/` from
`assistant/templates/reference-summary-template.md` (what it is, which project parts it
serves, a 0-5 rating with justification, flags), and update its Processing Ledger row.
Report new/changed file counts before processing a large batch, and update the "Last
full sweep" line when done.
