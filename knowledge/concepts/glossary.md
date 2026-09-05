# Glossary

_Domain terms and acronyms, defined once so they don't get redefined inconsistently
across sessions or documents. Add to this file whenever a new term shows up in a source
or conversation — don't let definitions live only in someone's head or a single PDF._

## Systems engineering / MBSE

- **ISD** — Interdisciplinary/Integrative Systems Design (the UofM capstone program this
  project is for).
- **SoS** — System of Systems.
- **SOI** — System of Interest.
- **MBSE** — Model-Based Systems Engineering.
- **SysML** — Systems Modeling Language.
- **BDD** — Block Definition Diagram (SysML structural view).
- **IBD** — Internal Block Diagram (SysML structural view showing internal connections).
- **ConOps** — Concept of Operations.
- **RACCI** — Responsible / Accountable / Consulted / Contributing / Informed (a RACI
  variant used for responsibility mapping — see `to-do-list.md` §7).
- **PESTLE** — Political, Economic, Social, Technical(/Technological), Legal,
  Environmental (stakeholder-discovery framework — see
  [[stakeholder-register]]).
- **MOE / MOP** — Measure of Effectiveness / Measure of Performance.
- **Holon / holarchy** — A holon is a semi-autonomous unit that is simultaneously a
  self-contained whole and a subordinate part of a larger structure; a holarchy is the
  recursive hierarchy of holons. Used as an alternative SoS decomposition pattern in
  `sadik2025holonicUAM` — see [[source-register]].
- **ISO/IEC/IEEE 42010** — the international standard for architecture description,
  defining architecture in terms of stakeholders, concerns, and viewpoints. Used by
  `yao2026loAltitudeSoSSafety` to justify a three-facet SoS decomposition
  (composition/environment interaction; organizational/operational structure;
  governance/evolution).
- **STAMP** — System-Theoretic Accident Model and Processes (Leveson); frames safety as a
  control problem (Controller–Actuators–Sensors–Controlled Process feedback loop). Used in
  `yao2026loAltitudeSoSSafety`'s safety-control-loop framing.
- **IASMS** — In-Time Aviation Safety Management System; an evolution of traditional
  Safety Management Systems (SMS) toward continuous, real-time safety monitoring. See
  `yao2026loAltitudeSoSSafety`.

## Airspace / ATC

- **NAS** — National Airspace System.
- **ATC** — Air Traffic Control.
- **ATM** — Air Traffic Management.
- **ANSP** — Air Navigation Service Provider.
- **ARTCC** — Air Route Traffic Control Center (enroute control).
- **ATFM** — Air Traffic Flow Management.
- **NOTAM** — Notice to Air Missions (formerly Notice to Airmen).
- **IFR** — Instrument Flight Rules.
- **FMS** — Flight Management System (onboard system that turns trajectory intent into
  guidance commands).
- **TRACON** — Terminal Radar Approach Control (departure & arrival airspace, between
  tower and ARTCC — see [[candidate-systems-inventory]]).
- **FIR** — Flight Information Region (ICAO-defined airspace block; a NAS may contain a
  Lower and Upper FIR — see [[candidate-systems-inventory]]).
- **ATCSCC** — Air Traffic Control System Command Center (national-level traffic-flow
  management, works with GMTOs — General Managers of Tactical Operations).
- **ATFMS** — Air Traffic Flow Management System(s); includes **ETFMS** (Enhanced
  Tactical Flow Management System) and **AMAN** (Arrival Management) — see
  [[candidate-systems-inventory]].
- **SWIM** — System Wide Information Management (shared information-exchange
  infrastructure across ATC/ANSP systems — see [[candidate-systems-inventory]]).
- **EASA / CAAC** — European Union Aviation Safety Agency / Civil Aviation Administration
  of China (regulator analogues to the FAA, named in [[candidate-systems-inventory]] as
  examples of a generic "Regulatory System" pattern).

## Airline operations

- **OCC / AOC** — Operations Control Center / Airline Operations Center (day-of-ops
  disruption management, dispatch oversight).
- **A-CDM** — Airport Collaborative Decision Making (EUROCONTROL specification governing
  shared milestone/information exchange during turnaround — see
  `evidence/sources/eurocontrol-specification-for-acdm.pdf`).
- **W&B** — Weight and Balance (load control).
- **ARP / CRP / PRP** — Aircraft Recovery Problem / Crew Recovery Problem / Passenger
  Recovery Problem — the three sequential sub-problems of airline disruption management
  (see `santana2023arpReview` in [[source-register]]).

## Notes

- This list is intentionally partial. Expand it as sources get annotated
  ([[source-register]]) rather than trying to front-load every possible term now.
