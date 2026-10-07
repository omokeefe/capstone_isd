# Experiment definition (one page)

**Status: draft, nothing decided.** Drafted by Claude on 2026-10-06 from the 2026-10-04 and 2026-10-05 journal discussions, at the owner's request. Every item marked **Decide** is the owner's call; the option written down is a proposal. Not report text.

## 1. Central claim (Decide)

**Proposed:** the architecture model can be checked, decision by decision, for one thing: does the actor who makes this decision receive the information the decision depends on? The experiment measures what one of the gaps found by that check costs. It is one worked example, not the main result.

**Alternative:** the four-aircraft experiment is the main result. This is weaker for three reasons. The expected effect is small (about 27 gallons and 2.3 minutes per flight in NASA's TASAR study). The value of sharing aircraft data with ATC has already been studied (Coppenbarger; SESAR's downlink of the aircraft's predicted profile). And the simulation compares two ways of operating, so it cannot test MBSE as an engineering method.

**What the proposed claim lets the project say about MBSE:** the benefit is any gap the check finds that the owner did not already know. The cost is the modeling time recorded in the journal and git history. If the check finds nothing new, the claim is the modest one: the model organized existing knowledge.

## 2. The gap being measured

An en-route sector controller resolves a crossing conflict between two aircraft in level cruise. Whether to climb or descend, and which aircraft to move, depends on each aircraft's weight. The controller does not receive weight or cost index (`schultz2012adaptiveClimb`, p. 2); the ground system assumes one nominal weight per aircraft type (`coppenbarger1999climbPrediction`). The airline and the FMS have the weight but not the authority.

## 3. Scenario

Four aircraft in one invented sector, shown as a single snapshot: one crossing pair, and two aircraft in trail that block some level changes. Two of the four belong to the same airline, one late with connections and one early. Weights are spread using the published 4.5 to 7 percent standard deviation of take-off weight. Each case picks from a short list of discrete maneuvers by enumeration; there is no solver.

## 4. The one thing that differs

What the decider knows. The available maneuvers (altitude, vector, speed) are the same in every case.

- **A:** rule-based decision with today's information.
- **B:** automated decision with a nominal aircraft model.
- **C:** automated decision with shared weight and cost index.

B against A is the value of automation. C against B is the value of the information exchange, which is the architecture claim.

## 5. Baseline rule

One descent clearance. This is the most common observed choice for this geometry: 23 of 36 cases in `rantanen2012conflictManeuvers`.

- **Which aircraft descends (Decide).** Proposed: leave the aircraft in steady state alone and move the one that already needs something (`kirwan2001coraStrategies`). If both are in steady cruise this rule does not choose, so a second rule is needed. Candidates are the published resolver tie-breakers (farthest from top of descent; not recently maneuvered).
- **After the descent (Decide).** Proposed: the aircraft is cleared back up later, counted as a second instruction.

## 6. Metrics

- Airline cost per aircraft: fuel plus time weighted by cost index (`mori2022massCruise`, Eq. 1–3).
- Controller workload: instructions issued plus follow-ups.
- Separation: a hard constraint, not a score.

Each option is scored at four levels (aircraft, airline, sector, system) in one table, with the largest penalty taken by any one aircraft reported alongside.

## 7. Truth model (Decide)

One model scores every case, at higher fidelity than the model any case used to decide. Not chosen. It must give fuel flow as a function of weight, altitude and speed. The existing `simulation/vehicle_dynamics.py` uses a constant placeholder fuel flow, so it cannot do this as it stands.

## 8. Possible results

1. Same answer as the baseline: the information is worth nothing here. One such case is included on purpose (similar weights and cost indexes).
2. Descend the other aircraft: lower cost at the same workload. The strongest result.
3. A different maneuver: lower cost, more workload.

## 9. Two checks before building anything

- **Effect size.** Rough first pass, by Claude, to be verified: `mori2022massCruise` reports about 1,000 ft of optimum altitude per 20,000 lb for a B787-8, which is roughly 4 to 5 percent of its weight. Two aircraft of one type at one standard deviation above and below the mean differ by 9 to 14 percent, so their optimum altitudes would differ by roughly 2,000 to 3,000 ft. That is more than one flight level, so the better aircraft to descend can plausibly change with weight. This assumes the B787 relation carries over to other types by percentage, which is unchecked, and it says nothing yet about how many pounds of fuel the wrong choice costs.
- **The check by hand** on three or four decisions already in the context diagram. Not done. The owner should do it, because the test is whether it turns up something the owner did not already know.

## 10. Known limits

- Level crossing conflicts are a minority: 36 of 256 in the U.S. data.
- Cost index understates a connection-critical flight, and dispatchers rate schedule integrity and connections above fuel (Sheth et al.; table source unconfirmed).
- Airlines could misreport what they share. Published gains from misreporting cost index are small (1 to 3 percent).
- The ±0.04 M speed figure is still unsourced.

## 11. For the adviser

- Which scope option (a, b or c)? This design sits near (b).
- What is the current-state metric?
- Is "one measured example under a model-wide check" an acceptable central claim for the capstone?
