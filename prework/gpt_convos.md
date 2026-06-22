# Convo 1
Your concept is strong because it cleanly connects (1) an MBSE “source of truth” for the Aircraft/Autopilot/Performance capability model (your “ACM”) with (2) the optimization-intensive planning toolchain (rendezvous + trajectory generation + environment/threat models). The key to making it a capstone-success is to be ruthless about scope control while still demonstrating real SysML rigor: requirements → structure → behavior → parametrics → verification/validation (V&V), with a clear thread showing where “optimizations” live and how they are invoked, configured, and verified.
Below is a recommended way to pursue it, including concrete diagram sets, a modeling pattern for representing optimizations (PID/MPC/point-to-point/vertical profile/lateral profile), and a milestone-driven plan.
I am referencing your capstone sketch upload and the course project expectations to align the work with typical deliverable expectations. 
Capstone
assignment-7-project
________________________________________
1) Define a tight project framing
Working title (example)
“SysML/Cameo ACM Model for Optimization-Driven Mission Planning: From Performance Models to Trajectory/Rendezvous Decisions”
One-sentence purpose
Build a Cameo SysML model that captures the aircraft capability model (ACM), its interfaces, and the optimization/controls/trajectory-generation services that consume ACM content to produce feasible, near-optimal plans (rendezvous + path/altitude/speed profiles) under environment/threat constraints.
Your “north star” deliverable
A Cameo model that can answer questions like:
•	“What ACM content is required to compute an economy speed / econ altitude / max altitude for a given aircraft state and environment?”
•	“What services (PID/MPC/optimal control) depend on which models and data products?”
•	“What are the external interfaces (higher-level users/systems) and internal interfaces (trajectory generator ↔ ACM ↔ winds/threats)?”
•	“How are the optimizations configured, invoked, bounded, and verified?”
________________________________________
2) Pick 2–3 concrete, high-value use cases (and make everything trace to them)
Avoid “modeling the world.” Instead, pick a small set of use cases that force the key interfaces and optimizations to exist.
Recommended use cases
1.	UC-1: Generate receiver-to-rendezvous trajectory using ACM-derived performance limits
o	Trigger: user provides initial state + candidate rendezvous point.
o	Output: feasible trajectory (with fuel/time estimates) plus feasibility flags.
o	This forces: ACM content (thrust/drag surrogate, fuel flow, climb schedule, envelopes), winds/temps interface, constraints, and a trajectory method.
2.	UC-2: Compute economy speed / econ altitude profile for a given aircraft & environment
o	Trigger: user requests cruise policy (econ Mach/IAS, econ altitude, step climb suggestion).
o	Output: recommended speed/altitude policy and the assumptions.
o	This forces: explicit representation of “optimization inside ACM” (a solver that produces econ schedules from models).
3.	UC-3: Multi-vehicle rendezvous planner calls UC-1 repeatedly
o	Trigger: tanker + N receivers initial states; region constraints (threats/airspace).
o	Output: a rendezvous solution plus trade information (resource/opportunity/quality).
o	This forces: orchestration behavior, repeated model calls, caching, and model governance (versions, fidelity levels).
These three use cases map cleanly to your rendezvous work while keeping the Cameo scope bounded.
________________________________________
3) Establish the system-of-interest and boundaries early
System-of-Interest (SoI)
Pick one SoI explicitly. Two good options:
•	Option A (recommended): “Optimization-Enabled Mission Planning Services” (the planner toolchain, including trajectory generation)
•	Option B: “ACM Development & Deployment Pipeline” (how ACM is built, verified, published, and consumed)
You can include both, but only if you treat one as primary and the other as secondary viewpoints.
Context diagram (SysML Block Definition + IBD)
Create a top-level context with these external actors/systems:
•	Mission Planner User / Higher-level System (operator, mission planning workstation)
•	Aircraft/FMS (as a consumer or reference system) (even if not fully modeled)
•	Environment Data Provider (winds/temps model source)
•	Threat/Airspace Provider (no-fly polygons, threat fields)
•	ACM Repository / Configuration Management (model versions, metadata)
This is where your capstone sketch is heading: a data/service pipeline from “source” to “ACM data” to “planning/optimization.” 
Capstone
________________________________________
4) Requirements: keep them model-centric and verifiable
Write requirements that are:
•	Interface-focused (what must be exchanged)
•	Behavior-focused (what must be produced, with what latency/robustness)
•	V&V-friendly (you can actually verify them in the capstone timeframe)
Example requirement set (starter)
•	REQ-INT-01: The system shall accept aircraft initial state (lat, lon, alt, speed, heading, weight/fuel state) and environment state (winds/temps) as inputs to trajectory generation.
•	REQ-ACM-01: The ACM shall provide performance limits (Vmin/Vmax, max climb thrust schedule, ceiling, fuel flow model) as a function of state and environment.
•	REQ-OPT-01: The system shall support at least two trajectory-generation methods (e.g., point-to-point optimizer and guidance-law integration) selectable by configuration.
•	REQ-ROB-01: The system shall detect and flag infeasible trajectories (envelope violations, fuel exhaustion, threat incursion).
•	REQ-TRC-01: The system shall trace every produced plan to the ACM version, environment dataset version, and optimization configuration used.
Then build a requirements trace:
Use Case → Activities → Blocks → Ports/Flows → Parametrics → Verification cases.
________________________________________
5) Diagram set: a minimal, defensible Cameo package structure
Below is a diagram set that will read as “complete” without over-modeling.
A. Use Case Diagrams (package: Operational View)
•	UC-1, UC-2, UC-3
•	Actors: Mission Planner, Environment Provider, Threat Provider, ACM Repository
•	Include “include/extend” only where it adds clarity (don’t overuse it).
B. Activity Diagrams (package: Functional/Behavioral View)
Create one activity per use case, with swimlanes by subsystem/service:
•	Planner Orchestrator
•	Trajectory Generator
•	ACM Service
•	Environment/Threat Services
•	Results/Trade Analyzer
Crucial: show call behavior actions like:
•	Compute_Econ_Speed_Alt()
•	Generate_Trajectory(method=...)
•	Evaluate_Costs()
•	Check_Constraints()
C. Block Definition Diagram (BDD) (package: Logical Architecture)
Define blocks for:
•	RendezvousPlanner
•	TrajectoryGenerationService
•	ACMService
•	EnvironmentModel
•	ThreatModel
•	CostModel (resource/opportunity/quality)
•	OptimizationEngine (generic)
•	ControlLaw (generic)
•	ModelRepository/ConfigManager
D. Internal Block Diagrams (IBD) (package: Interfaces)
For 2–3 key interfaces, explicitly model ports and item flows:
•	TrajectoryGenerationService ↔ ACMService (performance queries and returned envelopes/schedules)
•	TrajectoryGenerationService ↔ EnvironmentModel (winds/temps along path)
•	RendezvousPlanner ↔ TrajectoryGenerationService (batch evaluation API)
•	Optional: RendezvousPlanner ↔ ThreatModel (threat checks, cost field queries)
E. Parametric Diagrams (package: Analysis/Parametrics)
Use parametrics to represent:
•	Envelope constraints (ceiling, speed bounds, climb rate, thrust limits)
•	Fuel burn integration/approximation constraints
•	Cost function composition (resource/opportunity/quality)
This is where you “show the math” without turning Cameo into a full simulator.
F. Verification cases (package: V&V)
For each key requirement, add:
•	TestCase elements and «verify» relationships
•	Example: “Given atmosphere X, aircraft Y at weight W, verify Compute_Econ_Speed_Alt returns speed within envelope and improves objective vs baseline.”
________________________________________
6) How to represent “optimizations” and the different models behind them
You want a clean pattern that distinguishes:
•	What the optimization is doing (problem definition)
•	How it is solved (algorithm/solver)
•	What model fidelity is used (PID vs MPC vs point-to-point vs full profile)
•	What data it consumes/produces
Recommended SysML modeling pattern
6.1 Introduce an Optimization “contract” (interfaces + metadata)
Create a block (or interface block) such as:
•	OptimizationProblem
o	Inputs: state, constraints, environment, model parameters
o	Outputs: decision variables, trajectory/profile, metrics, status
o	Properties: objective(s), constraints set, decision vector definition, bounds
•	OptimizationAlgorithm
o	Properties: method (Nelder-Mead, SQP, direct collocation, dynamic programming, etc.)
o	Settings: tolerance, max iterations, step sizes, discretization
•	Plant/VehicleModel (with specialization)
o	PointMass3DOFModel
o	6DOFModel
o	SurrogatePerformanceModel (fast ACM-style)
o	GuidanceLawModel (PID, LQR-ish, MPC policy)
o	Each has: fidelity, states, controls, numerical noise characteristics
Then define a composition:
OptimizationEngine has a OptimizationProblem and uses VehicleModel + EnvironmentModel.
6.2 Use stereotypes to express the “method family”
Define stereotypes such as:
•	«GuidanceBased» (PID/MPC tracking a reference)
•	«DirectOptimization» (direct transcription/collocation)
•	«IndirectOptimization» (PMP/shooting—if you want to mention it without implementing)
•	«HeuristicSearch» (A*, graph-based lateral/altitude search)
This lets you show multiple approaches without duplicating structure.
6.3 Use parametrics to expose objective/constraint structure
Model constraint blocks like:
•	FuelBurnConstraint
•	EnvelopeConstraint
•	ThreatAvoidanceConstraint
•	RendezvousTimingConstraint
And objective blocks like:
•	MinFuel
•	MinTime
•	MaxOffload / “Meet receiver fuel requirement”
•	MinRisk (threat cost integral)
Even if you do not execute them in Cameo, the parametric diagram becomes the authoritative specification of what the optimizer is minimizing and what it must satisfy.
________________________________________
7) Show the “ACM development” viewpoint without making it the whole project
If part of your goal is “ACM and its development, including optimizations required to generate full content,” treat that as a second, smaller viewpoint:
ACM pipeline (one activity diagram + one IBD)
•	Inputs: flight test data, aero tables, engine deck, validated surrogate fits
•	Steps: data conditioning → model fitting → envelope extraction → econ schedule optimization → packaging/versioning
•	Outputs: ACMArtifact with metadata and service endpoints
This is often enough to demonstrate the development lifecycle without overbuilding.
________________________________________
8) Deliverable strategy and milestones (what to do in what order)
Milestone 1: Problem statement + architecture skeleton
•	3 use cases
•	Context diagram (BDD/IBD)
•	Draft requirements (10–20 max) with trace placeholders
Milestone 2: Interfaces + behavior (make it “walkable”)
•	Activity diagrams for UC-1/2/3
•	IBDs for the 2–3 key service interfaces with item flows defined
•	Define the core blocks and their responsibilities
Milestone 3: Optimization representation + parametrics
•	Parametric diagrams for:
o	econ schedule computation (UC-2)
o	trajectory feasibility + cost computation (UC-1)
o	rendezvous orchestration trade study (UC-3)
•	Stereotypes/fidelity scheme for model variants
Milestone 4: V&V closure + demonstration
•	Verification cases linked to requirements
•	A small demonstration artifact:
o	Either a model walkthrough (Cameo screenshots + narrative) or
o	A thin prototype (Python) that consumes “ACM-like” outputs and shows traceability to model elements
This aligns well with the expectation that you articulate problem statements, models, coupling, and algorithm behavior rather than only “engineering design.” 
assignment-7-project
________________________________________
9) A practical “definition of done” for your capstone
Your project is in a very strong place if, by the end, you can show:
1.	Traceability: Use case → activity → block/interface → parametric → requirement → verification case.
2.	Interface clarity: Explicit item flows for state/environment/threat/performance data.
3.	Optimization clarity: A consistent model pattern showing problem definition + solver + model fidelity choice (PID/MPC/direct optimization).
4.	Governance: Versioning/config metadata (ACM version, winds dataset version, solver config) tied to outputs.
5.	A focused demo: One scenario walk-through where the model explains “what happens” and “what is required” to compute the plan.
________________________________________
10) If you want a recommended “first diagram to build” tomorrow
Start with UC-3 activity diagram (rendezvous planner orchestration) because it forces you to define:
•	what services exist,
•	what data must flow,
•	what optimizations are invoked,
•	and where ACM is queried.
From that one diagram, everything else (BDD/IBD/requirements/parametrics) becomes straightforward.
________________________________________
If you want, I can turn the above into:
1.	a Cameo package structure (exact package names + diagram names), and
2.	a starter requirements list with IDs and verification methods (Analysis/Test/Inspection/Demonstration), already written in “shall” form and mapped to UC-1/2/3.
Sources
let's start with the cameo package structure
Below is a Cameo/SysML package structure that is (a) defensible to faculty, (b) traceable end-to-end, and (c) sized so you can actually finish it. I’m assuming SysML v1 in Cameo. If you are using SysML v2 plugins, the same decomposition still works, but naming conventions differ slightly.
________________________________________
Top-level model organization
00_Model_Management
Purpose: keep the model maintainable and reviewable.
•	00_ReadMe
o	Model purpose, SoI, scope boundaries, definitions
•	01_Naming_Conventions
•	02_Units_And_Dimensions
o	ValueTypes for time, distance, fuel, mass, etc.
•	03_Glossary
o	Terms: ACM, performance model, econ speed, rendezvous, threat field, etc.
•	04_Assumptions_And_Limitations
•	05_References
o	Pub references, standards, course rubric references
________________________________________
Stakeholders, goals, and requirements
10_Stakeholder_And_Requirements
Purpose: formal requirements + trace hooks.
•	10_Stakeholders
o	Stakeholder blocks/actors, concerns
•	11_Mission_Needs_And_Goals
o	High-level objectives (not “shall”)
•	12_System_Requirements
o	Requirements elements (shall statements)
o	Suggested subpackages:
	12_01_Interface_Requirements
	12_02_Functional_Requirements
	12_03_Performance_Requirements
	12_04_Traceability_And_Governance_Requirements
