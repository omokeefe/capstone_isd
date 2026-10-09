# Experiment options table and scoring (draft)

**Status: draft, nothing decided, no results.** Drafted by Claude on 2026-10-09 at the owner's request, from the owner's hand review of the experiment one-pager (`projects/nas-sos-capstone/handwritten/2026-10-09-experiment-definition-hand_review.md`). It is a companion to `experiment-definition.md` and uses its cases A, B and C. Not report text. Every table cell that would hold a number is empty, because no simulation has been run. Items marked **Decide** are the owner's call; what is written is a proposal. Items marked **Decided (owner, 2026-10-09)** record the owner's direction on this draft and are logged as D-013.

## What this file answers

| Hand-review note | What it asked for | Where |
|---|---|---|
| 9.2 | A table of options: each aircraft and the maneuvers needed | §2 |
| 6.2 | The table of outcomes at four levels, one row per case (A/B/C) | §3 |
| 10.2 | A cost/benefit equation per viewpoint that accounts for connections and schedule | §4 |
| 6.1 | Fuel counted as money and as emissions | §4.1 |
| 8.1 | Workload as three things: clearances issued, effort to devise them, residual risk; possible cases D/E/F | §4.3, §5 |
| 6.2 | What the system column holds; "aggregating the other 3 w/ a weighting?" | §4.4 |

## 1. The four aircraft (Decide)

The one-pager fixes the shape: one crossing pair, two aircraft in trail that block some level changes, two of the four from one airline (one late with connections, one early). It does not say which aircraft is which. The tables need that, so here is one assignment.

| Aircraft | Role in the picture | Airline | What makes it different |
|---|---|---|---|
| AC1 | Crossing pair, at level L | X | Late, with passenger connections at the destination. Heavy for its type. |
| AC2 | Crossing pair, at level L | Y | On time. Light for its type. |
| AC3 | In trail, 2,000 ft below L, under the crossing point | X | Early. Same airline as AC1. |
| AC4 | In trail behind AC3, same level as AC3 | Z | Nothing special. It is context. |

**Why this assignment:**

- **AC1 heavy and AC2 light** makes the baseline's default costly. A heavy aircraft is nearer its optimum at the lower level; a light one loses more by descending (`mori2022massCruise`, Fig. 1). So "which one descends" has a cost-based answer the controller cannot see.
- **AC1 late with connections** sets up a case where fuel says one thing and schedule says another. That is the point of note 10.2.
- **AC3 from the same airline as AC1** is what makes the airline column differ from the aircraft column. An option that slows or moves AC3 to make room costs airline X on its early flight and helps it on its late one. If no airline has two aircraft touched by an option, the airline column is just the aircraft column again.
- **AC3 and AC4 below the crossing point** make the level below L matter. Without them the two in-trail aircraft do no work (journal 2026-10-04, "details still to settle").

The alternative is to put both of airline X's flights in the crossing pair. That makes the airline's preference very clear (move the early one, protect the late one) but removes the question of fairness between airlines from the main pair.

## 2. Options table

One row per resolution option, one column per aircraft, each cell the maneuver that aircraft is given. A dash means no instruction. This is the owner's sketch from note 9.2, extended with three columns: the instructions it costs the controller now, the follow-up it creates, and what the decider would need to know to be sure the option works.

| Option | AC1 | AC2 | AC3 | AC4 | Instructions now | Follow-up later | What the decider must know to use it |
|---|---|---|---|---|---|---|---|
| O1 | Descend 2,000 ft | – | – | – | 1 | 1 (clear AC1 back up) | Nothing about the aircraft. Blocked if AC3 or AC4 is under the crossing point at that level. |
| O2 | – | Descend 2,000 ft | – | – | 1 | 1 (clear AC2 back up) | Same as O1. |
| O3 | Climb 2,000 ft | – | – | – | 1 | 0 or 1 (return to L only if needed) | Whether AC1 can climb: its weight, or the maximum altitude its FMS computes. Without that, allowed only at or below FL350. |
| O4 | – | Climb 2,000 ft | – | – | 1 | 0 or 1 | Whether AC2 can climb. Same rule. |
| O5 | Turn to pass behind AC2 | – | – | – | 1 | 1 (resume own navigation), plus monitoring | Crossing times, to size the turn. |
| O6 | – | Turn to pass behind AC1 | – | – | 1 | 1, plus monitoring | Same as O5. |
| O7 | Reduce speed | – | – | – | 1 | 1 (resume speed), plus monitoring | The aircraft's usable speed range, and enough time before the crossing point. |
| O8 | Descend 4,000 ft, below AC3 and AC4 | – | – | – | 1 | 1 | Nothing about the aircraft. Larger fuel penalty. |
| O9 | Descend 2,000 ft | – | Slow or turn, to open a gap | – | 2 | 2 | Used only if O1 is blocked. This is the one option that touches airline X twice. |

