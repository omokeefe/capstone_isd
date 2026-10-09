# Experiment options table and scoring (draft)

**Status: draft, no results.** Drafted by Claude on 2026-10-09 at the owner's request and revised the same day after two rounds of the owner's review. It is a companion to `knowledge/models/experiment-definition.md` and uses its cases A, B and C. Not report text. Every table cell that would hold a number is empty, because no simulation has been run.

**How to read the labels:**

- **Decide** marks an item that is the owner's call; what is written is a proposal.
- **Decided (owner, 2026-10-09)** records the owner's direction. These are logged in `decisions/decisions-log.md` as D-013 (first round), D-014 (second round) and D-015 (single aircraft type, emissions source, speed and arrival time).
- **[SME]** marks a figure or fact that rests on the owner's own industry experience and has no cited source.

**Where the owner's review notes are:**

- First hand review, of the experiment definition: `projects/nas-sos-capstone/handwritten/2026-10-09-experiment-definition-hand_review.md`. Called "first review" below, with its note number.
- Second hand review, of this file: `projects/nas-sos-capstone/handwritten/2026-10-09_experiment-options-and-scoring_round_2.md`. Called "second review" below, with its note number.

## What this file answers

| First review note | What it asked for | Where |
|---|---|---|
| 9.2 | A table of options: each aircraft and the maneuvers needed | §2 |
| 6.2 | The table of outcomes at four levels, one row per case | §3 |
| 10.2 | A cost/benefit equation per viewpoint that accounts for connections and schedule | §4 |
| 6.1 | Fuel counted as money and as emissions | §4.1, §4.2 |
| 8.1 | Workload as three things: clearances issued, effort to devise them, residual risk; possible cases D/E/F | §4.3, §5 |
| 6.2 | What the system column holds; "aggregating the other 3 w/ a weighting?" | §4.4 |

## 1. The four aircraft

`knowledge/models/experiment-definition.md` §3 fixes the shape: one crossing pair, two aircraft in trail that block some level changes, two of the four from one airline (one late with connections, one early). The assignment below was proposed in the first draft. In the second review (notes 1.2 and 1.3) the owner set the crossing pair as a B777 and a 737, and later the same day replaced that with one type for both.

| Aircraft | Role in the picture | Airline | Type and weight | What makes it different |
|---|---|---|---|---|
| AC1 | Crossing pair, at level L | X | B737-900 MAX, heavy for the type; weight not set | Late, with passenger connections at the destination. |
| AC2 | Crossing pair, at level L | Y | B737-900 MAX, light for the type; weight not set | On time. |
| AC3 | In trail, 2,000 ft below L, under the crossing point | X | Not set | Early. Same airline as AC1. |
| AC4 | In trail behind AC3, same level as AC3 | Z | Not set | Nothing special. It is context. |

**A figure of the scenario is needed** (second review, notes 1.1 and 1.8). The owner's sketch shows AC4 and AC3 in trail, AC1 on its own track, and AC2 crossing. Not drawn yet. The figure has to respect the level rule in §2: for both crossing aircraft to be at the same level, both tracks must fall in the same half of the compass.

**Why this assignment:**

- **A heavy AC1 and a light AC2 give "which one descends" a cost-based answer the controller cannot see.** The owner confirmed this conclusion (second review, note 1.5). The first draft also claimed that a heavy aircraft is nearer its optimum at the lower level. The owner struck that claim (note 1.4): at the lower altitude the heavier aircraft flies faster to hold the level, which means more drag. What `mori2022massCruise` Fig. 1 supports is narrower: for one aircraft type, the cost-optimal altitude is lower when the aircraft is heavier. Whether a descent helps or hurts a given aircraft depends on where L sits against that aircraft's own optimum. The truth model has to settle it; this file no longer assumes the direction.
- **AC1 late with connections** sets up a case where fuel says one thing and schedule says another (first review, note 10.2).
- **AC3 from the same airline as AC1** is what makes the airline column differ from the aircraft column. An option that slows or moves AC3 to make room costs airline X on its early flight and helps it on its late one. If no airline has two aircraft touched by an option, the airline column is just the aircraft column again.
- **AC3 and AC4 below the crossing point** make the level below L matter, and they limit how well a speed change can work (second review, note 1.7).

