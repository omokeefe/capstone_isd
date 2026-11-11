# Speaker notes — ISD 503 peer presentation, Thu 2026-11-19, 10 AM

For the deck `503 Project Presentation - O'Keefe (210055806) - NAS SoI.pptx`, slides 1 to 7. About 10 minutes in all; the times are targets. **[click]** marks an animation step, in the order the deck plays them. Written 2026-11-07 from the review in that day's session; edit freely, then paste each slide's notes into PowerPoint's notes pane.

## Slide 1 — Title (0:20)

Good morning. I'm Owen O'Keefe. My capstone models the National Airspace System, the NAS: everything that moves an airliner from gate to gate in the United States. I model it as a system of systems, meaning independently owned and operated systems (air traffic control, airlines, airports, the aircraft and their crews) that together produce one result, a flight. The subtitle is the thread through the whole project: how an airline's business objectives become the path an aircraft actually flies.

## Slide 2 — Project Overview (1:45)

*On arrival: the context diagram is showing.*

The goal is a reference MBSE architecture for how intent is managed across the NAS. Behind the text is the model's context diagram. It isn't meant to be read at this size; it shows the scale: every constituent system in the model and the exchanges between them.

The point of the project is that detailed, public MBSE documentation of the NAS, at full detail or abstracted, can be used to analyze NAS activities, find where they are suboptimal, and show how to improve them.

To demonstrate that, I look at how the fidelity of the information a decision-maker has changes the tradeoffs between stakeholders when something disrupts the plan.

Two claims. First, higher-fidelity information leads to a better decision: here, a better resolution of the same conflict. Second, the MBSE model is what finds the problem: it shows where the information is missing, who owns the decision, and who owns the data.

**[click]** *(scenario sketch)*

I demonstrate both with one example conflict. Two airliners at 38,000 feet are converging on the same point: AC1 heading west to Los Angeles, AC2 heading northwest to Denver. Two more aircraft are 2,000 feet below on the westbound track, which limits the options. A controller has to separate them, and today does it with a rule of thumb, without knowing either aircraft's weight or what each airline's time is worth.

## Slide 3 — Project Scope and Deliverables (0:45)

The project covers the systems-engineering work end to end: stakeholder needs and their requirements, system requirements, architecture definition (context, internal block, activity and sequence diagrams), system analysis, and verification and validation.

To keep it finishable, five constituent systems are modeled in detail: air traffic control, airline flight operations, airports, the aircraft, and the flight crew. Regulators, passengers and the military sit at the boundary: they set constraints, but they are not broken down.

Two deliverables: a SysML v2 model, written as text, so it is version-controlled and checked like code; and the project report.

## Slide 4 — Methodology (1:00)

The method is model-based systems engineering: a SysML v2 model written as text, and a Python simulation, both built in VS Code.

Four steps. Trace: stakeholder objectives become requirements and an architecture. Verify: each requirement has a test case in the model. Simulate: one example use case, resolving a conflict, scored across four cases with OpenAP, an open aircraft performance model. Validate: the conflict scenario as a whole tests whether MBSE meets the customer's real need, which is to find and fix inefficiencies in the airspace.

**[click]** *(both arrows)*

On ISD's M diagram, the arrows show where this project sits: the human-centered front end, understanding the stakeholders and their context, and then down the left leg, from stakeholder objectives through system and subsystem requirements to component-level design and its verification.

## Slide 5 — Preliminary Results (3:30)

*On arrival: the numbered list and the block diagram are showing.*

This slide walks through what the work has produced so far, in order.

**[click 1]** *(power/interest grid)* — **1. Stakeholders and their objectives.** Mapped by power and interest. Crews, airlines and ATC are the key stakeholders; governments and regulators set the context.

**[click 2]** *(NAS decomposition)* — **2. Constituent systems.** The whole NAS broken down, then cut to the five systems that bear on this decision. That cut is the block diagram that was showing when the slide opened.

**[click 3]** *(requirements trace)* — **3. Requirements.** Traced from stakeholder needs (30), to requirements on the NAS as a whole (42), to requirements on each constituent system (31). Each lower-level requirement names its parent, so any one of them traces back to the stakeholder who needs it.

**[click 4]** *(context diagram)* — **4. Models of each constituent system** and how they connect.

**[click 5]** *(sequence diagram)* — **5. The information gap.** This sequence shows the conflict being resolved, message by message. The circled message, the airline sharing the aircraft's performance with ATC's decision support, does not exist today. The model makes the gap visible: who decides, who holds the data, and the missing link between them.

**[click 6]** *(route map)* — **6. Three alternative approaches tested** on one example conflict: an Orlando to Los Angeles flight crossing a Houston to Denver flight over Texas. Four cases. Case A is today: the controller's rule of thumb. B, C and D are the three alternatives: B is decision support with a generic aircraft model; C adds the airline's real data, the aircraft's weight and the airline's cost of time; D adds the airline's connection priorities on top of C. These alternatives come out of the model: the requirement to weigh each option's impact says what has to be done, not how well, so it can be met by the rule or by decision support at each level of fidelity, and each level needs different data from the airline.

**[click 7]** *(envelope chart)* — Why the information matters. This is the heavier 737 MAX 9 at 38,000 feet. It cannot climb 2,000 feet or speed up; both fall outside its envelope. Only a descent or a slowdown is left for it.

**[click 8]** *(results table)* — Today's rule, case A, descends AC2 4,000 feet: 41 kg of extra fuel. Case B, automation without the real numbers, can't tell the two aircraft apart and makes the same choice: 41 kg. AC1 can't descend, because AC3 is right behind it at FL360. With the airline's data, case C sees that the lighter AC2 can climb 2,000 feet: 12 kg. Case D, with connection information, makes the same choice, because no connection was at risk in this example. Every case takes the same number of radio calls; what changes is the controller's effort, a rule from memory in A against reviewing an automated proposal in B to D.

## Slide 6 — Project Benefits (1:30)

In this one example, against today's rule of thumb, the high-fidelity case cuts each of these by about 70%:

- **The worst cost to any single aircraft.** That keeps the measures of pilot performance from being hurt; a fix that pushes the cost onto one aircraft would meet resistance from flight crews.
- **The airline's cost.** That saving is the airline's incentive to share its performance data, and to pay for securing and transmitting it.
- **System fuel and emissions,** which serve national goals and the system's longevity.

That is claim one: better information, better decision. Automation with generic data does no better than today's rule here, so the whole gain comes from the airline's real data: system fuel falls from 41 kg to 12 kg.

*(chart)* This is one conflict. On the right are the FAA's counts of losses of standard separation by en-route center: 679 in fiscal 2024, over a thousand the year before. Those are only the conflicts that ended in a loss of separation. The conflicts controllers resolve in time are far more common, so a per-conflict saving like this one recurs many times a year.

It is not free. The controller reviews a proposal from decision support instead of applying a rule from memory: the same number of radio calls, more effort per decision. And airlines have to share data specific to each aircraft (its weight, its performance, the airline's priorities), which they treat as competitive. The project assumes that exchange can be secured with existing infrastructure such as the FAA's System Wide Information Management (SWIM) network; securing it is outside this study.

*If asked "how much would this save nationally?"* The FAA source counts losses of separation, not conflicts resolved, so the 70% cannot be multiplied by 679. The chart shows how often the problem reaches the point of failure; it is a floor, not a total.

## Slide 7 — Thank you (Q&A)

Thank you. I'm happy to take questions.
