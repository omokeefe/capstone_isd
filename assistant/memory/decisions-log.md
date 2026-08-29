# Decisions Log

ADR-style record of decisions and why they were made. Append new entries at the top
(newest first). Don't rewrite old entries when a decision changes — add a new entry that
supersedes it and link back with `[[decisions-log]]`-style references or a direct note.

---

## D-002 — Layered domain decomposition over a flat object list

**Date:** captured retroactively, 2026-08-29 (decision predates this log)
**Status:** active, but explicitly provisional — see [[open-questions]]

**Decision:** Organize the architecture around connected domains (Governance, Airspace
Management, Airspace Resources, Flight Operations, Airport Operations, Aircraft Systems,
Information Services, Infrastructure, Decision Support) built around authority,
responsibility, and information ownership — rather than a flat catalog of aviation
objects (aircraft, radars, airports, etc.).

**Rationale:** A flat list of "things in aviation" doesn't expose who owns what
responsibility or how information moves between owners, which are the questions an ISD
architecture needs to answer. The domain decomposition makes airspace sectors, controller
responsibilities, flight intent, clearances, weather products, surveillance tracks, and
trajectory intent into first-class architecture elements instead of background noise.

**Alternatives considered:** Physical/object-based decomposition (rejected — hides
authority/information ownership); a single all-encompassing NAS diagram (rejected — not
bounded enough to finish).

**Revisit when:** `Project_To-Do List.md` §6 ("Explore Alternative System
Decompositions") is worked — that section explicitly plans to build organization-based,
lifecycle-based, physical, information-flow, and decision-authority decompositions and
compare them. This decision may be confirmed, refined, or replaced by a decision to keep
multiple parallel viewpoints instead of one canonical decomposition.

---

## D-001 — Pivot from trajectory/rendezvous optimization to NAS-as-SoS architecture

**Date:** captured retroactively, 2026-08-29 (decision predates this log)
**Status:** active

**Decision:** Reframe the capstone from a rendezvous/trajectory optimization problem to
a broader systems-of-systems architecture of the National Airspace System, with
optimization/decision-support demoted to one capability inside that architecture rather
than the whole subject.

**Rationale:** The original optimization framing didn't showcase the strengths an ISD
capstone is meant to demonstrate — architecture, interfaces, responsibility,
traceability. The NAS-as-SoS framing does, while still leaving room for an optimization
case study (see `Project_To-Do List.md` §11–§13) to demonstrate how architecture exposes
cross-stakeholder impacts that a standalone optimizer would miss.

**Alternatives considered:** Keep the narrow trajectory-optimization scope (rejected —
too mathematical, not architecture-centric enough); go fully broad and survey all of
aviation (rejected — not bounded enough to finish, see project-brief.md working
assumptions).

**Evidence:** `prework/gpt_convos.md` (both conversations), `README.md` "Capstone
Direction" and "Working Assumptions" sections.

---

_Template for new entries:_

```
## D-00N — <short decision title>

**Date:** <date>
**Status:** active | superseded by D-00X | reverted

**Decision:** <what was decided>
**Rationale:** <why, including the specific constraint/tradeoff that drove it>
**Alternatives considered:** <what else was on the table and why it lost>
**Evidence / source:** <file or conversation that documents this>
```
