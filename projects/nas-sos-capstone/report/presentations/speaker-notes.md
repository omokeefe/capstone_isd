# Speaker notes — ISD 503 peer presentation, Thu 2026-11-19, 10 AM

For the deck `503 Project Presentation - O'Keefe (210055806) - NAS SoI.pptx`, slides 1 to 7. The deck's notes pane is the master copy: this file mirrors it in the owner's wording, as saved 2026-11-17 20:11. The course asks for about 10 minutes; the times are the targets in the notes. **[click]** marks an animation step, in the order the deck plays them. Text under **Backup** is not spoken; it is there for questions.

## Slide 1 — Title (0:20)

Good morning. I'm Owen O'Keefe. My capstone models the National Airspace System, the NAS: everything that moves an airliner from gate to gate in the United States. I model it as a system of systems, meaning independently owned and operated systems (air traffic control, airlines, airports, the aircraft and their crews) that together produce one result, a flight. The subtitle is the thread through the whole project: how an airline's business objectives become the path an aircraft actually flies.

## Slide 2 — Project Overview (1:45)

At the highest level, my project develops a reference Model-Based Systems Engineering (MBSE) architecture of the U.S. National Airspace System (NAS), focused on how intent is communicated and translated into operational decisions. Its purpose is to demonstrate how a publicly accessible MBSE model can identify suboptimal operations and evaluate opportunities for improvement.

The project makes two central claims:

- More accurate and complete information enables better operational decisions.
- A traceable reference architecture exposes information gaps, identifies ownership, and enables identification of where system improvements could support better outcomes.

I evaluate these claims through a single use case: an air traffic controller proactively resolving an impending loss of separation between two aircraft. The analysis examines how varying information fidelity influences the controller's decision and the resulting tradeoffs among stakeholder objectives.

**[click]** *(scenario sketch)*

The scenario involves two aircraft cruising at 38,000 feet on converging trajectories: AC1 heading west toward Los Angeles and AC2 northwest toward Denver.

Existing conflict-detection systems typically alert controllers up to 20 minutes before a predicted loss of separation. Controllers must then select a resolution, often relying on rules of thumb without detailed knowledge of aircraft performance or the economic consequences for each airline.

The reference MBSE architecture identifies the relevant interfaces, traces decision and data ownership, and exposes unmet information requirements. It also supports evaluating alternative decision models—from conceptual assumptions to nominal and actual aircraft mass—without changing the underlying architecture.

## Slide 3 — Project Scope and Deliverables (0:45)

The project covers the execution of standard systems-engineering work, from end to end. That includes identifying stakeholders, itemizing their needs, and their requirements, decomposing those into system requirements, defining a model architecture (context, internal block, activity and sequence diagrams), analyzing the system, and performing verification and validation of the requirement set.

To control scope, five constituent systems are modeled in detail: air traffic control, airline flight operations, airports, the aircraft, and the flight crew. Regulators and passengers sit at the boundary. As such, they set constraints, but are not broken down into detailed models.

Two deliverables are produced: a SysML v2 model, along with renderings that would be produced by a typical MBSE tool with a graphical user interface; and the project report.

## Slide 4 — Methodology (1:00)

The method is, plainly, the execution of model-based systems engineering.

Four top-level efforts are executed.

- The generation of stakeholder objectives and their trace down through requirements into a reference MBSE architecture.
- Verification of those requirements through test cases enacted by the model.
- Simulation of an example use case’s ability to efficiently resolve a conflict, scored using model instantiations, using an open aircraft performance model – OpenAP.
- Validation that the conflict scenario as a whole tests whether MBSE meets the customer's real needs by finding and fixing inefficiencies in the airspace.

**[click]** *(both arrows)*

On ISD's M diagram, the arrows show where this project sits: the human-centered front end, understanding the stakeholders and their context, and then down the left leg, from stakeholder objectives through system and subsystem requirements to component-level design and its verification.

## Slide 5 — Preliminary Results (3:30)

So far, these efforts have produced artifacts that support both of the original claims, including:

**[click 1]** *(power/interest grid)* — **1. The identification of stakeholders and their objectives.** Mapped by power and interest. Crews, airlines and ATC are the key stakeholders; governments and regulators set the context.

**[click 2]** *(NAS decomposition)* — **2. Deconstruction of the System of Interest into constituent systems.** The entire NAS was broken down and cut into the five systems that bear on the study.

**[click 3]** *(requirements trace)* — **3. Authoring requirements required to obtain stakeholder objectives.** 30 Requirements documenting stakeholder needs were traced to 42 requirements on the NAS as a whole. 23 of these were further decomposed into 31 requirements imposed on the constituent systems, with bi-directional tracing maintained.

**[click 4]** *(context diagram)* — **4. Models were generated of each constituent system** and how they connect.

**[click 5]** *(sequence diagram)* — **5. The sequence diagram enabled identifying the information gap.** This diagram shows the conflict being resolved, message by message. The circled message, the airline sharing the aircraft's performance with ATC's decision support, does not exist today. The model makes the gap visible: who decides, who holds the data, and the missing link between them.