The alternative is to put both of airline X's flights in the crossing pair. That makes the airline's preference very clear (move the early one, protect the late one) but removes the question of fairness between airlines from the main pair.

**One aircraft type to start. Decided (owner, 2026-10-09):** both crossing aircraft are the B737-900 MAX (the owner's name for the type; Boeing's is 737 MAX 9, or 737-9). With one type, case B's nominal model gives the two aircraft the same weight and cannot tell them apart. Everything case C adds then comes from the shared weight and cost index, which is the comparison the experiment is built to make.

**What the choice of type shows, to be acknowledged in the report (owner, 2026-10-09).** How much the outcome changes when the types and weights in the scenario change is itself a finding. It indicates how widespread the issue is across real traffic, and it is an argument for an architecture that lets models of different fidelity be swapped in and out. The two-type pair first chosen (a 600,000 lb B777 and a 105,000 lb 737) is kept as a later variation for that reason. In that variation, case B already tells the pair apart by type, and a B777 burns several times the fuel of a 737, so what sharing weight adds is smaller.

**The two weights are not set (Decide).** They need to be a heavy and a light value for this one type. The 105,000 lb given earlier for a 737 is close to the empty weight of a 737 MAX 9, so it does not carry over. [C] `knowledge/models/experiment-definition.md` §3 proposes spreading weights by the published 4.5 to 7 percent standard deviation of take-off weight; that is one way to choose them.

## 2. Options table

One row per resolution option, one column per aircraft, each cell the maneuver that aircraft is given. A dash means no instruction. This is the owner's sketch (first review, note 9.2), extended with three columns: the instructions it costs the controller now, the follow-up it creates, and what the decider would need to know to be sure the option works.

| Option | AC1 | AC2 | AC3 | AC4 | Instructions now | Follow-up later | What the decider must know to use it |
|---|---|---|---|---|---|---|---|
| O1 | Descend 2,000 ft | – | – | – | 1 | 1 if AC1 can be cleared back up; otherwise 0 and a fuel penalty for the rest of the cruise | Nothing about the aircraft. Blocked if AC3 or AC4 is under the crossing point at that level. |
| O2 | – | Descend 2,000 ft | – | – | 1 | Same as O1, for AC2 | Same as O1. |
| O3 | Climb 2,000 ft | – | – | – | 1 | 0 or 1 (return to L only if needed) | Whether AC1 can climb: its weight, or the maximum altitude its FMS computes. Without that, allowed only at or below FL350. |
| O4 | – | Climb 2,000 ft | – | – | 1 | 0 or 1 | Whether AC2 can climb. Same rule. |
| O5 | Turn to pass behind AC2 | – | – | – | 1 | 1 (resume own navigation), plus monitoring | Crossing times, to size the turn. |
| O6 | – | Turn to pass behind AC1 | – | – | 1 | 1, plus monitoring | Same as O5. |
| O7 | Change speed, within ±0.04 Mach | – | – | – | 1 | 1 (resume speed), plus monitoring | The aircraft's usable speed range. Built to fail in this scenario; see below. |
| O8 | Descend 4,000 ft, below AC3 and AC4 | – | – | – | 1 | Same as O1 | Nothing about the aircraft. Larger fuel penalty. |
| O9 | Descend 2,000 ft | – | Slow or turn, to open a gap | – | 2 | 2 | Used only if O1 is blocked. This is the one option that touches airline X twice. |

**The re-climb is not guaranteed** (second review, notes 1.9 and 2.5). After a descent the aircraft is either cleared back up, which is a second instruction, or it stays low and pays a fuel penalty for the rest of the cruise. Which one happens depends on the traffic above it later. The scoring has to carry both outcomes for O1, O2 and O8.