•	13_Requirement_Rationale
o	Notes/rationale elements or comment blocks
•	14_Requirement_Traceability
o	Matrices (if you use them): Req↔UseCase, Req↔TestCase
________________________________________
Operational viewpoint
20_Operational_View
Purpose: what the system does for users and in what context.
•	21_Operational_Context
o	Context BDD/IBD showing external systems:
	Mission Planner User / Host workstation
	ACM repository/config mgmt
	Environment source
	Threat/airspace source
•	22_Use_Cases
o	Use Case diagrams
o	Use case model elements:
	UC-1: Generate receiver-to-rendezvous trajectory
	UC-2: Compute econ speed/alt schedule
	UC-3: Multi-vehicle rendezvous planning orchestration
•	23_Operational_Activities
o	Activity diagrams per UC
o	Optional: operational scenarios (happy path + failure path)
________________________________________
Logical architecture (services and responsibilities)
30_Logical_Architecture
Purpose: define the solution decomposition without committing to implementation.
•	31_System_Of_Interest_Definition
o	SoI block, boundaries, black-box view
•	32_Logical_Blocks
o	BDD(s) for:
	RendezvousPlanner
	TrajectoryGenerationService
	ACMService
	EnvironmentService
	ThreatService
	CostEvaluationService
	OptimizationEngine
	ModelRepository/ConfigManager
