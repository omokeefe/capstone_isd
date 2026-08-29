# Project Brief

_Last updated: 2026-08-29. This file should stay current — edit it in place when the
project's scope or direction changes; don't leave stale statements next to new ones._

## What this is

A UofM ISD systems engineering & design capstone. System of interest: the **National
Airspace System (NAS)**, treated as a **System of Systems**, modeled in SysML/Cameo, with
an emphasis on architecture (structure, behavior, interfaces, traceability) rather than a
purely mathematical optimization problem.

## How we got here

The project originally started as a **rendezvous / trajectory optimization** problem.
After scoping discussions (see `prework/gpt_convos.md`), the direction broadened to a
systems-of-systems architecture of the NAS itself, because that framing better fits an
ISD capstone's strengths (architecture, interfaces, responsibility, traceability) and
gives optimization a defined *place* — a decision-support capability inside the
architecture — instead of being the entire subject. See
[[decisions-log]] for the fuller rationale.

## Center of gravity

The throughline that keeps the project bounded is the **lifecycle of trajectory
intent**:

```
Strategic objective -> mission plan -> flight plan -> ATC constraints ->
trajectory negotiation -> FMS intent -> guidance commands -> aircraft motion
```

Everything else (stakeholder analysis, objective ontology, architecture decomposition,
optimization study) should trace back to this chain somewhere.

## Candidate top-level domains

Not yet finalized as a SysML package structure, but the working decomposition is:

Governance · Airspace Management · Airspace Resources · Flight Operations ·
Airport Operations · Aircraft Systems · Information Services · Infrastructure ·
Decision Support

See [[open-questions]] for unresolved boundary calls, and
`Project_To-Do List.md` §6 ("Explore Alternative System Decompositions") for the plan to
compare this against organization-based, lifecycle-based, physical, information-flow,
and decision-authority decompositions before committing.

## Working assumptions (guardrails)

- Emphasis is structure, behavior, interfaces, and traceability — not optimization math.
- The project must stay bounded enough to actually finish; the NAS is huge.
- Decision-support / optimization appears as a service *inside* the architecture.
- The model should show how information moves between domains, not just what physical
  things exist.

## Likely final storyline

A reference architecture for how airspace intent is managed across the NAS — spanning
the organizations that define/enforce rules, the domains managing airspace resources, the
systems supporting flight operations, and the onboard systems turning intent into
executable trajectory/guidance behavior. Success criterion: a reviewer can follow one
clear chain from a mission/operational goal down to aircraft-level execution, and back up
to the authorities/services that constrain it.

## Repository map

- `README.md` — the public-facing project overview (keep in sync with this file).
- `Project_To-Do List.md` — canonical 16-section task checklist.
- `nas_system_of_systems_architecture.xml` — architecture content exported as XML.
- `cameo_models/` — SysML/Cameo model workspace.
- `prework/` — source material predating the structured workflow (gpt_convos.md is the
  most important: it captures the two conversations that shaped the direction and the
  PESTLE stakeholder / enterprise-objective analysis).
- `references/` — literature PDFs + `references.bib`.
- `assistant/` — this AI-collaboration scaffold.

## Next steps (as of last update)

Per README.md's "Suggested Next Steps": turn the XML architecture into a visible Cameo
package structure, define top-level operational domains and cross-cutting information
objects, build representative activity diagrams around trajectory intent and
responsibility handoffs, then add requirements/verification links once the skeleton is
stable. Cross-check against `assistant/tasks/task-board.md` for the current active focus.