**Speed is set up to fail. Decided (owner, 2026-10-09; second review, note 2.1).** The distances and speeds in the scenario are chosen so that a speed change within ±0.04 Mach cannot separate the pair. ±0.04 Mach is the owner's figure [SME]. O7 stays in the table as one row to show the lever was considered. Failing to separate the pair at the crossing point is a different matter from what the same speed change does to arrival time if it is held; that is in §4.2. Published work agrees on the direction: speed "seldom succeeds" for a cruise crossing and loses effect inside six minutes (Erzberger 2006, summarized in `evidence/prior-work-experiment-definition/prior-work-writeup.md`).

**Altitude options and the climb rule. Decided (owner, 2026-10-09): start from the TASAR study's set.**

- **Three altitude options per aircraft:** 2,000 ft above, 2,000 ft below, and 4,000 ft below the assigned altitude (`engility2014tasarAlaska`, p. 8). O1 to O4 and O8 are these three applied to the crossing pair.
- **Climb rule:** "Climbing was only permitted if the aircraft was at flight level (FL) 350 or below to be conservative since aircraft weight was not modeled in the simulation" (same page). So a climb is offered only when the aircraft is at or below FL350.
- **The authors' reason, which the report should include** (second review, note 2.2): they were being conservative because their simulation did not model aircraft weight. An aircraft high in its cruise may be too heavy to climb further, and without the weight the tool cannot tell. That is the same gap this experiment measures.
- **How to describe the rule.** It is the TASAR authors' modeling assumption for a cockpit tool making requests. It is not an FAA rule and not measured controller behaviour. Cite it as an assumption adopted from that study, with its reason.

**Who the rule binds, and where the crossing pair sits. Decided (owner, 2026-10-09):**

1. **The FL350 rule does not bind case C.** Case C has the weight and the models, so it judges each climb from the aircraft's own weight. The owner: "that is exactly the point."
2. **The crossing pair sits high enough that the rule closes climbs to cases A and B.** The published rule permits a climb at exactly FL350, so the pair has to be above FL350.
3. **Levels are 2,000 ft apart for one direction of flight: eastbound on odd levels, westbound on even** [SME]. The owner's direction (second review, note 2.7): take this as fact for now. It matches the TASAR study's 2,000 ft steps.
4. **Two candidate levels (Decide; second review, note 2.3):**
   - an eastbound pair at FL370, where the climb is to FL390;
   - a westbound pair at FL380, where the climb is to FL400.

   The level should be one where the climb is out of reach for the heavy aircraft and within reach for the light one. Otherwise case C gets the same answer for both and the weight shows nothing. The owner's arrival-time arithmetic (§4.2) uses 38,000 ft, which points to FL380. The type's certified ceiling is 41,000 ft [C], so FL400 is inside it for a light aircraft.

A variation with the pair at or below FL350, where every case can climb, is left for later.

**Sources for the option set and the counts** (the owner wants these in the report; second review, note 2.4):

- The three levers (altitude, vector, speed) are from `knowledge/models/experiment-definition.md` §4. They are the same in every case. The TASAR study uses two of them, lateral and altitude changes and their combination (`engility2014tasarAlaska`, p. 8); it does not use speed.
- Altitude steps and the climb rule are from `engility2014tasarAlaska`, p. 8, as above.
- Instruction and follow-up counts follow the accounting in `fothergill2013resolutionHeuristics` (pp. 72–74): a descent is one instruction now and a second later to re-climb; "point behind" is one instruction and "set and forget"; passing in front is "very time consuming to calculate and monitor", so it is left out.
- Controllers' own account agrees with the direction of the climb rule: "No point asking aircraft to climb if they come back and say they can't" (same source, p. 73). `rantanen2012conflictManeuvers` observed 6 climbs in 36 level-crossing cases, so climbs are used, but less than descents.

**Which option each case can pick:**