•	33_Internal_Interfaces
o	IBD(s) with ports/item flows for key interfaces:
	Planner ↔ Trajectory Gen
	Trajectory Gen ↔ ACM
	Trajectory Gen ↔ Environment
	Planner ↔ Threat/Constraint service
	Planner ↔ Cost service
•	34_Logical_Data_Definitions
o	Define “data products” as blocks/value types:
	AircraftState
	EnvironmentState
	ThreatField
	Trajectory
	PerformanceEnvelope
	EconSchedule
	PlanMetrics
	OptimizationConfig
	ProvenanceRecord
________________________________________
Behavioral architecture (who calls whom)
40_Behavior_And_Interaction
Purpose: make the orchestration explicit and reviewable.
•	41_Activity_Model_Library
o	Reusable activities like:
	Generate_Trajectory()
	Compute_Econ_Schedule()
	Evaluate_Costs()
	Check_Feasibility()
•	42_Sequence_Diagrams
o	For UC-1/UC-3 orchestration (highly recommended)
o	Sequence diagrams are where reviewers “get it” fast.
•	43_State_Machines
o	Optional, but useful for:
	Planner execution states (Idle/Running/Converged/Failed)
	Trajectory generation states (Init/Integrate/Converged/Infeasible)
________________________________________
Analysis, parametrics, and “optimization representation”
50_Analysis_And_Parametrics
Purpose: represent objectives/constraints/model fidelity without turning Cameo into a simulator.
•	51_Objectives_And_Costs
o	Parametric diagrams for:
	Resource cost
	Opportunity cost
	Quality cost
	Composite cost and weighting
