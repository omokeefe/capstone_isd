# Irregular Airline Operations: A Review of the State-of-the-Practice in Airline Operations Control Centers

- **File:** `references/Irregular airline operations a review of the state-of-the-practice in airline operations control centers.pdf`
- **Bib key:** `clarke1998irregular`
- **Authors:** Clarke, Michael Dudley Delano
- **Year:** 1998
- **Venue:** Journal of Air Transport Management, Vol. 4, pp. 67-76
- **DOI:** none (pre-DOI era) — Elsevier PII S0969-6997(98)00012-X

## What it is

The foundational overview of the Airline Operations Control Center (AOCC): its structure
(Maintenance Operations Control Center, Station Operations Control Centers), the primary
causes of irregular operations (weather, mechanical failures), the decision-support systems
in use at the time, and a new decision framework for schedule recovery — based on field
trips to US and international carriers.

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 — the exact paper that section is
  built around, and cited as the "first overview" by later reviews (including
  `hassanDisruptionReview` in this same register, which explicitly credits Clarke 1998 as
  the origin point of this literature).
- Decomposition / architecture (§6, §10): the AOCC/MOCC/SOCC structure and the airline
  controller's manual decision process are directly usable for OCC-related architecture
  elements and responsibility swimlanes.
- Stakeholder / objective ontology (§7-§9): identifies the airline controller as the
  decision authority for irregular-ops resolution and quantifies cost impact (e.g. a single
  1996 snowstorm cost the US airline industry $50-100M) — concrete evidence for §8's
  cost/penalty categories.
- Glossary / terminology: AOCC, MOCC, SOCC, ARINC/SITA networks.

## Rating

**5/5** — foundational, directly-cited-by-later-literature source for §4; despite its age
(1998), it establishes the baseline vocabulary and structure that every later disruption-
management paper in this register builds on.

## Flags

None — bib entry completed with volume/pages from the PDF; no DOI exists for this
pre-DOI-era article (PII used instead).

## Highlighted passages

_Digital highlights/underlines/comments the user marked up in the PDF, extracted 2026-09-14 via `tools/extract_pdf_annotations.py`. Ink/handwritten annotations (226 found) not extracted -- not requested._

**Page 1**
- **Highlight:** "The impact of irregular airline operations on the daily activities of a carrier can lead to significant loss in profitability"
- **Highlight:** "an overview of the Airline Operations Control Center is presented"
- **Highlight:** "existing decision support tools and solution methodologies"
- **Highlight:** "1998"
- **Highlight:** "he cause of the irregularity may range from severe weather conditions to aircraft breakdowns, and it may result in the need to reschedule flight services, and re- route aircraft and crews. These actions cause flight delays and cancellations which affect passenger services, and disrupt aircraft maintenance routing"

**Page 2**
- **Highlight:** "The decision maker will be trying to assign operational (available) aircraft to the most valuable flights, while meeting maintenance re- quirements of all operational aircraft"
- **Highlight:** "For a typical airline, approximately ten percent (10%) of its scheduled revenue flights are affected by irregulari- ties, with a large percentage being caused by severe weather conditions and the associated loss of airport capacity"
- **Highlight:** "the financial impact of irregularities on the daily operations of a single major US domestic carrier can exceed $440 million per annum in lost revenue, crew overtime pay, and passenger hospi- tality costs."
- **Highlight:** "In an article published in the Handbook of Airline Economics, it was stated that on average 0.1—0.2% of a typical airline’s flights were interrupted due to maintenance problems. In addition, an equal average 0.1—0.2% of that same airline’s flights will experi- ence irregularities due to weather problems."
- **Highlight:** "During the late spring of 1995, a severe hailstorm over the Dallas-Forth Worth airport resulted in the damage of nearly 100 aircraft parked at the terminals (Aviation Week, 8 May, 1995). In fact, 80 of these damaged aircraft belonged to American Airlines, accounting for nearly 9% of its total fleet. In the immediate aftermath of this irregularity, American Airlines had to cancel almost 10% of its scheduled flights, and needed almost an entire month to return to normal operations. In January 1996, it was estimated that a single snowstorm, the ‘‘Blizzard of ‘96’’ costs the US airline industry between $50 and $100 million (Aviation Week, 1/15/96). On a daily basis, air- lines have to cope with reduced fleet size, as a result of aircraft breakdowns, as well as external factors such as ATC flow management restrictions."
- **Highlight:** "the Schedule of Services), and is established by the Commercial/ Marketing depart- ment"
- **Highlight:** "Operations group then generates the Nominal Operational Schedule (NOS)"
- **Highlight:** "aircraft rotations and crew rotations"
- **Highlight:** "subsequently schedules specific airline resources by as- signing tail numbers, and individual crew members to a given flight"
- **Highlight:** "Resource Operational Schedule (ROS),"
- **Highlight:** "resource allocation steps are carried out by various airline groups. The reader is referred to Grandeau (1994)"
- **Highlight:** "Execution scheduling is the process of executing the system resource schedules on a daily basis."
- **Highlight:** "xecuting the pre-planned schedules, updating the schedules for minor operational deviations, and re- routing for irregular operations."
- **Highlight:** "three main activities: e"
- **Highlight:** "The tactical operations of a regular scheduled air carrier are usually under the 24 h/day control of a central organization often referred to in generic terms as the Airline Operational Control Center (AOCC), although it may have a different name at each airline."
- **Highlight:** "During the process of operation control, the AOCC is supported by the Maintenance Operations Control Center (MOCC) which controls airline mainten- ance activities, and by various Station Operations Con- trol Centers (SOCC) which control station resources (gates, refuelers, catering, ramp handling, and passenger handling facilities)."
- **Highlight:** "Operations Control Centers are usually linked to the Aeronautical Radio Inc. (ARINC) and the Societe International Telecommunications Aeronautiques (SITA) networks to send and receive teletype/telex messages."
- **Highlight:** "Communications with maintenance and engineering, customer service, and airport services are maintained"
- **Underline:** "Aeronautical Radio Inc. (ARINC"
- **Underline:** "Societe International Telecommunications Aeronautiques (SITA"
- **Underline:** "send and receive teletype/telex messages."
- **Underline:** "approximately ten percent (10%) of its scheduled revenue flights are affected by irregulari- ties, w"
- **Underline:** "0.1—0.2%"
- **Underline:** "maintenance problems"
- **Underline:** "0.1—0.2%"
- **Underline:** "weather problems."
- **Underline:** "tactical operations"
- **Underline:** "under the 24 h/day control of a central organization"
- **Underline:** "Airline Operational Control Center (AOCC),"
- **Underline:** "Station Operations Con- trol Centers (SOCC"
- **Underline:** "Maintenance Operations Control Center (MOCC"
- **Underline:** "s)."
- **Underline:** "andling facilities"
- **Underline:** "gates, refuelers, catering, ramp handling, and passenger h"
- **Highlight:** "Teletype, telex, facsimile, telephone, leased lines, and public data networks combine to provide an effective medium for collecting information and communicating revised operational plans developed by the AOCC center"
- **Highlight:** "VHF, HF and Satcom radio links, air traffic control centers, and other relevant locations"

