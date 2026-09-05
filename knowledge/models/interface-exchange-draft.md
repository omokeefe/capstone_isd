# Interface / Exchange Draft — Airport Management System Hub

_Draft interface/information-exchange model extracted from the hub-and-spoke diagram on
the left-hand side of `prework/Air Transport System Architecture.pdf` (a generic
reference diagram authored by the user prior to this project). Feeds
`to-do-list.md` §10's information-object model and interface/item-flow model, and
the Turnaround/Day-of-Operations phases of [[conops-scenarios]]. See
[[candidate-systems-inventory]] for the companion systems extraction from the same
source._

## Source document

<embed src="../../prework/Air Transport System Architecture.pdf" type="application/pdf" width="100%" height="600px" />

*(Renders inline in viewers that allow local PDF embeds, e.g. a browser opening this file
directly — VS Code's Markdown preview and GitHub's rendered view generally block it for
security, so if you see nothing above, use the link instead:*
[open prework/Air Transport System Architecture.pdf](<../../prework/Air Transport System Architecture.pdf>)*.
This is a reference to the existing file, not a copy.)*

## Extraction caveat — read before using this

This was reconstructed from PDF text-layer extraction, not a verified visual trace of
the diagram's actual connecting lines and arrowheads. The hub (a black circle) and eight
spoke labels are clear; the **send/receive direction of each phrase below is
reconstructed from its wording** ("Send X" / "Receive X" / imperative phrasing implying
which party acts), not confirmed against arrow direction in the source. **Open the PDF
and check the arrows before treating any direction below as final** — treat this table as
a strong starting draft, not a verified ICD.

## Hub

**Airport Management System (AMS)** — center node; all eight spokes below exchange
information with AMS specifically (not with each other directly, per this diagram).

## Draft exchange table

| Spoke (actor/system) | → AMS (sends to AMS) | ← AMS (receives from AMS) |
|---|---|---|
| Airlines | Submit flight schedules, boarding info | Gate assignments, passenger boarding status |
| Passengers | Check-in requests, view flight status, track baggage | Boarding pass, baggage status, flight updates |
| Air Traffic Control (ATC) | Takeoff/landing clearance | Flight departure and arrival times; requests for takeoff/landing clearance |
| Ground Handling | Status of ground services | Requests for baggage, refueling, and maintenance |
| Customs and Immigration | Clearance of passengers; alerts for suspicious individuals | Passenger info for international flights |
| Security Services | Security clearance for passengers; incident reports | Security alerts; passenger screening data |
| Parking and Transportation Services | Parking availability; ground-transportation needs | Arrival/departure data |
| Baggage Handling System | Baggage location, status, and delivery confirmation | Baggage information; bag-tag assignment |

## Notes per spoke

- **Airlines / Passengers / ATC** — directions here are the most confidently reconstructed
  (the phrasing is unambiguous: "Submit," "Check-in," clearance requests clearly
  originate from one side). Lower risk of being backwards.
- **Ground Handling, Customs, Security, Parking, Baggage** — directions are plausible but
  less certain; several of these phrases could plausibly run either way depending on the
  actual diagram (e.g., "Receive Status of Ground Services" — is AMS the receiver, or is
  this phrased from Ground Handling's point of view?). Treat the AMS-centered framing
  above as the working hypothesis, confirm against the source.

## Relevance to other project work

- **ConOps ([[conops-scenarios]])**: this hub maps almost directly onto the Turnaround
  phase of the nominal-flight ConOps (to-do §5) — gate assignment, baggage,
  security/customs, parking/ground transport are all Turnaround-phase activities. When
  drafting that scenario, this table is a ready-made starting point for its information
  exchanges rather than inventing them from scratch.
- **Personas ([[stakeholder-personas]])**: none of these five spokes (Ground Handling,
  Customs and Immigration, Security Services, Parking and Transportation Services,
  Baggage Handling System) have a drafted persona yet. They read more like
  systems/service-providers than individual human roles, so before drafting a persona for
  each, decide whether they need one (a persona per *role*, e.g. "Customs Officer") or
  whether they're better represented as systems in the architecture with AMS as their
  interface — that's itself a small instance of the stakeholder/actor-boundary question
  in [[open-questions]].
- **§10 information-object model**: each row's exchanged content (schedules, boarding
  info, clearances, screening data, etc.) is a candidate information object/item flow —
  useful seed list once §10 IBD/ICD work starts (ECD 2026-10-25/2026-10-29).

## Status

Extracted 2026-08-30, directions unverified against the source diagram (see caveat
above), not yet reconciled with the architecture or Cameo model. Next step: visually
confirm the eight rows against the PDF, then either fold into the Airport Operations
domain's IBD directly or keep here as the working draft until that diagram exists.