| Case | What it knows | Options open to it | How it chooses |
|---|---|---|---|
| A | Today's information: type, level, speed, route | O1, O2, O5, O6, O8 always. O3 and O4 only if the aircraft is at or below FL350. O7 closed: the usable speed range is unknown. | The baseline rule: one descent. Which of the two crossing aircraft descends, AC1 or AC2, is still open (`knowledge/models/experiment-definition.md` §5). |
| B | A nominal model: one weight per type | All nine, with O3 and O4 under the same FL350 rule. | Lowest estimated cost using the nominal model. Both aircraft are the same type, so the model gives them the same weight and cannot tell AC1 from AC2. |
| C | Shared weight and cost index | All nine. O3 and O4 judged from the aircraft's own weight; the FL350 rule does not apply. | Lowest estimated cost using each aircraft's own weight and cost index. |
| D | Case C plus the airline's connection information (§5) | Same as C | Lowest estimated cost including the connection term in §4.2. |

**A point for the report** (second review, note 3.2): in the later variation at or below FL350, case A may climb, but its rule is "one descent". The climb is open to it and it does not take it. That is consistent with the observed preference for descents (`rantanen2012conflictManeuvers`), and saying so keeps the baseline from looking hobbled.

## 3. Outcome tables

Two tables. The first scores every option. The second is the one the owner asked for: one row per case.

### 3.1 Every option, scored at four levels

One truth model scores all nine rows (`knowledge/models/experiment-definition.md` §7). Cells are empty until that model exists. **All four aircraft are listed** (decided; second review, note 3.3), and the largest cost in each row is marked.

| Option | Feasible? | Cost to AC1 | Cost to AC2 | Cost to AC3 | Cost to AC4 | Airline X (AC1 + AC3) | Airline Y (AC2) | Airline Z (AC4) | Sector: clearances / effort / risk | System (§4.4) |
|---|---|---|---|---|---|---|---|---|---|---|
| O1 | | | | | | | | | | |
| O2 | | | | | | | | | | |
| … | | | | | | | | | | |
| O9 | | | | | | | | | | |

### 3.2 One row per case (first review, note 6.2)

Each case picks one row of table 3.1. This table shows which one, and what it cost at each level, as a difference from case A.

| Case | Option chosen | Aircraft (AC1 / AC2 / AC3 / AC4, largest marked) | Airline (X / Y / Z) | Sector (clearances / effort / risk) | System (§4.4) |
|---|---|---|---|---|---|
| A: rule, today's information | | reference | reference | reference | reference |
| B: automation, nominal model | | | | | |
| C: automation, shared weight and cost index | | | | | |
| D: case C plus connection information | | | | | |

**How to read it:**

- **B minus A** is what automation is worth. **C minus B** is what sharing weight and cost index is worth. **D minus C** is what sharing connection information is worth.
- **Read across a row** to see whether an option that is better at one level is worse at another. That is the sub-system against system question.
- **Every aircraft's cost is shown.** An average would hide who pays.
- **One variation is included on purpose where C picks the same row as A** (similar weights and cost indexes), to show the comparison is not rigged (`knowledge/models/experiment-definition.md` §8).

## 4. One cost/benefit statement per viewpoint

Each column of the outcome table needs its own stated measure. These are written to be computed by hand or in a spreadsheet for nine options; none needs a solver.

### 4.1 Aircraft (one flight)

For aircraft *i* and one option, compared with flying on undisturbed:

- **Extra fuel:** ΔF_i, in kg. From the truth model.
- **Extra time:** ΔT_i, in minutes.
- **Cost in fuel-equivalent units:** ΔC_i = ΔF_i + CI_i × ΔT_i, with the cost index CI_i in kg of fuel per minute. This is the cost-index form in `mori2022massCruise` (Eq. 1–3), applied to a difference. Multiply by the fuel price for dollars.
- **Emissions:** ΔE_i = k × ΔF_i, in kg of CO2, with k = 3.16. The source is ICAO's calculator methodology: "3.16 = constant representing the number of tonnes of CO2 produced by burning a tonne of aviation fuel" (`icao2024icecMethodology`, p. 6). The owner accepted ICAO's calculator as the source (2026-10-09). Only this constant is used here; the calculator's own estimate of fuel per passenger is not.