**Altitude options and the climb rule. Decided (owner, 2026-10-09): start from the TASAR study's set.**

- **Three altitude options per aircraft:** 2,000 ft above, 2,000 ft below, and 4,000 ft below the assigned altitude (`engility2014tasarAlaska`, p. 8). O1 to O4 and O8 are these three applied to the crossing pair.
- **Climb rule:** "Climbing was only permitted if the aircraft was at flight level (FL) 350 or below to be conservative since aircraft weight was not modeled in the simulation" (same page). So a climb is offered only when the aircraft is at or below FL350.
- **What this replaces.** The earlier draft closed climbs to case A on the strength of a controller quotation and left "usable level" without a number. Both are now set by one sourced rule.
- **Where the rule comes from matters for how it is described.** It is the TASAR authors' modeling assumption for a cockpit tool making requests. It is not an FAA rule and not measured controller behaviour. The report should cite it as an assumption adopted from that study.

**Who the rule binds, and where the crossing pair sits. Decided (owner, 2026-10-09):**

1. **The FL350 rule does not bind case C.** The study's reason for the rule is that weight was not modeled. Case C has the weight and the models, so it judges each climb from the aircraft's own weight. The owner: "that is exactly the point."
2. **Start with the crossing pair high enough that the rule closes climbs to cases A and B.** Climbs are then closed to A and B and open to C. This is the direct demonstration that missing information removes options.
3. **One detail to settle.** The owner's direction was "at or above FL350". The rule as published permits a climb at exactly FL350 ("FL 350 or below"), so at FL350 cases A and B could still climb. To close climbs the pair has to be above FL350. Which level is a **Decide**; it also has to be a level the scenario's direction of flight uses, and one from which a 2,000 ft climb is within reach for the light aircraft and out of reach for the heavy one, or the result is the same for both.

A variation with the pair at or below FL350, where every case can climb, is left for later.

**Sources for the option set and the counts:**

- The three levers (altitude, vector, speed) are the one-pager's §4. They are the same in every case.
- Altitude steps and the climb rule are from `engility2014tasarAlaska`, p. 8, as above.
- Instruction and follow-up counts follow the accounting in `fothergill2013resolutionHeuristics` (pp. 72–74): a descent is one instruction now and a second later to re-climb; "point behind" is one instruction and "set and forget"; passing in front is "very time consuming to calculate and monitor", so it is left out.
- Controllers' own account agrees with the direction of the climb rule: "No point asking aircraft to climb if they come back and say they can't" (same source, p. 73). `rantanen2012conflictManeuvers` observed 6 climbs in 36 level-crossing cases, so climbs are used, but less than descents.
- Speed (O7) is kept as one row. It "seldom succeeds" for a cruise crossing and loses effect inside six minutes (Erzberger 2006, in `prior-work-writeup.md`). Expect it to be infeasible in most variations; one row is enough to show that.
- The 2,000 ft step still needs one check against JO 7110.65BB: that levels 2,000 ft apart are the ones assigned to a single direction of flight at these altitudes. Not yet looked up.

**Which option each case can pick:**

| Case | What it knows | Options open to it | How it chooses |
|---|---|---|---|
| A | Today's information: type, level, speed, route | O1, O2, O5, O6, O8 always. O3 and O4 only if the aircraft is at or below FL350. O7 closed: the usable speed range is unknown. | The baseline rule: one descent. Which aircraft is the one-pager's §5 **Decide**. |
| B | A nominal model: one weight per type | All nine, with O3 and O4 under the same FL350 rule. Below FL350 it judges a climb with the nominal weight, so it can be wrong. | Lowest estimated cost using the nominal model. With one weight per type and no cost index it cannot tell AC1 from AC2 if they are the same type. |
| C | Shared weight and cost index | All nine. O3 and O4 judged from the aircraft's own weight; the FL350 rule does not apply (decided). | Lowest estimated cost using each aircraft's own weight and cost index. |

One consequence to check when the baseline rule is settled: at or below FL350 case A may climb, but its rule is "one descent". The climb is open to it and it does not take it. That is consistent with the observed preference for descents, and it should be said in the report so the baseline does not look hobbled.

