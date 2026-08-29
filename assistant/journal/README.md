# Daily Journal

A running, append-as-you-go notebook — one file per calendar day
(`assistant/journal/YYYY-MM-DD.md`). Distinct from `assistant/tasks/sessions/`:

- `tasks/sessions/` — one structured record **per session** (or per major sub-task),
  written at wrap-up time per `../workflows/session-wrap-up.md`: what was worked on, what
  changed, what's blocked, what's next. Formal, retrospective, one entry per file.
- `journal/` (here) — informal, chronological, **per day**, appended to throughout the
  day: session tag-ups (`../workflows/session-tagup.md`), findings while reading a
  source, half-formed ideas, observations worth not losing. Multiple entries per file are
  normal and expected.

## Format

Each day's file starts with a `# Journal — YYYY-MM-DD` header. Each entry is a `##`
subheading with a wall-clock timestamp and a short type tag, oldest entry first:

```
## HH:MM — Tag-Up
...

## HH:MM — Finding
...

## HH:MM — Note
...
```

Entry types are a loose convention, not a strict schema — use whatever tag makes the
entry's purpose clear (`Tag-Up`, `Finding`, `Idea`, `Note`, `Decision`, ...). Get the
timestamp from the system clock (e.g. `date +%H:%M`) rather than guessing.

## Using this for the report

This journal is raw material, not report prose — when writing `report/sections/*.tex`,
skim relevant days for findings/decisions worth citing, but synthesize rather than paste
directly. It's also a legitimate primary source for the report's own process narrative
(e.g. the "Assumptions and Methodology" section could reference how an approach evolved)
if a day's entries show that kind of evolution.

## Maintenance

Append-only, like `tasks/sessions/` — if a later entry finds an earlier one wrong,
correct it in a new entry rather than editing history. Don't duplicate what belongs in
`assistant/memory/` (durable facts) or `tasks/sessions/` (formal session records) — if a
journal entry surfaces something that changes a memory file or deserves a full session
log, do that too rather than letting the journal be the only record.