**Known criticisms of the ICAO calculator, to acknowledge in the report where appropriate:**

- **It counts CO2 only.** ICAO says so itself: the calculator "does not quantify the climate change impact of aircraft emissions using the Radiative Forcing Index (RFI) or other such multipliers", because the scientific community "has not yet reached consensus" (ICAO calculator FAQ). Other calculators multiply by about 1.9 to 3 to cover effects such as contrails. This is the criticism that touches this experiment: effects other than CO2 depend on altitude, and the options here are altitude changes. [C] for the altitude point; it needs a source.
- **Its results sit at the low end** when calculators are compared, and the calculators disagree with each other. Leads, not read in full and not registered: an IATA report on discrepancies between calculators; a 2025 review comparing the ICAO and EUROCONTROL estimators that reports average differences from about 2 to 28 percent; a 2020 travel-footprint paper (arXiv 2004.05603).
- **Its fuel estimate is generic.** The methodology states its own limits: great-circle distance with a fixed correction, load factors by route group from 2016 traffic, and no allowance for differences between aircraft of one type (`icao2024icecMethodology`, §5). These do not affect this experiment, which takes fuel from its own truth model.

**No sweep over cost index (proposed; second review, note 4.1).** The owner asked whether a range of cost indexes has to be tested, noting that this is not an optimization paper. It does not. One fixed cost index per aircraft, set by the scenario, is enough to show whether the shared value changes the choice. The one variation with similar values (§3.2) covers the case where it does not.

**How emissions enter. Decided (owner, 2026-10-09):** CO2 is reported in kg at every level. At the airline level it is also converted to dollars, so the report can say what it means to the airline in concrete terms (§4.2). At the system level it stays in kg of CO2, with a social cost quoted for scale (§4.4).

### 4.2 Airline (all of its flights that an option touches)

ΔC_airline = Σ (ΔF_i + CI_i × ΔT_i) + Σ K_i × [arrival delay of *i* crosses its threshold] + Σ p × ΔE_i

The three terms are fuel and time, connections, and emissions in dollars.

**Why the connection term is there.** Delay cost is not a straight line in time: it jumps at missed connections, crew limits and curfews (`projects/nas-sos-capstone/journal/2026-10-04.md`, from the prior-work reading). A cost index is a flat rate, so it understates a connection-critical flight. Dispatchers rated schedule integrity first and crew connections second among ten factors, with fuel in a tied group behind them.

**Source of the ten-factor ratings (found; second review, note 4.3).** Figure 7 of Sheth, Gutierrez-Nolasco, Courtney and Smith, "Simulations of Credits Concept with User Input for Collaborative Air Traffic Management", held as `evidence/sources/sheth-et-al-2012-simulations-of-credits-concept-with-user-input-for-collaborative-air-traffic-management.pdf`, PDF p. 11. Two limits from the same page: the ratings are "an aggregate of all the scenarios" from five dispatchers, and "the average rating values are not statistically significant." The PDF is not yet registered, so it has no bib key to cite.

**The threshold.** Arrival slots are typically 10 to 15 minutes apart [SME], so what matters is whether an option moves a flight across one (second review, note 4.2).