•	52_Constraints_And_Feasibility
o	Envelope constraints, threat constraints, fuel constraints
•	53_Optimization_Models
o	Core pattern packages:
	53_01_OptimizationProblem_Definitions
	Decision variables, objectives, constraints, bounds
	53_02_OptimizationAlgorithms
	Nelder-Mead, SQP, Direct Collocation, etc. (as model elements)
	53_03_Model_Fidelity_And_Dynamics
	PointMass3DOF, 6DOF, SurrogatePerformanceModel
	GuidanceLaw_PID, GuidanceLaw_MPC, etc.
•	54_Assumptions_And_Uncertainty
o	Noise sources (PID tuning variability, wind uncertainty)
o	Sensitivity hooks (even if qualitative)
________________________________________
ACM content and development pipeline viewpoint
60_ACM_Content_And_Development
Purpose: show how ACM is built, updated, versioned, and what content it provides.
•	61_ACM_Content_Model
o	BDD for ACM data products:
	performance tables/surrogates
	envelopes
	schedules (econ speed/alt, max alt, etc.)
•	62_ACM_Compute_Services
o	What ACM “computes” on request (service interfaces)
•	63_ACM_Development_Pipeline
o	Activity diagram of:
	ingest → fit → validate → package → publish
•	64_ACM_Versioning_And_Governance
o	Provenance, configuration items, compatibility constraints
________________________________________
Verification and validation
70_Verification_And_Validation
Purpose: close the loop with requirements and demonstrate rigor.
•	71_Verification_Strategy
o	What is verified by analysis vs test vs inspection vs demo
•	72_Test_Cases
o	TestCase elements organized by use case:
	72_01_UC1_Trajectory_Gen_Tests
	72_02_UC2_Econ_Schedule_Tests
	72_03_UC3_Rendezvous_Planning_Tests
