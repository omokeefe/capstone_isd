# Traffic Aware Strategic Aircrew Requests (TASAR): Annualized TASAR Benefits for Alaska Airlines Operations

- **File:** `evidence/sources/tasar_ntrs_20140012787.pdf`
- **Bib key:** `engility2014tasarAlaska`
- **Authors:** Engility Corporation (corporate author). The document says it "was prepared by Engility Corporation, 900 Technology Park Dr., Billerica, MA under Contract No. NNL12AA06C with NASA Langley Research Center, Hampton, VA" (Preface, p. 2). NASA Technical Monitor: David Wing (title page). No personal author is named.
- **Year:** 2014 (contractor deliverable dated 2 September 2014)
- **Venue:** Contractor report to NASA Langley Research Center, contract NNL12AA06C, deliverable 41A; NTRS document 20140012787
- **DOI:** none found

## What it is

A 23-page contractor report on a fast-time simulation. TASAR is software in the cockpit that suggests route and altitude changes the controller is likely to approve; the crew then asks for them by voice. The study replays real Alaska Airlines flights from July to September 2012, lets a simulated crew make requests and a simulated controller accept or reject them, and scales the fuel and time saved to a year and to dollars.

## Why it's valuable — and to what

- Literature review section: none of §2–§4. It serves the §11 experiment definition, and it is evidence for the controller side of the architecture.
- Decomposition / architecture (§6, §10): it states who knows what at the moment a trajectory change is decided.
  - The aircraft sees other aircraft only out to an assumed 60 NM ADS-B range and does not have their flight plans, so its conflict check uses "state projections using current heading, vertical rate, and speed" (p. 9).
  - The controller "had more information about the surrounding traffic": every aircraft's flight plan, and aircraft beyond that range (p. 10).
  - The sector controller is "generally not aware of red sectors elsewhere and will not consider traffic demand in other sectors when evaluating aircrew requests. However, the area manager may instruct the controller not to send traffic through an adjacent sector if the adjacent sector is currently experiencing high traffic" (p. 10). This is a three-level information chain: the traffic management function sees sector loading, a supervisor passes on a restriction, and the sector controller applies it without seeing the reason.
  - The study did not model aircraft weight, and limited climbs to FL350 and below for that reason (p. 8). Nobody in the simulation, air or ground, uses weight.
- Stakeholder / objective ontology (§7–§9):
  - The airline's objective is written as 50 percent fuel and 50 percent time, with no trade allowed between them (p. 8).
  - The controller's objective appears as a rule set (§3.3): reject on conflict, reject when the sector is over its Monitor Alert Parameter, reject when the request heads into an adjacent sector that is over its parameter.
  - "All automation and pilot procedures are fully dedicated to a single aircraft" (p. 6): each aircraft optimizes for itself, and the cost to the system shows up as requests per sector per hour (§5).
- Optimization study (§11–§13):
  - Size of the effect, per flight (p. 12): 27 gallons and 2.3 minutes for a switch to a more wind-optimal trajectory; 103 gallons and 7.8 minutes after a reroute initiative has ended; 12 gallons and 1.3 minutes around convective weather. The reroute and weather cases together were fewer than 5 percent of flights, so the wind figure is the typical one.
  - The earlier study this one builds on (Henderson, Wing and Idris 2012, not held) found 543 lb of fuel (about 80 gallons) and 3.6 minutes per flight for network carriers (p. 6).
  - Levers and their limits (p. 8): lateral changes of one or two named waypoints, because requests go by voice; altitudes of 2,000 ft above, 2,000 ft below and 4,000 ft below.
  - A sourced, simple controller model for a baseline (§3.3), and a set of "do not even ask" rules (§3.2): one request per sector, none within about 20 NM of the sector boundary, none in the initial climb, none within 200 NM of a large hub.
  - A method for the airline cost metric (§4.3): fuel at the airline's reported price per gallon, plus maintenance and depreciation per minute, both from public filings. Crew cost is left out.
  - Simulation set-up (§3): two linked copies of NASA's FACET tool, one holding the present and one predicting ahead, with recorded traffic, recorded winds, logged reroute initiatives and radar weather as inputs.
- Glossary / terminology: TASAR; "red sector" (added to the MAP entry); FACET; ASDI; RUC. NTML and MAP were already in the glossary.
- Other: general practice for requests to ATC, useful for the ConOps scenarios. Controllers generally deny requests during the initial climb because the departure stream may interfere with the arrival stream, and expect aircraft to be on the assigned arrival route within 200 NM of a large hub (p. 9). A controller may hold a request and grant it once traffic has passed (pp. 16–17).

## What "monitor alert parameter value" and "red sector" mean

The report says a request is rejected when it "occurs in a sector that was experiencing traffic exceeding its monitor alert parameter value (i.e., a red sector)" (p. 10). It does not define either term. FAA Order JO 7210.3EE §18-9 (`faa2025jo72103ee`) does:

- The **Monitor Alert Parameter (MAP)** "establishes a numerical trigger value to provide notification to facility personnel, through the MA function of the TFMS, that sector/airport efficiency may be degraded during specific periods of time" (¶18-9-1). In plain terms it is a number for each sector: when the traffic predicted for the sector reaches that number, the traffic flow system raises an alert.
- Baseline values come from "a workload-based model collaboratively developed at the national level" (¶18-9-2). So the number stands for controller workload, not for a physical limit of the airspace.
- It is "a dynamic value" (¶18-9-1). The facility's traffic management unit can lower or raise it for weather, turbulence or equipment outages, and must tell the Command Center when it does (¶18-9-2b).
- The alert goes to the traffic management unit, which for a red alert must "notify the affected area of the alert, indicating the expected impact and recommended action" (¶18-9-3d2). The order names the team as the controllers, the operations supervisors and the traffic management unit (¶18-9-1). It does not say the sector controller sees the alert, which matches the report's statement that controllers are generally not aware of red sectors elsewhere.
- Initiatives are meant for periods when the value "will be equaled or exceeded for a sustained period of time (usually greater than 5 minutes)" (¶18-9-3c NOTE).