**What a speed change does to arrival time (owner's arithmetic, 2026-10-09, checked).** Take the intervention 1,000 NM from the destination, at 38,000 ft and Mach 0.80, in still air, with the new speed held for the rest of the flight:

| Speed | True airspeed | Time over 1,000 NM | Difference from Mach 0.80 |
|---|---|---|---|
| Mach 0.80 | 458.9 kt | 130.8 min | reference |
| Mach 0.79 | 453.1 kt | 132.4 min | 99 s later |
| Mach 0.76 | 435.9 kt | 137.6 min | 6.9 min later |
| Mach 0.84 | 481.8 kt | 124.5 min | 6.2 min earlier |

- The owner's figures (458.86 and 453.13 kt, about 100 s per 0.01 Mach, about 6.6 minutes for 0.04) check out. Scaling the 100 s by four gives 6.6 minutes; computed directly it is 6.9 minutes slower and 6.2 minutes faster, because time goes as one over speed.
- **Why it matters:** arrival time is already uncertain. A flight running 5 to 10 minutes early that gains another 6 minutes can land outside its slot. So a speed resolution can cost a slot even when its fuel cost is small.
- **How it enters. Decided (owner, 2026-10-09):** it is acknowledged in the report even if it is not definitively included in the costs.
- **This corrects an earlier statement in this file,** that one resolution costs a flight only seconds to a couple of minutes. That holds for a maneuver that is undone once the conflict has passed. It does not hold for a speed change kept for the remaining distance.
- **Two limits on the table.** It assumes the new speed is held for all 1,000 NM; a controller's speed instruction usually ends when the conflict has passed. And the fast side may not be available: Mach 0.84 is above the type's maximum operating Mach number, which is 0.82 [C], leaving +0.02 Mach, about 3.2 minutes.

The scenario still has to state how early or late each flight is on entry, because the result depends on it.

**The value of K.** It depends on the passenger count and the crew schedule, and will be hard to quantify per flight even though the sources hold aggregate data (second review, note 4.4). The owner's candidate method: total nationwide cost of missed connections divided by the number of occurrences. Neither number is held yet. Until one is, K stays a symbol and the table reports the yes/no: does this option cause a missed connection?

**Emissions in dollars. Decided (owner, 2026-10-09; second review, notes 4.7 to 4.10):**

| Route | What p means | Where it is used | What it still needs |
|---|---|---|---|
| 1. Carbon credits | The price of a credit covering one kg of CO2 under the international aviation offsetting scheme (CORSIA) | **The airline column.** | A dated price from a citable source. The scheme covers international flights; applying its price to a U.S. domestic flight is an assumption the owner accepted ("OK to assume their approach") and the report should state it as one. |
| 2. Passenger value | Revenue the airline loses when passengers choose a lower-emission flight | **The discussion.** The owner's position: it is money lost, and airlines publish emissions because passengers care. | A study that measures how emissions listings change booking choices. The owner's own practice of choosing lower-emission listings is the motivation, not the evidence. One decision in one sector does not change the listing a passenger saw when booking; the link is the airline's average over many flights. |
| 3. Social cost of carbon | The estimated damage to society from one more kg of CO2 | **The system column** (§4.4). | A government or peer-reviewed estimate, with its year and discount rate. The first draft called this "the usual one in public analysis" without a source; that statement is withdrawn until one is found. |

**A point to make in the report.** Fuel burned is already counted once as fuel cost. Pricing its CO2 counts the same kilograms a second time, on purpose. A carbon price adds a fixed amount to the cost of every kg of fuel, so it makes fuel weigh more against time. It can change the cheapest option only where fuel and time pull in different directions.

**A question for the report's discussion** (second review, note 4.11): controllers' usual practice gives schedule the priority. A carbon price pushes the other way, toward fuel. Is schedule the right priority?

### 4.3 Sector (the controller's workload)

The first review (note 8.1) names three parts. They are kept as three reported items and not added up, because they are in different units.

| Part | What it is | Proposed measure | Source of the measure |
|---|---|---|---|
| Clearances issued | How many times the controller keys the microphone for this conflict | Instructions now plus follow-ups later, from the options table | `fothergill2013resolutionHeuristics` |
| Effort to devise | How much work it takes to arrive at the resolution | A three-step scale: (1) a rule applied from memory; (2) a mental estimate of times or performance; (3) proposed by automation and checked by the controller | Steps 1 and 2 follow Fothergill's descriptions. Step 3 is an assumption about cases B, C and D. |
| Residual risk | How likely the resolution is to need fixing after it is issued | Separation margin at closest approach under the prediction error the decider has. Vertical resolutions hold up under along-track error; speed resolutions are the most exposed to it. | `projects/nas-sos-capstone/journal/2026-10-04.md` (AIM speed tolerances; `bilimoria2004stateVectorProbe`) |

**Why three items.** `knowledge/models/experiment-definition.md` §8 says a different maneuver means "more workload". That is true of clearances issued. It is not true of effort to devise if automation proposes the maneuver, and residual risk can go either way: better information lowers it, a more delicate maneuver raises it. So an option can be "more workload" on one line and "less" on another, and the table should show that.

**What "automated decision" means. Decided (owner, 2026-10-09; second review, note 5.1):** the automation proposes one resolution, the controller checks it and issues it. Clearances issued are then counted the same way in every case, and the difference between cases shows up in effort and risk. The owner also described how the chain could run from the cockpit: an electronic flight bag application with ATC information leads the crew to make a request over data link (CPDLC), the request is checked automatically on the ground, and the controller issues the clearance. That is recorded as a possible realization, not as a second case.

**Sector loading as a condition.** `engility2014tasarAlaska` (p. 10) models controllers as refusing requests that do not fit their plan once the sector is over its Monitor Alert Parameter. The same idea applies here: in a busy sector, a resolution with follow-ups costs more than in a quiet one. Running the scenario once quiet and once near the parameter is a candidate variation; it is not needed for the first table. For the report's discussion, the owner's question (second review, note 5.2): are refusals more likely in morning rushes at hub airports or near holidays? That is a hypothesis; no source is held.

### 4.4 System

**What the system column stands for. Decided (owner, 2026-10-09; second review, notes 5.5 and 6.1):** it is a measure of the airspace as a whole system of systems. It is defined by its own cost statement, below, and the report should explain it by pointing to that statement. It does not map to one part in the context diagram; the other three columns do (the aircraft and its crew; the airline operations center; the ATC sector).

**The cost statement. Decided (owner, 2026-10-09): impacts are stated independently, with no weighted sum at first.** For each option the system column holds, side by side:

- total fuel over all four aircraft, in kg;
- total CO2 over all four aircraft, in kg, with a social cost of carbon quoted beside it for scale and labelled as a cost nobody in the scenario pays;
- total airline cost over all airlines;
- the sector's three workload items;
- the largest cost to any one aircraft.

**Why not one weighted number.** Someone has to choose the weights, and no stakeholder in the model owns that choice. A single number also hides the trade between levels, which is what the table exists to show, and adding aircraft and airline costs counts fuel twice. A weighted sum is not ruled out for later. If one is added, compute it for two or three sets of weights and show whether the ranking changes; if it does, that is a finding: the "system optimum" depends on who sets the weights. The owner likes this check (second review, note 5.3).

**An optional extra column: is the option on the Pareto front? (Decide.)** The first draft called this "dominance" and the owner did not follow it (second review, note 5.4). The owner's analogy is exact. An option is on the Pareto front if no other option is at least as good on every item above and better on at least one. An option off the front is one that nobody should pick, because some other option beats or matches it everywhere. The column would hold a yes or a no. It needs no weights, and it does not choose among the options that are on the front. The owner noted it is an opportunity for a figure: the nine options plotted on two of the items, with the front drawn through the ones that are not beaten.

## 5. Case D: connection information as a further level

**Decided (owner, 2026-10-09; second review, note 4.5):** connection information is added as a level of shared information. The owner's reason: ATC and airports can exchange it through SWIM, the FAA's information-sharing network [SME], and whether it is included or left out is exactly the kind of parameter this study varies.

- **Case D is case C plus the airline's connection information:** for each flight, how close it is to its connection threshold.
- **Making it a separate case, and not part of case C, is Claude's reading of the note.** It keeps "what weight and cost index are worth" (C minus B) apart from "what connection information is worth" (D minus C). If the owner meant it to be part of case C, the D row folds into C.
- **To check:** who would publish the information. Connection status is the airline's information, not the airport's or ATC's, so the exchange needs an airline as its source.

**Not added:** cases that vary who does the work (the other reading of "Might need D/E/F" in the first review, note 8.1). That is fixed by the assumption in §4.3.

## 6. Abstractions made here, and why

| Abstraction | Why | Risk |
|---|---|---|
| Four aircraft, one snapshot, nine discrete options | Small enough to enumerate and to explain in one table. Published controller studies used static pictures of five to ten aircraft (`kirwan2001coraStrategies`, `fothergill2013resolutionHeuristics`). | Leaves out what happens downstream of the sector. |
| Workload as counts and a three-step scale | These can be read off the options table without a human-performance model. | The scale's third step is assumed, not sourced. |
| Connection cost as a step (K or 0) at a 10 to 15 minute slot boundary | It is the simplest form that is not a straight line. The slot spacing is the owner's [SME] figure. | K is unsourced. The result depends on how late AC1 already is. |
| Altitude options of +2,000, −2,000 and −4,000 ft, and no climb above FL350 without the weight | Adopted from `engility2014tasarAlaska` (p. 8) at the owner's direction. It is a published, simple set, and the climb limit has a stated reason (weight not modeled) that matches the gap this experiment measures. | It is that study's modeling assumption for cockpit requests, not a rule controllers follow. One fixed threshold for every type and weight is coarse. |
| One aircraft type for the crossing pair (B737-900 MAX) | It isolates what shared weight and cost index add, because the nominal model cannot tell two aircraft of one type apart. | Results will change with type and weight. The owner wants that sensitivity acknowledged as evidence of how common the issue is; a two-type variation is kept for later. |
| Speed changes limited to ±0.04 Mach, and the scenario built so they fail | The owner's [SME] figure. It removes a lever that published work says rarely works for a cruise crossing. | The figure is unsourced; a reviewer may ask why the lever is listed at all. |
| A CORSIA credit price applied to a U.S. domestic flight | It gives the airline a dollar figure for CO2 from a real scheme. | The scheme does not cover domestic flights; the price is borrowed. |
| System column defined by its cost statement, not by one model part | It measures the airspace as a whole system of systems; no single part owns the outcome. | A reviewer may ask who the system-level stakeholder is. |

## 7. What has to exist before a cell can be filled

1. **The truth model** (`knowledge/models/experiment-definition.md` §7): fuel flow as a function of weight, altitude and speed. Everything in §4.1 depends on it, and so does the heavy-against-light question in §1.
2. **The scenario numbers:** the heavy and light weights for the crossing pair; type and weight for AC3 and AC4; cost index and schedule slack for all four; how early or late each flight is on entry; the geometry, with distances and speeds that make ±0.04 Mach insufficient.
3. **The scenario figure** (§1).
4. **The baseline tie-breaker** (`knowledge/models/experiment-definition.md` §5): which of AC1 and AC2 case A descends.
5. **Sources to register:**
   - the Sheth et al. credits-concept paper (held, not registered);
   - a CORSIA credit price. No working link is held. Trade-press reports put it at about 10 to 22 dollars per tonne during 2025 and 2026; those are not ICAO figures;
   - sources for the criticisms of the ICAO calculator listed in §4.1, if the report uses them;
   - a passenger-choice study, a social cost of carbon, and a nationwide cost and count of missed connections. No leads yet.
6. **The Decide items still open in this file:** the heavy and light weights for the crossing pair (§1); FL370 or FL380 for the crossing pair (§2); whether to add the Pareto-front column (§4.4); whether case D is separate from case C (§5).

A scope note: §4 is as far as the scoring should go as a capability inside the architecture. The owner's own note says the same: this is not an optimization paper, it is an exploration of what interchangeable models are worth. If the next step looks like tuning weights or searching a larger option space, that is the pull to flag.