•	73_Verification_Matrices
o	Req↔TestCase, Req↔ModelElement (if you use matrices)
•	74_Results_And_Evidence
o	Links to plots, Python artifacts, screenshots, etc.
________________________________________
Demonstration and artifacts
80_Demo_And_Artifacts
Purpose: ensure you can “tell the story” in a review.
•	81_Demo_Scenarios
o	One or two scenario definitions (inputs, expected outputs)
•	82_Demo_Walkthrough_Diagrams
o	Curated views (simplified diagrams for presentation)
•	83_External_Artifacts
o	Links to code repo, exported reports, datasets
________________________________________
Practical modeling guidance (so this structure stays usable)
1.	Put model elements in packages; put diagrams in a “Diagrams” subpackage only if your team prefers it. Otherwise, keep diagrams next to the elements they describe.
2.	Keep “Data Products” explicit (AircraftState, Trajectory, Envelope, EconSchedule). This is the fastest way to make interfaces unambiguous.
3.	Treat “Optimization” as a first-class service with configuration + provenance outputs. Your traceability requirement will thank you.
4.	Start building in this order:
o	20_Operational_View (use cases + UC-3 activity)
o	30_Logical_Architecture (blocks + IBD for interfaces)
o	50_Analysis_And_Parametrics (costs/constraints)
o	70_V&V (test cases + verify links)
________________________________________
Your next concrete step
Create the packages exactly as above, then I recommend we define:
•	the SoI block in 31_System_Of_Interest_Definition, and
•	the three use cases in 22_Use_Cases.
If you paste (or screenshot) your current top-level blocks/actors (even rough), I’ll map them into 21_Operational_Context and propose the first context BDD/IBD decomposition.



# Convo 2
ChatGPT Plus
















