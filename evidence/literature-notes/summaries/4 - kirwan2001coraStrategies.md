# Identification of Air Traffic Controller Conflict Resolution Strategies for the CORA (Conflict Resolution Assistant) Project

- **File:** `evidence/sources/Identification_of_air_traffic_controller_conflict_.pdf`
- **Bib key:** `kirwan2001coraStrategies`
- **Authors:** Barry Kirwan, Mary Flynn (EUROCONTROL Experimental Centre, Brétigny)
- **Year:** 2001
- **Venue:** 4th USA/Europe Air Traffic Management R&D Seminar, Santa Fe, 3–7 December 2001
- **DOI:** none found

## What it is

A conference paper (10 pp) reporting interim results of structured interviews with European en-route controllers about how they would resolve a standard set of conflict scenarios. It was done to design a resolution advisory tool around the controller's own way of thinking. It reports rules, principles and factors; it does not yet report which resolution was chosen for each scenario.

## Why it's valuable — and to what

- Literature review section: none of §2–§4. It serves the §11 experiment's baseline and scenario design.
- Decomposition / architecture (§6, §10): an earlier European study it cites found the best division of work is the machine advising and the controller accepting or rejecting (p. 2). Rules and practice differ by location, so a tool "will need to be tailored" per center.
- Stakeholder / objective ontology (§7–§9): the controller's stated aim is "to separate aircraft, and to do this first safely, and then expeditiously. Many rules appear sacrificial as long as these two requirements are met" (p. 4).
- Optimization study (§11–§13):
  - **How to structure the decision (Fig. 1):** a solution space of everything that works; formal rules that remove some options; "no-no's" that controllers would never do; principles that narrow the rest; and factors that fine-tune the pick.
  - **Scenario method:** static, minimally described scenarios on a simplified airspace map. The controller has to ask for whatever information matters to them, and the order of questions reveals the factors (the "with-held information technique").
  - **Two formats per scenario:** a plain two-aircraft conflict, then the same conflict with surrounding aircraft, "some of which 'blocked' certain resolutions." Six scenarios in both formats (catch-up, head-on, narrow-angle crossing, climb-through, descend-through, right-angle crossing with climb-through) plus two multi-conflict scenarios.
  - **Look-ahead:** 5 to 12 minutes for most centers; 8 to 14 for Shannon and Maastricht.
  - **Typically about three workable solutions** per simple scenario, ranked by the controller.
  - **Principles for who moves and how (Table 2, with the number of controllers citing each):**
    - Keep it simple (7).
    - "Penalise the one that needs something (leave alone the ones in steady state)" (6).
    - Check the other aircraft and rule them out (6).
    - Minimise the number of aircraft to move (3); look for one key action that resolves the situation (3).
    - Minimise the penalty for aircraft (3); inconvenience the fewest (1); "aim for a more global solution, not penalising anyone" (1).
    - Continuous climb and descent profiles are preferable (3); when complex, use vertical separation (2).
    - "Ask the pilot whether (s)he prefers a level change or a vector" (2).
    - Turn the slower aircraft behind, to minimise extra distance (1); better to put an aircraft behind than go through the middle (1).
    - At cruising altitude the speed envelope is small, "10–20 kts, therefore cannot change much" (1).
    - Level changes can introduce extra conflicts (1).
    - "Don't rely on climb performance above FL200" (cited in the text, p. 5).
  - **A no-no:** accelerating one aircraft to cut across in front of the other, even where the mathematics allows it (p. 3).
  - **Factors controllers asked about (Fig. 3, by share of citations):** type of aircraft (largest), destination, relative speed, non-nominal aircraft, distance to go, wind, rate of climb, aircraft performance, intentions now and later, availability of uncontrolled airspace, workload.
- Glossary / terminology: CORA, solution space, no-no, with-held information technique, ODL (opposite direction level), OFIR (open flight information region), semi-circular rule, cognitive tool.
- Other: 45 individual interviews across eight units in seven countries, plus six group sessions.

## The scenario excerpt (Figure 2, scenario 2b)

Saved as `attachments/kirwinn&flynn_airspace_scenario.png`. It shows five aircraft on a simplified map with sector exit points A to F, uncontrolled airspace (OFIR) on three sides and two military aerodromes. Each label gives callsign, flight level and exit point: DAL 275 at FL270 to exit C, DLH 473 at FL270 to exit A, AFR 253 at FL290, AIC 362 at FL280, and BMA 125 climbing from FL220 to FL310. Scenario 2 is the head-on case and "b" the version with surrounding traffic, so the conflict pair appears to be the two FL270 aircraft flying toward each other's entry points. That reading is inferred from the figure; the paper does not describe 2b in words.

## Rating

**4/5** — The fullest published list of controller rules of thumb and the information they ask for, with a scenario design the experiment can copy. Interim and qualitative, so not a 5.

## Flags

- **Interim results.** The paper says the resolutions actually chosen, the level of agreement, and the no-no's "remain... to be analysed."
- Most principles were cited by one to three controllers of 45. Treat them as examples, not consensus.
- European practice. The paper itself warns that practice varies by location.
- What controllers say they would do with a static picture and no time pressure can differ from what they do.
- The PDF's embedded title metadata is wrong (it names a different paper). No DOI.
- **Type of aircraft is the top factor and weight is not on the list.** Controllers use type as their proxy for performance, which is the information gap the experiment is about.

## Highlighted passages

Four digital highlights, all about the scenario design (pp. 1 and 3): seven countries and a standardised scenario set; scenarios drawn from the literature; scenarios made realistic and mapped onto a hypothetical airspace; six scenarios in two formats plus two multi-conflict ones.

## Processing metadata

- **Read depth:** fully read
- **Date processed:** 2026-10-04