Two things the order does not settle:

- **Red against yellow.** §18-9 uses both words without defining them. The usual description is that red means aircraft already airborne are enough to exceed the value, and yellow means the value is exceeded only when flights still on the ground are counted. That description is not from a source held in this repository. [C]
- **"Area manager."** This is the report's term, not the order's. The nearest position in the order is the operations supervisor of the area (a group of sectors in a center). Treating the two as the same is an assumption. [C]

## Rating

**4/5** — The size-of-effect figures, a sourced controller acceptance model, and a clear statement of what the aircraft, the controller and the supervisor each know. Not a 5: it is a contractor's simulation with a modeled controller, weight is left out, and the experiment's own direction of information flow (aircraft data to ATC) is the reverse of TASAR's.

## Flags

- **Author.** Cited as the document states it: Engility Corporation as corporate author, David Wing as NASA Technical Monitor. A web search summary of the NASA record for a later published version (NASA/CR-2015-218787, NTRS 20150017048) names Jeffrey Henderson as author. That record was not opened and the name is not on this PDF, so it is not used. The report's own reference [1] is Henderson, Wing and Idris (2012), the earlier study.
- **The controller model is the authors' model.** The report says observations at ATC facilities were planned "to refine controller models" (p. 18). The rules in §3.3 are stated, not measured. `rantanen2012conflictManeuvers` and `kirwan2001coraStrategies` are the measured sources on controller behaviour.
- **The 23 percent rejection figure** (p. 16) is an estimate of what would happen without ADS-B traffic information, built by adding the requests TASAR filtered out to those rejected.
- **Not independent** of `prior-work-writeup.md` §12 (Mogford et al. 2016), which summarizes the same program.
- Per-flight figures are from one airline, one fleet family (737), three summer months.

## Highlighted passages

_38 digital highlights by the owner, extracted 2026-10-09 via `tools/extract_pdf_annotations.py`. No typed comments and no ink annotations._

- **Abstract (p. 3):** the comparison of historical trajectories with and without TASAR; 8,000 to 12,000 gallons and 900 to 1,300 minutes saved per aircraft per year; more than $5 million from fuel, maintenance and depreciation; the wind-optimal switch as the highest-benefit use case.
- **Introduction (p. 6):** the three use cases of the earlier study; the four user types it assessed (network, low cost, regional, business jet); "Network carriers saved, on average, 543 lbs of fuel (about 80 gallons) per flight and about 3.6 minutes per flight"; ADS-B Out equipage "did not significantly impact benefits" but lower adoption "caused controllers to receive more TASAR requests that may cause conflicts".
- **Use cases (p. 7):** "Aircraft in these initiatives are sometimes not shifted back to user-preferred routes after the initiative has ended"; "a strategic route change" (as opposed to a tactical heading change); "a lateral trajectory change consisting of one or two named waypoints"; the wind-optimal trajectory change.
- **Data sources and platform (pp. 7–8):** the National Traffic Management Log for reroute initiatives; NEXRAD reflectivity for convective weather; FACET, two instances, one as simulator of the current state and one as predictor used "to test TASAR aircrew requests for conflicts with surrounding aircraft, conflicts with airspace hazards, and to calculate the impacts ... on user time and fuel objectives"; traffic from historical ASDI data; alternate trajectories flown through aircraft performance models with historical RUC winds.
- **Optimization model (p. 8):** evaluation every five minutes from top of climb to 200 NM from destination against "a 50% fuel / 50% time objective", with advisories rejected if they increased either; "The use of voice for aircrew requests limited the alternative lateral trajectories to changing one or two named waypoints"; the three alternate altitudes; "Climbing was only permitted if the aircraft was at flight level (FL) 350 or below to be conservative since aircraft weight was not modeled in the simulation"; lateral, altitude and combined changes.
- **Request model (p. 9):** the eight-minute probe with "a conservative ten nmi lateral and 1,000 ft vertical minimum separation shell"; "the conflict probe did not have access to flight plans and instead relied on state projections using current heading, vertical rate, and speed"; "Multiple requests in a sector are unreasonable and the aircrew waits until the next sector"; handoff status within about 20 NM of the sector boundary, where a request "is likely to be met with the response to make the request to the next sector controller".
- **Controller evaluation (p. 10):** "The controller had more information about the surrounding traffic"; "beyond the sixty nmi assumed ADS-B range"; "aircrew request occurs in a sector that was experiencing traffic exceeding its monitor alert parameter value (i.e., a red sector)"; "The aircrew request was projected to enter an adjacent red sector"; "However, the area manager may instruct the controller not to send traffic through an adjacent sector if the adjacent sector is currently experiencing high traffic".
- **Results (p. 12):** "The expired reroute initiative had highest average benefit (103 gallons/operation, 7.8 min/operation) and the convective weather use cases had the lowest benefit (12 gallons/operation, 1.3 min/operation) with the wind use case falling in between (27 gallons/operation, 2.3 min/operation)."

Not highlighted: §4.3 (cost conversion), §5 (ATC impacts, including the 6 percent and 23 percent rejection figures and requests per sector per hour) and the appendices.

## Processing metadata

- **Read depth:** fully read
- **Date processed:** 2026-10-09