I'd like to step back from the idea of a rendezvous and consider other options. I like the idea of formulating a model of the airspace, from individual flights (w/internal aero & engine models and other systems like the pilots) of various types (mil, civil, ga, business, etc.), up through airspace managers (APRON control, DEP/ARR control, ENROUTE) and the various boundaries that impact them (geographical, altitude, etc.). 

I think this is a stronger capstone direction than the rendezvous problem if your goal is to demonstrate systems engineering, architecture, and MBSE, rather than just optimization.

The rendezvous problem is a good engineering problem, but it naturally gravitates toward:

Mathematical optimization

Control theory

Vehicle dynamics

Algorithm implementation

A comprehensive airspace model naturally gravitates toward:

System architecture

Enterprise systems

Multi-stakeholder interactions

Interfaces and information exchanges

Operational concepts

Hierarchical decomposition

MBSE best practices

Those align much more closely with what an ISD capstone committee is likely to expect.

What You Are Really Modeling
I would avoid saying:

"I am modeling the aviation industry."

That becomes impossibly large.

Instead:

"I am modeling the National Airspace System as a System-of-Systems."

This immediately gives you a well-defined System of Interest.

At the highest level:

National Airspace System
│
├── Airspace Users
│   ├── Airlines
│   ├── Military
│   ├── Business Aviation
│   ├── General Aviation
│   └── UAS
│
├── Air Navigation Service Providers
│   ├── Tower
│   ├── TRACON
│   ├── ARTCC
│   └── Traffic Flow Management
│
├── Airports
│
├── Aircraft
│
├── Communication Systems
│
├── Surveillance Systems
│
├── Navigation Systems
│
└── Regulatory Authorities
This is a classic SoS architecture.

Multiple MagicDraw Projects Makes Sense
Your instinct about multiple files is good.

Something like:

NAS Root Model

├── Aircraft Architecture Model
├── Airport Operations Model
├── Air Traffic Services Model
├── Communications Model
├── Navigation Model
├── Surveillance Model
├── Regulatory Model
└── Optimization Services Model
Each project can be independently useful.

The optimization model becomes one capability among many.

Aircraft Should Not Be Just Aircraft
This is where the project gets interesting.

Most students would model:

Aircraft
 ├── Position
 ├── Speed
 └── Altitude
That's not really systems engineering.

Instead:

Aircraft
│
├── Flight Crew
├── Flight Management System
├── Guidance System
├── Navigation System
├── Propulsion System
├── Airframe
├── Communications
├── Surveillance
└── Mission System
Now you've connected your professional experience.

For example:

Pilot
   ↓
FMS
   ↓
Guidance
   ↓
Flight Controls
   ↓
Aircraft Motion
which is essentially the ATM-to-aircraft chain you were discussing previously.

Airspace Structure
I would explicitly model airspace as a resource.

Airspace Volume
with attributes:

lateral boundaries

vertical boundaries

controlling authority

communications frequency

separation standards

operating rules

Examples:

Class B

Class C

Military Operations Area

Restricted Area

Oceanic Airspace

TRACON Sector

ARTCC Sector
The airspace itself becomes an object in the architecture.

Controllers Become Systems
Another interesting decomposition:

Enroute Controller

Approach Controller

Departure Controller

Ground Controller

Ramp Controller
Each performs:

Monitor Traffic

Detect Conflict

Issue Clearance

Coordinate Handoff

Manage Flow
You can create activity diagrams showing responsibility transitions.

Example:

Ramp
  →
Ground
  →
Tower
  →
Departure
  →
Enroute
  →
Arrival
  →
Tower
  →
Ground
  →
Ramp
That single activity diagram tells a large operational story.

Communications Architecture
One thing often missing from academic airspace models is information exchange.

You mentioned transmission mechanisms.

This is fertile ground.

Examples:

Voice VHF

CPDLC

ADS-B

Mode S

ACARS

Satellite Communications

Military Tactical Datalinks
Model:

Sender
Message
Transport
Receiver
rather than specific radios.

That scales much better.

Where Optimization Fits
Instead of making optimization the project itself:

Optimization Capability
becomes a service inside the architecture.

Examples:

Trajectory Optimization

Arrival Sequencing

Conflict Resolution

Flow Management

Aerial Refueling Planning

Fuel Optimization
Now your rendezvous work becomes a reusable capability.