**Page 3**
- **Highlight:** "Operation Controllers are responsible for maintaining the current operational version of all the system resource schedules (crew, aircraft and flight), and for the management of irregular operation"
- **Highlight:** "s may have a dedicated airline Air Traffic Control"
- **Highlight:** "(ATC) coordinator,"
- **Highlight:** ", to deal with Air Traffic Flow man- agement advisories from the ATC system."
- **Underline:** "to deal with Air Traffic Flow man- agement advisories"
- **Highlight:** "the MOCC and the several SOCC’s are usually not physically located at the centra"
- **Highlight:** "l AOCC."
- **Highlight:** "Current Operational Schedules’’ (COS)"
- **Highlight:** "deferred minimum equipment list [MEL] or configuration deviation list [CDL] items)"
- **Highlight:** "aircraft restrictions (such as noise), the availability of required operational support (fuel, gates, ground power, airport facilities) at the departure, destination and alternate airports"

**Page 4**
- **Highlight:** "Nominal Schedule of Services"
- **Highlight:** "review of flight delays"
- **Highlight:** "field trips were made to existing airline opera- tions control centers"
- **Highlight:** "an extensive survey questionnaire"
- **Highlight:** "the current ‘‘rule-of-thumb’’ u"
- **Highlight:** "Air Traffic Operating Management System (ATOMS) database system contains the number of scheduled flights delayed more than 15 min by cause of delay (e.g. weather, and air traffic control volume) and by airport"
- **Highlight:** "The following list summarizes the major categories of irregularities as established by the ATOMS program. They are: z Weather — Wind, fog, thunderstorm, low cloud ceiling. z
z Equipment — Air traffic radar/computer outage. z
z Runway — Unavailable because of construction, surface repair, disabled aircraft. z Volume — Aircraft movement rate exceeds capacity of the airport at a given time. z Other — Anything excluding weather, volume, runway, and equipment"
- **Highlight:** "severe weather and traffic volume account for 93%"
- **Highlight:** "marginal correlation between the overall level of aircraft movement at an airport and the level of flight delay experienced."
- **Highlight:** "highest percentages of delays were experienced in January and July"

**Page 5**
- **Highlight:** "ystem Operations Ad- visor’’ (SOA)"
- **Highlight:** "SOA system consists of three primary components: the Status Monitor, the Delay and Swap Advisor, and the Delay or Cancellation Advisor"
- **Underline:** "subsystem"
- **Underline:** "alert"
- **Underline:** "United"
- **Highlight:** "criti- cal departure times, mission compatibility, and system balance in the daily flight cycle"
- **Highlight:** "The airline’s primary goal in the aftermath of irregularities is to return to the operational schedule as soon as possible, regardless of its impact to potential revenues. The controllers consider the number of passengers booked on a given flight seg- ment instead of the actual value of the flight. In resolving irregularities, the airline controllers subjectively incor- porate passenger flow issues such as connectivity, good- will, and volume of traffic, into the decision process. The airline has identified crew scheduling as the im- portant parameter in the resolution of irregularities in the network, and consequently, most aircraft substitu- tions are done within a given fleet"
- **Highlight:** "any decision which min- imizes downstream effects in schedule variation, and pro- vides a feasible resolution in a timely fashion"
- **Highlight:** "Inconven- ienced Passenger Rebooking System"
- **Highlight:** "Severe Weather Action Plan"

**Page 6**
- **Highlight:** "they may in fact compromise revenue opera- tions, which could have occurred without the influence of the prevailing irregularities"
- **Highlight:** "designed to match operations with the level of reduced airport capacity, while ensuring that net revenue contributions are maximized, as well as minimizing cus- tomer inconvenience, and disruptions to crew and main- tenance scheduling"
- **Underline:** "recover safely, and efficiently to normal operations as soon as physically possible, in the after- math of the irregularity"

## Processing metadata

- **Read depth:** skimmed (pages 1-2, abstract + intro + AOCC overview)
- **Date processed:** 2026-08-29
