# Capstone Repository

This repository holds the working material for an ISD systems engineering and design capstone centered on the National Airspace System as a System of Systems. The project explores how operational intent moves through aviation stakeholders, airspace resources, aircraft systems, and decision-support services, with an emphasis on MBSE artifacts rather than a purely mathematical optimization problem.

If you're picking this project up with an AI assistant (Claude, ChatGPT, Copilot, or otherwise), start at [assistant/README.md](assistant/README.md) instead — it's the living memory/workflow/task-state system that keeps sessions coherent across time, and it links back here.

The original idea in this workspace started with rendezvous and trajectory optimization. After stepping back, the stronger capstone direction became broader and more systems-oriented: model the airspace ecosystem itself, from individual aircraft and onboard systems up through air traffic management, airspace boundaries, and the information exchanges that connect them. That framing better supports architecture, interfaces, responsibilities, traceability, and operational concepts, which are the core strengths of an ISD capstone.

## What This Repository Is For

The goal is to build a defensible architecture story in SysML/Cameo that shows:

1. What the National Airspace System contains at a high level.
2. Who owns which responsibilities and information boundaries.
3. How airspace, aircraft, operations, and decision support interact.
4. Where optimization or decision-support services fit as capabilities inside the architecture.
5. How the model traces from operational concepts to requirements, structure, behavior, and verification.

In other words, this repository is not just a document dump. It is the workspace for developing the capstone narrative, the architecture decomposition, the XML export of the architecture content, and the supporting visuals and notes that help explain the model.

## Capstone Direction

The current direction is to treat the National Airspace System as a layered architecture built around authority, responsibility, and information ownership. The most useful framing is not a list of aviation objects, but a connected system of domains such as:

- Governance
- Airspace Management
- Airspace Resources
- Flight Operations
- Airport Operations
- Aircraft Systems
- Information Services
- Infrastructure
- Decision Support

That decomposition makes it possible to model items such as airspace sectors, controller responsibilities, flight intent, clearances, weather products, surveillance tracks, flight plans, and trajectory intent as first-class architecture elements.

The strongest thread across the conversations is the lifecycle of trajectory intent:

Strategic objective -> mission plan -> flight plan -> ATC constraints -> trajectory negotiation -> FMS intent -> guidance commands -> aircraft motion.

That idea gives the capstone a coherent center of gravity and keeps it from turning into an overly broad survey of aviation.

## Repository Contents

- [nas_system_of_systems_architecture.xml](nas_system_of_systems_architecture.xml) contains the architecture content exported as XML.
- [cameo_models/](cameo_models/) is where Cameo/SysML model work can be organized.
- [prework/gpt_convos.md](prework/gpt_convos.md) captures the two source conversations that shaped the capstone direction and package structure.
- [ACM_diagram.pdf](ACM_diagram.pdf) is a supporting artifact from the earlier optimization-oriented framing.

## How To Read This Project

If you are new to the capstone, start with the high-level story first:

1. Read this README to understand the purpose and scope.
2. Review [prework/gpt_convos.md](prework/gpt_convos.md) to see how the architecture direction evolved.
3. Open [nas_system_of_systems_architecture.xml](nas_system_of_systems_architecture.xml) for the structured architecture content.
4. Use the Cameo model workspace to map the architecture into SysML packages, diagrams, and traceability.

## Working Assumptions

- This is a systems engineering capstone, so the emphasis is on structure, behavior, interfaces, and traceability.
- The project should remain bounded enough to finish, even though the National Airspace System is large.
- Decision-support and optimization should appear as services inside the architecture, not as the only subject of the project.
- The model should show how information moves between domains, not just what physical things exist.

## Likely Capstone Storyline

The project is trending toward a reference architecture for how airspace intent is managed across the NAS. That includes the organizations that define and enforce rules, the domains that manage airspace resources, the systems that support flight operations, and the onboard systems that turn intent into executable trajectory and guidance behavior.

If the model is successful, it will let a reviewer follow one clear chain from a mission or operational goal down to aircraft-level execution and back up to the managing authorities and services that constrain it.

## Suggested Next Steps

1. Turn the XML architecture into a visible Cameo package structure.
2. Define the top-level operational domains and cross-cutting information objects.
3. Build one or two representative activity diagrams around trajectory intent and responsibility handoffs.
4. Add requirements and verification links once the architecture skeleton is stable.

## Notes

This README is meant to orient a newcomer quickly. It will likely evolve as the model matures and the capstone narrows to its final demonstration set.