A Potential Capstone Statement
Something like:

Develop a SysML-based System-of-Systems architecture of the National Airspace System that models aircraft, airspace resources, air traffic management organizations, operational boundaries, and information exchanges. Demonstrate how advanced decision-support capabilities can be integrated into the architecture through a representative optimization service.

That gives you:

A large MBSE artifact.

Multiple levels of abstraction.

Operational views.

Structural views.

Behavioral views.

A concrete engineering demonstration.

The Part I Would Personally Focus On
Given your background in FMS and trajectory optimization, the most compelling thread is:

National Airspace System
      ↓
Air Traffic Management
      ↓
Aircraft Operations
      ↓
Flight Management Systems
      ↓
Trajectory Intent
      ↓
Optimization Services
Most airspace models stop at the aircraft boundary.

Very few connect all the way down into the aircraft decision-making architecture. That is exactly where your GE Aerospace experience gives you a perspective that most students—and many faculty—do not have.

The result is a capstone that looks less like a simulation and more like a reusable reference architecture for how operational intent flows through the NAS from enterprise-level objectives down to aircraft trajectory execution.


This is already moving away from a "list of things in aviation" and toward a legitimate architecture ontology, which is where I think you want to be.

The biggest refinement I'd suggest is:

Don't organize around physical things. Organize around authority, responsibility, and information ownership.

That's how the boundaries become meaningful from an MBSE perspective.

Proposed Top-Level Decomposition
Instead of:

NAS
├── Aircraft
├── Airports
├── Airspace
├── Communications
I would consider:

National Airspace System
│
├── Governance Domain
├── Airspace Management Domain
├── Airspace Resource Domain
├── Flight Operations Domain
├── Airport Operations Domain
├── Aircraft Systems Domain
├── Information Services Domain
├── Infrastructure Domain
└── Decision Support Domain
These are much closer to actual authority boundaries.

Governance Domain
Who defines the rules?

Governance Domain
│
├── FAA
├── DoD
├── DHS
├── NTSB
├── EASA
├── ICAO
├── Airlines
├── Airport Authorities
└── Labor Organizations
Activities:

Define Regulations
Define Procedures
Allocate Airspace
Certify Systems
Investigate Incidents
Airspace Resource Domain
I think this is one of the most important additions.

Most models treat airspace as background.

Instead:

Airspace Resource Domain
│
├── Surface Areas
├── Terminal Airspace
├── Enroute Airspace
├── Oceanic Airspace
├── Special Use Airspace
└── Dynamic Airspace
Properties:

Owner
Controlling Authority
Vertical Limits
Lateral Limits
Entry Conditions
Separation Standards
Communications Requirements
Examples:

Class A
Class B
Class C
Class D
Class E

MOA
Restricted Area
Warning Area

TRACON Sector
ARTCC Sector
Airspace Management Domain
Who is responsible for safe use of the resource?

Airspace Management Domain
│
├── Ramp Control
├── Ground Control
├── Local Control
├── Departure Control
├── Arrival Control
├── Enroute Control
├── Traffic Flow Management
└── Military Airspace Coordination
Activities:

Monitor Traffic
Maintain Separation
Issue Clearances
Coordinate Handoffs
Manage Capacity
Implement Flow Restrictions
Flight Operations Domain
This is currently mixed into your Aircraft section.

I would separate humans and organizations from aircraft hardware.

Flight Operations Domain
│
├── Airline Operations Center
├── Military Operations Center
├── Business Flight Department
├── General Aviation Pilot
├── UAS Operator
└── Flight Crew
Actors:

Pilot
Dispatcher
Mission Planner
Load Planner
Flight Follower
Operations Manager
Activities:

Flight Planning
Fuel Planning
Weather Assessment
Mission Planning
Route Selection
Flight Monitoring
Diversion Planning
Airport Operations Domain
I would expand this significantly.

Airport Operations Domain
│
├── Passenger Processing
├── Ground Handling
├── Fuel Services
├── Catering
├── Cargo Operations
├── Gate Management
├── Surface Management
├── Runway Operations
└── Airport Emergency Services
Resources:

Gate
Ramp
Taxiway
Runway
Terminal
Fuel Farm
Deicing Facilities
Systems:

