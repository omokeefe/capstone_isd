# Metadata Schema

This workspace uses **no YAML frontmatter** on knowledge/evidence/decision files. This is
a deliberate choice, not an oversight: a repo-wide audit during the 2026-09-05 reorg found
zero existing files using frontmatter, and the structured-prose conventions already in
place carry the same epistemic-status distinctions a frontmatter schema would add:

| What frontmatter would encode | How this workspace already encodes it |
|---|---|
| `type` | The folder/note-type itself (`knowledge/models/`, `decisions/decisions-log.md`, etc.) — see `_system/note-types.md`. |
| `status` | A prose `**Status:**` line (decisions-log's `Status: active \| superseded by D-00X \| reverted`; source-register's `not started / in progress / annotated / mapped to architecture`). |
| `confidence` | Source annotations' explicit "Confidence / limitations" field. |
| `source` / `source_status` | A source summary's own bibliographic header block. |
| `created` / `updated` | A dated `**Date:**` or "Last processed" field, or the file's own git history. |
| `authorship` (AI vs. human) | Stated in prose where it matters — e.g. reference summaries are explicitly AI-generated triage, distinct from a claim note's required human-stated claim (see `knowledge/claims/README.md`). |

## When to add real frontmatter

Only if a future need requires *querying across many files by a field* (e.g., "list all
`decisions` with `status: active`" via a script or a tool that reads frontmatter) rather
than just reading the one file that already has the answer. This workspace hasn't hit
that need — the file counts are small enough that `_system/note-types.md` plus grep
covers it. If that changes, add the schema incrementally to the note type that actually
needs it, rather than retrofitting every file at once.