## 3. Outcome tables

Two tables. The first scores every option. The second is the one the owner asked for: one row per case.

### 3.1 Every option, scored at four levels

One truth model scores all nine rows (one-pager §7). Cells are empty until that model exists.

| Option | Feasible? | Aircraft: cost to AC1 | Aircraft: cost to AC2 | Aircraft: largest cost to any one aircraft | Airline X (AC1 + AC3) | Airline Y (AC2) | Sector: instructions / who devises / margin | System (§4.4) |
|---|---|---|---|---|---|---|---|---|
| O1 | | | | | | | | |
| O2 | | | | | | | | |
| … | | | | | | | | |
| O9 | | | | | | | | |

### 3.2 One row per case (the owner's table, note 6.2)

Each case picks one row of table 3.1. This table shows which one, and what it cost at each level, as a difference from case A.

| Case | Option chosen | Aircraft (largest cost to any one aircraft) | Airline (each airline's total; X and Y shown separately) | Sector (instructions / who devises / margin) | System (§4.4) |
|---|---|---|---|---|---|
| A: rule, today's information | | reference | reference | reference | reference |
| B: automation, nominal model | | | | | |
| C: automation, shared weight and cost index | | | | | |

**How to read it:**

- **B minus A** is what automation is worth. **C minus B** is what the information exchange is worth.
- **Read across a row** to see whether an option that is better at one level is worse at another. That is the sub-system against system question.
- **The aircraft column reports the worst-off aircraft, not the average.** An average hides who pays.
- **One variation is included on purpose where C picks the same row as A** (similar weights and cost indexes), to show the comparison is not rigged (one-pager §8).

## 4. One cost/benefit statement per viewpoint

Each column of the outcome table needs its own stated measure. These are written to be computed by hand or in a spreadsheet for nine options; none needs a solver.

### 4.1 Aircraft (one flight)

For aircraft *i* and one option, compared with flying on undisturbed:

- **Extra fuel:** ΔF_i, in kg. From the truth model.
- **Extra time:** ΔT_i, in minutes.
- **Cost in fuel-equivalent units:** ΔC_i = ΔF_i + CI_i × ΔT_i, with the cost index CI_i in kg of fuel per minute. This is the cost-index form in `mori2022massCruise` (Eq. 1–3), applied to a difference. Multiply by the fuel price for dollars.
- **Emissions (note 6.1):** ΔE_i = k × ΔF_i, in kg of CO2, where k is the mass of CO2 produced per kg of jet fuel burned. The commonly used value of k is about 3.16; it has no source in the repository yet and needs a citation before use. [C]

**How emissions enter. Decided (owner, 2026-10-09):** CO2 is reported in kg at every level. At the airline level it is also converted to dollars, so the report can say what it means to the airline in concrete terms. At the system level it stays in kg of CO2, and the report discusses what it means for society and for how passengers see the flight. The conversion method is in §4.2 and is not yet chosen.

### 4.2 Airline (all of its flights that an option touches)

- **Sum of its aircraft:** Σ ΔC_i over that airline's aircraft.
- **Plus a connection term for each flight:** K_i if the option pushes the flight's arrival past its connection threshold, otherwise 0.

ΔC_airline = Σ (ΔF_i + CI_i × ΔT_i) + Σ K_i × [arrival delay of *i* crosses its threshold]

**Why the second term is there.** Delay cost is not a straight line in time: it jumps at missed connections, crew limits and curfews (journal 2026-10-04, from the prior-work reading). A cost index is a flat rate, so it understates a connection-critical flight. Dispatchers rated schedule integrity and crew and passenger connections at or above fuel (the ten-factor table in journal 2026-10-05; which paper it comes from is still unconfirmed).

**What it needs:** for each flight, how much slack it has before the threshold, and a value for K. For AC1 (late, with connections) the slack is small; for AC3 (early) it is large. K has no source yet. A workable first pass is to leave K as a symbol and report the yes/no: "does this option cause a missed connection?"

**What this adds to case C (Decide).** As written, case C shares weight and cost index only. The connection term uses information C does not share. Either the experiment scores with it but decides without it, which will show the cost index falling short, or a fourth information level is added. See §5.

**Emissions in dollars, for the airline.** The airline's cost gains a third term: ΔC_airline = Σ (fuel and time) + Σ (connection) + Σ p × ΔE_i, where p is dollars per kg of CO2. The open part is what p stands for. The owner named two routes, carbon credits and passenger value; a third is listed because it is the usual one in public analysis.

| Route | What p means | What the airline actually experiences | What it needs before use | Caution |
|---|---|---|---|---|
| 1. Carbon credits | The price the airline pays, or would pay, for a credit or allowance covering one kg of CO2 | A cash cost, where a scheme applies to the flight | Which scheme applies to a U.S. domestic flight, and a dated price from a citable source | The international offsetting scheme (CORSIA) covers international flights, and the European trading scheme covers flights within Europe. Neither is known to apply to a U.S. domestic flight, so for this scenario the price may be a voluntary or internal one. To be confirmed from a source. [C] |
| 2. Passenger value | Revenue the airline gains or loses because some passengers choose the lower-emission flight | A demand effect, not a bill. It acts on bookings before the flight, not on the flight in the air. | A study that measures how emissions labels change booking choices or willingness to pay | The owner's own practice (choosing flights listed with lower emissions) is the motivation, and is one traveller's account, not evidence of a market effect. A tactical choice in one sector does not change the label a passenger saw when booking; the link is through the airline's average performance over many flights. |
| 3. Social cost of carbon | The estimated damage to society from one more kg of CO2 | Nothing directly. It is a cost the airline does not pay. | A government or peer-reviewed estimate, with its year and discount rate | This is a system-level number. Using it in the airline column would overstate what the airline feels. |

**Proposed (Decide):** route 1 for the airline column, because it is the one that is a real line in an airline's accounts where it applies. Route 2 goes in the discussion as the reason an airline might care beyond the credit price. Route 3 belongs with the system column (§4.4).

**A point to make in the report, whichever route is used.** Fuel burned is already counted once as fuel cost. Pricing its CO2 counts the same kilograms a second time, on purpose. A carbon price adds a fixed amount to the cost of every kg of fuel, so it raises the value of every fuel saving by the same proportion. It makes fuel weigh more against time, which can change the cheapest option only where fuel and time pull in different directions. Whether it does so here should be checked once a price is sourced.

**None of the three has a source in the repository.** This is new literature to find: a carbon price applicable to the flight, and a passenger-choice study. Both are candidates for `/process-references`.

### 4.3 Sector (the controller's workload)

Note 8.1 names three parts. They are kept as three reported items and not added up, because they are in different units.

| Part | What it is | Proposed measure | Source of the measure |
|---|---|---|---|
| Clearances issued | How many times the controller keys the microphone for this conflict | Instructions now plus follow-ups later, from the options table | `fothergill2013resolutionHeuristics` |
| Effort to devise | How much work it takes to arrive at the resolution | A three-step scale: (1) a rule applied from memory; (2) a mental estimate of times or performance; (3) proposed by automation and checked by the controller | Steps 1 and 2 follow Fothergill's descriptions. Step 3 is an assumption about cases B and C. |
| Residual risk | How likely the resolution is to need fixing after it is issued | Separation margin at closest approach under the prediction error the decider has. Vertical resolutions hold up under along-track error; speed resolutions are the most exposed to it. | Journal 2026-10-04 (AIM speed tolerances; `bilimoria2004stateVectorProbe`) |

**The point of note 8.1, restated.** The one-pager's result 3 says a different maneuver means "more workload". That is true of clearances issued. It is not true of effort to devise if automation proposes the maneuver, and residual risk can go either way: better information lowers it, a more delicate maneuver raises it. So an option can be "more workload" on one line and "less" on another, and the table should show that.

**An assumption cases B and C need written down (Decide).** "Automated decision" has to say who does what. Proposed: the automation proposes one resolution, the controller checks it and issues it by voice. Then clearances issued are counted the same way in all three cases, and the difference between cases shows up in effort and risk.

**Sector loading as a condition.** `engility2014tasarAlaska` (p. 10) models controllers as refusing requests that do not fit their plan once the sector is over its Monitor Alert Parameter. The same idea applies here: in a busy sector, a resolution with follow-ups costs more than in a quiet one. Running the scenario once quiet and once near the parameter is a candidate variation. It is not needed for the first table.

### 4.4 System

The owner's note asks whether the system column is the other three combined with weights. Three ways to fill it were considered:

| Way | What the cell holds | For | Against |
|---|---|---|---|
| 1. Weighted sum | One number: w_a × aircraft + w_l × airline + w_s × sector | One number is easy to rank | Someone has to choose the weights, and no stakeholder in the model owns that choice. A single number also hides the trade between levels, which is what the table exists to show. Aircraft and airline costs overlap, so adding them counts fuel twice. |
| 2. Things only visible at system level, side by side | Total fuel and total CO2 over all four aircraft; total airline cost over all airlines; the sector's three workload items; the largest cost to any one aircraft | No weights. Each item has an owner: total fuel and emissions matter to the public and the regulator, fairness to the airlines as a group, workload to the FAA. | No single ranking |
| 3. Dominance | A yes/no: is this option at least as good as another on every item and better on one? | Says which options no one should pick, without weights | Does not choose among the rest |

**Decided (owner, 2026-10-09):** state the impacts independently at first, which is way 2. A weighted sum is not ruled out for later. If one is added, compute it for two or three sets of weights and show whether the ranking changes; if it does, that is a finding: the "system optimum" depends on who sets the weights.

**Emissions at this level** are reported in kg of CO2, not dollars (§4.1). This is where the report discusses what the emissions mean for society and how passengers perceive a flight's emissions. A social cost of carbon (§4.2, route 3) can be quoted here to give the total a scale, labelled as a cost nobody in the scenario pays.

Way 3 (dominance) is still open as an extra column (**Decide**).

**What "system" stands for in the model.** The other three columns map to parts in the context diagram (the aircraft and its crew; the airline operations center; the ATC sector). The system column does not map to one part. The nearest are the FAA as service provider, and the public. This needs a sentence in the report, and it is the link back to D-004.

## 5. Cases D, E and F (note 8.1): a reading, not a proposal to add them

The note says "Might need D/E/F" without saying what they are. Two readings:

1. **A second thing varies: who does the work.** A, B and C vary what the decider knows. Workload depends on who devises and who issues the resolution. Crossing the two gives more cases (for example, C with the controller issuing by voice, and C with the clearance sent by data link).
2. **A further information level.** D would be case C plus the airline's connection or priority information, the thing §4.2 shows the cost index does not carry.

**Recommendation:** do not add cases yet. Fix "who does the work" as one written assumption (§4.3) so it does not vary. If one case is added, reading 2 is the one that serves the architecture claim, because it is a different information exchange and it ties to the owner's Sheth finding. Each added case multiplies the runs, and the one-pager's own warning applies: the first draft of this experiment changed three things at once.

## 6. Abstractions made here, and why

| Abstraction | Why | Risk |
|---|---|---|
| Four aircraft, one snapshot, nine discrete options | Small enough to enumerate and to explain in one table. Published controller studies used static pictures of five to ten aircraft (`kirwan2001coraStrategies`, `fothergill2013resolutionHeuristics`). | Leaves out what happens downstream of the sector. |
| Workload as counts and a three-step scale | These can be read off the options table without a human-performance model. | The scale's third step is assumed, not sourced. |
| Connection cost as a step (K or 0) | It is the simplest form that is not a straight line. | K and the thresholds are invented until sourced. |
| Altitude options of +2,000, −2,000 and −4,000 ft, and no climb above FL350 without the weight | Adopted from `engility2014tasarAlaska` (p. 8) at the owner's direction. It is a published, simple set, and the climb limit has a stated reason (weight not modeled) that matches the gap this experiment measures. | It is that study's modeling assumption for cockpit requests, not a rule controllers follow. One fixed threshold for every type and weight is coarse. |
| CO2 converted to dollars for the airline only | A credit price is a cost the airline can face; society's cost is not. | The price has no source yet, and may not apply to a U.S. domestic flight. |
| System column not mapped to one model part | No single part owns the system outcome. | A reviewer may ask who the system-level stakeholder is. |

## 7. What has to exist before a cell can be filled

1. **The truth model** (one-pager §7): fuel flow as a function of weight, altitude and speed. Everything in §4.1 depends on it.
2. **The scenario numbers:** type, weight, cost index and schedule slack for each of the four aircraft, and the geometry.
3. **The baseline tie-breaker** (one-pager §5): which aircraft case A descends.
4. **A level L for the crossing pair, above FL350** (§2), chosen so that a 2,000 ft climb is possible for one of the pair and not the other.
5. **Sources not yet held:** the CO2 factor k, a carbon price that applies to the flight, and a passenger-choice study (§4.2).
6. **The Decide items still open in this file:** the aircraft assignment (§1); the exact level of the crossing pair (§2); which route converts CO2 to dollars (§4.2); what "automated decision" means for who devises and issues the clearance (§4.3); whether to add a dominance column (§4.4).

A scope note: §4 is as far as the scoring should go as a capability inside the architecture. If the next step looks like tuning weights or searching a larger option space, that is the pull toward an optimization study that the project's working assumptions say to flag.
