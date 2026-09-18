# Daily Journal

A running, append-as-you-go notebook — one file per calendar day
(`journal/YYYY-MM-DD.md`). This is now the single home for session narrative:
start-of-session recaps (`../../../workflows/session-welcome.md` — read-only, doesn't
write here), end-of-session summaries (`../../../workflows/session-signoff.md`: what
was worked on, what changed, what's blocked, next steps, plus a PM status check),
findings while reading a source, half-formed ideas, and observations worth not losing.
Multiple entries per file are normal and expected.

`../sessions/` is a **legacy** mechanism — one structured record per session, used
before 2026-09-17. Older entries there remain as historical record, but new session
sign-offs go to the journal instead; nothing currently writes to `../sessions/`.

## Format

Each day's file starts with a `# Journal — YYYY-MM-DD` header. Each entry is a `##`
subheading with a wall-clock timestamp and a short type tag, oldest entry first:

```
## HH:MM — Sign-Off
...

## HH:MM — Finding
...

## HH:MM — Note
...
```

Entry types are a loose convention, not a strict schema — use whatever tag makes the
entry's purpose clear (`Sign-Off`, `Finding`, `Idea`, `Note`, `Decision`, ...). Get the
timestamp from the system clock (e.g. `date +%H:%M`) rather than guessing.

## Using this for the report

This journal is raw material, not report prose — when writing `report/sections/*.tex`,
skim relevant days for findings/decisions worth citing, but synthesize rather than paste
directly. It's also a legitimate primary source for the report's own process narrative
(e.g. the "Assumptions and Methodology" section could reference how an approach evolved)
if a day's entries show that kind of evolution.

## Maintenance

Append-only — if a later entry finds an earlier one wrong, correct it in a new entry
rather than editing history. Don't duplicate what belongs in
`knowledge/`/`evidence/`/`decisions/` (durable facts) — if a journal entry surfaces
something that changes one of those, update the relevant file too rather than letting
the journal be the only record.