**[click 6]** *(route map)* — **6. Three alternatives to today’s methods were tested** on one example conflict: an Orlando to Los Angeles flight crossing a Houston to Denver flight over Texas. Four cases. Case A is today: the controller's rule of thumb. B, C and D are the three alternatives:

- B is decision support with a generic aircraft model;
- C adds the airline's real data, the aircraft's weight and the airline's cost of time;
- D adds the airline's connection priorities on top of C.

These alternatives come out of the model, through a requirement to weigh each option's impact on NAS stakeholders. The requirement says what has to be done, not how well, so it can be met by each of the 4 cases.

**[click 7]** *(envelope chart)* — This chart shows why the information matters. The diagram shows the flight envelope for a heavier 737 MAX 9 at 38,000 feet. The red dot represents the current operational state of the example aircraft prior to conflict identification. The black dots and white Xs represent the state the aircraft would have to maintain if it followed the controller clearance issued in each of the cases. The two white Xs show that it cannot climb 2,000 feet or speed up; both fall outside its envelope. Only a descent or a slowdown is left for it.

**[click 8]** *(results table)* — The table shows the cost at four levels of the NAS. From left to right: the worst-off aircraft, the airline, the sector, and the system. The sector's cost is the controller's workload: the clearance calls, the mental effort, and the risk that the resolution needs fixing. The system column is the fuel and emissions that matter to regulators and the community. Two lines I’ll highlight: Today’s practices are represented by case A, which chooses to descend AC2 4,000 feet, costing an additional 41 kg of fuel. When informed with the airline's data, case C sees that AC2 can climb 2,000 feet, which reduces the aircraft cost to 12 kg. In C and D the aircraft is likely to stay at the higher, more efficient flight level, so one controller call does it. This actually saves the flight 27 kg from resolution to landing.

### Backup (not spoken)

These are the results attained when the various options are simulated, as might be enabled by a decision aid. Today’s practice, case A, chooses to descend AC2 4,000 feet, costing an additional 41 kg of fuel. Case B, which is an automation without high fidelity information, can’t reliably determine a better solution, so it makes the same choice and costs 41 kg. When informed with the airline's data, case C sees that AC2 can climb 2,000 feet, which reduces the aircraft cost to 12 kg. Case D, which is informed with passenger connection information, makes the same choice as C, because no connection was at risk in this example. Cases A and B take two radio calls, down and back up. In C and D the aircraft is likely to stay at the higher, more efficient flight level, so one call does it. Remaining at the new altitude for the remainder of the flight results in additional fuel savings not shown on this table – specifically 39 kg, making it 27 kg better off than if there had been no conflict, or almost 90 kg of CO2 in entirety. The controller's effort also changes: a rule from memory in A against reviewing an automated proposal in B to D.

The table presents the costs realized at different levels of the NAS. When looked at through the perspective of the individual aircraft or airline, the cost is an intuitive measure. However, it’s not the only consideration made in resolving conflicts. Controllers often operate in chaotic environments and there is a non-zero cost to workload that varies. The cost added at the sector level shows the number of ATC-to-crew clearance calls required to enact the resolution, a unitless estimate of the mental effort involved in its enaction, and the risk that the resolution clearance will be rejected. On the far right of the table is the system-level measure of the fuel and environmental impact, which is important to the regulator and community boundary stakeholders.

## Slide 6 — Project Benefits (1:30)

In this one example, against today's rule of thumb, the high-fidelity case cuts each of these costs by about 70%:

- **The worst cost to any single aircraft is reduced.** This keeps the airline measures of pilot performance from being negatively impacted; a fix that pushes the cost onto one aircraft could meet resistance from flight crews.
- **The airline’s overall cost is reduced.** That provides an incentive to the airline to share its performance data. Which would require it to pay for securing and transmitting the data, as well as ensuring its accuracy.
- **System fuel and emissions are reduced,** which serve national goals and the system's longevity.

That is claim one: better information, better decision. Automation with generic data does no better than today's rule here, so the whole gain comes from the airline's real data: system fuel falls from 41 kg to 12 kg.

*(chart)* This is only one conflict. On the right are the FAA's counts of losses of separation by en-route centers: 679 in fiscal 2024, over a thousand the year before. Those are only the conflicts that ended in a loss of separation. The conflicts controllers resolve in time are far more common, so a per-conflict saving like this one recurs many times a year.

It is not free. The controller reviews a proposal from decision support instead of applying a rule from memory. And airlines have to share data specific to each aircraft (its weight, its performance, the airline's priorities), which they treat as competitive. The project assumes that exchange can be secured with existing infrastructure such as the FAA's System Wide Information Management (SWIM) network; securing it is outside this study.

*If asked "how much would this save nationally?"* The FAA source counts losses of separation, not conflicts resolved, so the 70% cannot be multiplied by 679. The chart shows how often the problem reaches the point of failure; it is a floor, not a total.

## Slide 7 — Thank you (Q&A)

Thank you. I'm happy to take questions.
