# Stakeholder Register

_Seeded from the PESTLE pass in `prework/gpt_convos.md` (Convo 2, "Step 1 – Identify
Stakeholder Classes" and "Step 2 – Derive Enterprise Objectives"). This satisfies the
starting point for `Project_To-Do List.md` §7 ("Stakeholder and Responsibility
Analysis"); the deeper columns (needs, authorities, resources, constraints, information
needs, measures of value) are still open — fill them in as that section of the to-do
list gets worked, following
[assistant/workflows/objective-ontology-pass.md](../workflows/objective-ontology-pass.md)._

## PESTLE inventory

### Political

| Stakeholder | Interest |
|---|---|
| Federal Aviation Administration | Safe and efficient airspace |
| National Transportation Safety Board | Prevent accidents |
| Department of Transportation | National transportation policy |
| Department of Defense | National security and airspace access |
| International Civil Aviation Organization | International standards |
| Congress and legislatures | Economic growth and public accountability |
| State and local governments | Airports, jobs, and noise concerns |

### Economic

| Stakeholder | Interest |
|---|---|
| Airlines (e.g. Delta) | Profitability |
| Cargo operators | Throughput and reliability |
| Aircraft manufacturers | Product competitiveness |
| Engine manufacturers | Product performance and aftermarket revenue |
| Airports | Revenue and capacity |
| Investors and shareholders | Return on investment |
| Insurers | Risk reduction |
| Labor unions | Compensation and job security |
| Fuel suppliers | Fuel demand |
| Passengers | Affordable travel |

### Social

| Stakeholder | Interest |
|---|---|
| Passengers | Safety and convenience |
| Flight crews | Workload and quality of life |
| Cabin crews | Safety and operational effectiveness |
| Local communities | Noise and environmental impacts |
| Families of passengers | Safety |
| Disability advocacy organizations | Accessibility |
| Tourism industry | Mobility and economic activity |
| Business travelers | Schedule reliability |

### Technical

| Stakeholder | Interest |
|---|---|
| Aircraft systems engineers | System performance |
| Software developers | Correct implementation |
| Maintenance personnel | Maintainability |
| Air traffic controllers | Predictable aircraft behavior |
| Dispatchers | Operational optimization |
| Avionics suppliers | System integration |
| Researchers and universities | Innovation |
| Certification engineers | Verification evidence |

### Legal

| Stakeholder | Interest |
|---|---|
| Certification authorities | Regulatory compliance |
| Courts | Liability resolution |
| Aviation lawyers | Compliance and risk |
| Labor regulators | Worker protections |
| Privacy regulators | Passenger data protection |
| International treaty organizations | Harmonization of standards |

### Environmental

| Stakeholder | Interest |
|---|---|
| Environmental advocacy groups | Reduced emissions |
| Local communities | Reduced noise |
| Climate organizations | Decarbonization |
| Airport authorities | Sustainable operations |
| Future generations (societal proxy) | Long-term sustainability |
| Governments | Emissions targets |

## Enterprise objective hierarchy

Derived from the stakeholder inventory above (`prework/gpt_convos.md`, Step 2–3):

```
National Air Transportation System
├── Safety                      -> minimize probability/severity of accidents & incidents
├── Mobility                    -> safe, accessible, efficient transportation
├── Economic Efficiency         -> maximize lifecycle value, minimize operating cost
├── Operational Efficiency      -> maximize capacity, predictability, schedule adherence
├── Environmental Sustainability -> minimize environmental impact & resource consumption
├── Security & Resilience       -> maintain continuity of operations against hazards/threats
├── Human Well-Being            -> improve safety, comfort, accessibility, workload
├── Regulatory Compliance       -> demonstrate compliance with regulations/standards
└── Technological Evolution     -> enable future capability growth & tech integration
```

Example flow-downs to aircraft-level behavior (illustrative, not final):

```
Economic Efficiency -> Minimize Airline Operating Cost -> Minimize Fuel Burn ->
Optimize Trajectory -> FMS Guidance -> Autopilot Commands -> Control Surface
Deflections -> Aircraft Motion

Human Well-Being -> Reduce Pilot Workload -> Automate Routine Tasks ->
Auto-Flight Control System -> Flight Director Commands -> Aircraft Behavior
```

## Reconciling with the §8 stakeholder-objective ontology

`Project_To-Do List.md` §8 organizes objectives by a different, narrower stakeholder set
(Airline, Passenger, ATC/ANSP, Airport, Flight Crew, Environmental/Societal, Military).
That set is a *subset* of the PESTLE inventory above, chosen because those are the actors
who actually sit inside the trajectory-intent chain and make tradeoffs against each
other. When doing the §8 pass, map each of those seven back to the PESTLE stakeholders
above rather than treating them as a separate, disconnected list.

## Still open (per to-do §7)

For each stakeholder above: needs, goals, responsibilities, authorities, resources,
constraints, information needs, measures of value — not yet captured. Also not yet
built: the RACCI matrix, responsibility/authority transitions, and cases of ambiguous or
shared authority. Track progress on this in `assistant/tasks/task-board.md`.

For the subset of rows above that actually participate in ConOps scenarios, that "still
open" detail is being worked persona-by-persona in [[stakeholder-personas]] rather than
row-by-row here — check there before duplicating a row's detail.
