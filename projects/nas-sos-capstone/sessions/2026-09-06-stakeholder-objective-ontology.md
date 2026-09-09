# Session: 2026-09-06 — stakeholder objective/cost/value ontology (§8)

**Tool used:** Claude Code
**To-do section(s) touched:** §8 (full pass)

## What was worked on and why

User asked for a table of possible stakeholders (drawing on
`stakeholder-register.md`, `stakeholder-personas.md`, `candidate-systems-inventory.md`,
`interface-exchange-draft.md`) specifying each one's objective, MOP, MOE, whether
trajectory decisions can impact them, and comments on appropriate level of abstraction.
This is exactly `to-do-list.md` §8's scope, so ran the `objective-ontology-pass` skill
and worked the full §8 checklist rather than a one-off table, per that workflow's step
4-5.

## What changed

- Files touched:
  - `knowledge/models/stakeholder-objective-ontology.md` (new) — one table per §8
    category (Airline, Passenger, ATC/ANSP, Airport, Flight Crew,
    Environmental/Societal, Military), each row giving objective, classification (hard
    constraint / optimization objective / cost-penalty / MOE / MOP), MOP, MOE,
    trajectory-decision impact (Yes/Indirect/No), and an abstraction-level comment; plus
    a closing synthesis section (conflicting objectives, aligned objectives,
    externalized costs, differing timescales) that cuts across categories.
  - `knowledge/models/stakeholder-register.md` — added a pointer from the existing "§8
    reconciliation" section to the new file instead of duplicating detail there.
  - `_system/note-types.md` — added the new file to the Model note type's file list.
  - `projects/nas-sos-capstone/to-do-list.md` — checked off all of §8 (per-category
    objective bullets, the classification sub-bullets, and the closing
    conflicts/alignments/externalities/timescales bullets).
- Decisions made: none added to `decisions-log.md` — the Military-category treatment
  (model only the civil/military airspace-access interface, not internal mission
  detail) is a working assumption stated in the new file, not a closed decision; it
  still traces to the open SOI question below.
- `to-do-list.md` boxes checked: all of §8 (see diff).

## Blocked / open

- The Military and Environmental/Societal tables in the new file are flagged as the
  most provisional — no persona exists for either, and no literature source has been
  annotated yet that specifically targets airline-objective, ATC-workload, or
  environmental-impact evidence. Revisit those two tables once §2-§4 annotation reaches
  the relevant sources.
- Does not touch §7 (stakeholder needs/authorities/resources/RACCI) — that's a separate,
  larger pass the user didn't ask for this session; `stakeholder-register.md`'s "Still
  open" section is unchanged.
- The Military civil/military-boundary assumption still traces to the existing
  `open-questions.md` "System boundary" entry ("is military airspace operations beyond
  their PESTLE/objective role in scope?") — not resolved, just given a working default.

## Next step

The conflicting-objectives synthesis in the new file names one clear front-runner for
the §11 optimization study ("airline fuel-cost minimization vs. ATC/ANSP sector
workload/predictability") — worth deciding whether to lock that in as the representative
scenario once §5's ConOps and §7's RACCI work are further along. The CO2-vs-contrail
conflict (intra-Environmental/Societal) is also flagged as a strong `knowledge/claims/`
candidate per that folder's README, alongside the individual-trajectory-vs-sector-
congestion claim already flagged there.