A-SMGCS
ASDE-X
AMAN
DMAN
A-CDM
Aircraft Systems Domain
This is where your expertise becomes valuable.

I would decompose further.

Aircraft Systems Domain
│
├── Air Vehicle
├── Crew
├── Mission Systems
└── Onboard Decision Systems
Air Vehicle
Airframe
Landing Gear
Flight Controls
Hydraulics
Electrical
Environmental Control
Propulsion
Fuel System
Navigation & Guidance
Navigation System
├── GNSS
├── INS
├── Radio Navigation

Flight Management System

Guidance System

Autopilot

Autothrottle
Surveillance
ADS-B
Mode S
TCAS
Weather Radar
EO/IR Sensors
Information Services Domain
This is currently split among several of your models.

I think it deserves its own domain.

Information Services Domain
│
├── Communications
├── Surveillance
├── Navigation
├── Weather
├── Aeronautical Information
└── Flight Data Services
Communications
Voice VHF

CPDLC

ACARS

SATCOM

SWIM

Tactical Datalinks
Weather
METAR
TAF
PIREP
SIGMET
Convective Forecast
Winds Aloft
Aeronautical Information
Procedures
Charts
NOTAMs
Airspace Definitions
Airport Data
Decision Support Domain
This is where your optimization work belongs.

Decision Support Domain
│
├── Strategic Planning
├── Tactical Planning
├── Predictive Analytics
├── Optimization
└── Automation
Optimization Services

Trajectory Optimization

Arrival Sequencing

Departure Sequencing

Conflict Detection

Conflict Resolution

Flow Optimization

Fuel Optimization

Weather Avoidance

Aerial Refueling Planning

Mission Planning
Cross-Cutting Information Objects
One thing I would explicitly model is the information that flows between all domains.

Many MBSE NAS efforts fail because they model systems but not the information.

Examples:

Flight Plan

Trajectory Intent

Clearance

Restriction

Airspace Reservation

Weather Product

Surveillance Track

Aircraft State

Mission Objective

Fuel Status

Runway Assignment

Arrival Sequence

Conflict Alert
These become the primary objects in your activity diagrams.

A Potential Research Gap
After looking at your list, the most interesting capstone angle may not be:

Model the NAS.

but:

Model the lifecycle of trajectory intent across the NAS.

Something like:

Strategic Objective
        ↓
Mission Plan
        ↓
Flight Plan
        ↓
ATC Constraints
        ↓
Trajectory Negotiation
        ↓
FMS Intent
        ↓
Guidance Commands
        ↓
Aircraft Motion
Very few NAS architectures follow intent all the way from organizational objectives to vehicle dynamics.

That thread would let you connect:

FAA and NAS architecture

Airline operations

Air traffic management

FMS architecture

Optimization

Aircraft dynamics

into a single coherent System-of-Systems story rather than a collection of aviation models. For a graduate systems engineering capstone, that narrative is likely stronger than trying to comprehensively represent every part of the NAS.


Create an XML of all of that architectural content

I’ll turn the architecture into a structured XML artifact with explicit domains, entities, activities, information objects, boundaries, and optimization services. I’ll also make it reasonably MagicDraw/SysML-friendly, though not a native Cameo project export.

Thought for 1m 10s
Done: Download the XML


Create one or more mermaid diagrams laying out several examples that I can use to explore the problem spaces where I might focus my capstone efforts

I’ll frame these as capstone “focus lenses,” not just architecture diagrams: each one highlights a different defensible scope, boundary, and demonstration opportunity.

Thought for a couple of seconds
Below are several Mermaid diagrams you can paste into Markdown, Obsidian, GitHub, or Mermaid Live Editor.

1. NAS System-of-Systems Domain Map


2. Strategic Intent to Aircraft Behavior


This is probably your strongest capstone narrative.

3. Operational Responsibility Transitions


4. Airspace as a Shared Resource


5. Information Exchange / Communications Model


6. Decision Support Services Plug-In Architecture


7. Capstone Focus Trade Space


8. Recommended Capstone Candidate: Intent-to-Trajectory Architecture


My recommendation: make Diagram 8 the capstone center of gravity, with Diagrams 1–6 as supporting views.


