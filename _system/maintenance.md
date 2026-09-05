# Maintenance

The minimum recurring upkeep this workspace actually needs — not exhaustive tagging,
not perfect inbox processing, not keeping every index continuously current.

## Every session

Per `workflows/session-wrap-up.md`: a session log, a task-board update, a sweep for
memory drift (does anything discovered this session make `index.md`,
`decisions-log.md`, or `open-questions.md` wrong?), and a checkbox-reality check against
`to-do-list.md`. This is the one maintenance step that should never be skipped — it's
cheap and it's what keeps every other retrieval path in this policy working.

## When convenient, not every session

- **Triage `inbox/`** per `workflows/process-inbox.md` — fine to let a few items sit
  untriaged; not fine to let it become a permanent second junk drawer. A good trigger:
  whenever session-wrap-up notices it's non-empty.
- **Reconcile a flagged duplicate or version-mismatch** in `evidence/source-register.md`'s
  Flags section (e.g. the de Neufville/Bartolomei draft-vs-published pair) — these are
  deliberately left as a human decision, not auto-resolved.

## Occasional (roughly per phase of `to-do-list.md`)

- **Re-run the retrieval baseline** in `_system/retrieval-policy.md` — a quick sanity
  check that context is still cheap to reload, not a formal audit.
- **Revisit whether `knowledge/concepts/glossary.md` or `decisions/decisions-log.md`
  still belong as single files.** They're single files today because splitting ~50 short
  glossary entries or 2 decisions into one-file-per-item would fragment them for no
  measured retrieval benefit (confirmed during the 2026-09-05 reorg). Revisit that
  judgment if either file grows large enough that scanning it becomes the bottleneck —
  a rough trigger: decisions-log.md past ~15-20 entries, or glossary.md past ~150 terms
  or requiring frequent scrolling to find a term.
- **Check for broken relative links** after any future file move — grep for the old path
  fragment across the repo; don't assume a `git mv` alone kept every internal link valid
  (see `_system/migrations/` for how the 2026-09-05 reorg approached this).

## What this workspace deliberately does not depend on

Per the reorg's governing philosophy: perfect inbox processing, exhaustive tagging,
manually maintaining every backlink, assigning every note to exactly one topic, reading
every captured source, keeping every index continuously current, AI access to the entire
workspace, or a proprietary database that obscures the markdown. If a maintenance task
feels like it's fighting one of these, it's probably the wrong task.
