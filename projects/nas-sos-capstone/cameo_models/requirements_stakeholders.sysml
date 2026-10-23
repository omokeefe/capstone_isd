package StakeholderRequirements {
    doc /*
     * Stakeholder requirements on the National Airspace System (NAS), cut down to the
     * study: what each stakeholder wants from the NAS where that want bears on the
     * decision the project studies, which is how an en-route conflict between two
     * aircraft in cruise is resolved and what the party deciding it is told.
     *
     * DRAFT, revised from the owner's two hand reviews: of the first draft on 2026-10-10
     * (projects/nas-sos-capstone/handwritten/2026-10-10_requirements-and-traceability.pdf;
     * decision D-020) and of the second on 2026-10-11
     * (handwritten/2026-10-11_requirements-and-traceability_v2.pdf; decision D-021).
     * Every requirement has status = draft. Nothing here is baselined.
     *
     * WHAT THE REVIEW CHANGED
     * The first draft held 27 requirements in 8 groups. The owner struck those that do
     * not bear on the study's decision (D-007's test, applied to the study and not to the
     * NAS in general), re-worded several, and wrote three new flight crew requirements.
     * The second review restored SN-ATC-04 (controller workload), leaving 13 in 5 groups.
     * The third review (2026-10-20, handwritten/2026-10-20_requirements-and-traceability.pdf;
     * D-031) keeps every requirement of the first draft: the 17 that were struck are back,
     * with the text they had when struck, tagged studyScope = outOfStudy. The study's cut
     * is now made at the HLR tier. SN-GOV-01 and SN-ENV-01 are tagged background. 30 in
     * all, in 8 groups: 11 in the study, 2 background, 17 out of study. The owner's mark
     * on each restored one is in its rationale.
     *
     * HOW TO READ ONE
     * The doc comment is the requirement. objectiveRefs names the rows it comes from in
     * knowledge/models/stakeholder-objective-ontology.md. rationale says why the
     * requirement belongs in the study, or, for a restored one, the owner's mark when it
     * was struck.
     *
     * TRACE
     * Every requirement here is the parent of at least one system requirement in
     * requirements_nas_system.sysml (attribute parentNeeds there). 30 stakeholder
     * requirements, 42 system requirements. Below those, the constituent system
     * requirements are in requirements_constituent_systems.sysml (D-022).
     * If knowledge/models/requirements-and-traceability.md and this file disagree, this
     * one wins (D-006).
     *
     * Attribute schema: requirements_definitions.sysml.
     */

    package Operators {
        doc /* Airline (Part 121 scheduled passenger operator). D-007: Modeled system (Flight Operations). */

        public import RequirementDefinitions::*;

        requirement <'SN-AIR-01'> lowestCostTrajectory : StakeholderNeed {
            doc /* The NAS shall provide a means for the airline to plan and fly each flight on
             * the route, altitude and speed it chooses.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> objectiveRefs = ("Airline: Fuel cost", "Airline: Delay cost", "Airline: Crew cost", "Airline: Maintenance", "Airline: Revenue", "Passenger: Ticket price", "Passenger: Schedule convenience", "Passenger: Comfort", "Flight Crew: Operational flexibility", "Environmental / Societal: CO2", "Environmental / Societal: NOx", "Environmental / Societal: Contrail/climate effects", "Environmental / Societal: Noise", "Environmental / Societal: Local air quality");
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("mori2022massCruise", "munro2018managingVariability");
            :>> rationale = "In the study: the planned cruise altitude and speed are what a conflict resolution takes the aircraft away from, so this is what the experiment scores a resolution against. The owner struck 'at its lowest operating cost' (hand review 2026-10-11): what the airline optimizes for is the airline's own business. The owner struck ', so that the flight is flown within safety and capacity limits' (hand review 2026-10-20). Objective rows added by the owner in the workbook review of 2026-10-22 (D-032): Airline: Crew cost; Airline: Maintenance; Airline: Revenue; Passenger: Ticket price; Passenger: Schedule convenience; Passenger: Comfort; Flight Crew: Operational flexibility; Environmental / Societal: CO2; Environmental / Societal: NOx; Environmental / Societal: Contrail/climate effects; Environmental / Societal: Noise; Environmental / Societal: Local air quality. Owner on 'Passenger: Ticket price' (2026-10-22): the airline sets prices from its costs, as represented in the fuel, time and maintenance impacts of its flight schedules as planned.";
        }

        requirement <'SN-AIR-02'> onScheduleArrival : StakeholderNeed {
            doc /* The NAS shall provide a means for each flight to achieve arrival at its
             * destination gate at its scheduled arrival time.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> objectiveRefs = ("Airline: Schedule integrity", "Airline: Aircraft utilization", "Airline: Passenger connections", "Airline: Dispatch reliability", "Passenger: Travel time", "Passenger: Connection reliability", "Passenger: Disruption risk", "ATC / ANSP: Predictability", "ATC / ANSP: Delay (ATC-attributed)", "Airport: Gate utilization", "Airport: Runway utilization", "Airport: Surface congestion", "Airport: Turnaround performance", "Airport: Passenger throughput", "Flight Crew: Schedule/duty constraints");
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "In the study: the time side of the fuel-against-time trade, and the reason one flight's connections can outweigh its fuel (case D of the experiment). Owner's wording, hand review 2026-10-10. Objective rows added by the owner in the workbook review of 2026-10-22 (D-032): Airline: Dispatch reliability; Passenger: Travel time; Passenger: Connection reliability; Passenger: Disruption risk; ATC / ANSP: Predictability; ATC / ANSP: Delay (ATC-attributed); Airport: Gate utilization; Airport: Runway utilization; Airport: Surface congestion; Airport: Turnaround performance; Airport: Passenger throughput; Flight Crew: Schedule/duty constraints.";
        }

        requirement <'SN-AIR-03'> advanceNoticeOfConstraints : StakeholderNeed {
            doc /* The NAS shall inform the airline of airspace and airport constraints that will
             * delay or reroute its flights early enough for the airline to re-plan.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> objectiveRefs = ("Airline: Delay cost", "Airline: Schedule integrity");
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo72103ee";
            :>> rationale = "In the study: flights are separated as filed; as uncertainty is realized, aircraft deviate and interventions are needed (owner, hand review 2026-10-11). The intervention is the constraint the airline needs to hear about, and the crew and the dispatchers are the ones who coordinate to make that happen (owner, 2026-10-11). Traffic management initiatives are outside the study (D-021).";
        }

        requirement <'SN-AIR-05'> airlinePrioritiesInTrajectoryChanges : StakeholderNeed {
            doc /* The NAS shall take the airline's priorities for a flight (fuel against time, and
             * protected connections) into account when a change to that flight's trajectory is
             * required.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> objectiveRefs = ("Airline: Fuel cost", "Airline: Schedule integrity", "Airline: Passenger connections", "Flight Crew: Operational flexibility", "Environmental / Societal: CO2", "Environmental / Societal: NOx", "Environmental / Societal: Contrail/climate effects", "Environmental / Societal: Noise", "Environmental / Societal: Local air quality");
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("schultz2012adaptiveClimb", "coppenbarger1999climbPrediction", "kulkarni2019ctopSlotSubstitution");
            :>> rationale = "In the study: this is the requirement the experiment is about (knowledge/models/experiment-definition.md section 2). Met today in part, before departure (owner, 2026-10-22): in the FAA's Collaborative Trajectory Options Program the airline submits a Trajectory Options Set, each route option carrying a Relative Trajectory Cost in equivalent ground-delay minutes, and the FAA's algorithm adds that cost to the assigned delay and picks the cheapest option (kulkarni2019ctopSlotSubstitution, p. 4). It is not met in tactical conflict resolution in cruise, the decision the study examines: the controller does not receive weight or cost index. Owner's wording, hand review 2026-10-10. Objective rows added by the owner in the workbook review of 2026-10-22 (D-032): Flight Crew: Operational flexibility; Environmental / Societal: CO2; Environmental / Societal: NOx; Environmental / Societal: Contrail/climate effects; Environmental / Societal: Noise; Environmental / Societal: Local air quality.";
        }

        requirement <'SN-AIR-04'> airlineChoosesDelayedFlight : StakeholderNeed {
            doc /* The NAS shall let the airline choose which of its own flights takes a
             * delay that the airline has been assigned.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> objectiveRefs = ("Airline: Delay cost", "Airline: Passenger connections");
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo72103ee";
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'This is about slot swapping... seems like it's only on strategic timelines, not tactical like I'm studying.' JO 7210.3EE 18-10-12 places it inside a ground delay program, before departure.";
        }

        requirement <'SN-AIR-06'> airlineDataKeptPrivate : StakeholderNeed {
            doc /* The NAS shall keep the airline's commercially sensitive flight data
             * (aircraft weight, cost index, connection priorities) private.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "schultz2012adaptiveClimb";
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'Important & real, but not pertinent to my project per D-007!' Carried as an assumption (D-020 item 4). No objective row matches it.";
        }
    }

    package AirTrafficControl {
        doc /* Air traffic control and traffic flow management (FAA Air Traffic Organization). D-007: Modeled system (Airspace Management). */

        public import RequirementDefinitions::*;

        requirement <'SN-ATC-01'> separationAssured : StakeholderNeed {
            doc /* The NAS shall keep every controlled aircraft separated from every other aircraft
             * by at least the applicable separation minimum.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::airTrafficControl;
            :>> objectiveRefs = ("ATC / ANSP: Safety/separation", "Airline: Flight Safety");
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo711065bb";
            :>> rationale = "In the study: the hard constraint every resolution option must meet. It is never traded against cost (knowledge/models/experiment-definition.md section 6). Objective rows added by the owner in the workbook review of 2026-10-22 (D-032): Airline: Flight Safety.";
        }

        requirement <'SN-ATC-02'> demandWithinCapacity : StakeholderNeed {
            doc /* The NAS shall keep the number of aircraft in each sector and at each airport
             * within its declared capacity.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::airTrafficControl;
            :>> objectiveRefs = "ATC / ANSP: Capacity";
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo72103ee";
            :>> rationale = "In the study: context. It is the capacity limit named in SN-AIR-01. Not marked in either hand review. The workload rows moved back to SN-ATC-04 (D-021).";
        }

        requirement <'SN-ATC-04'> sustainableControllerWorkload : StakeholderNeed {
            doc /* The NAS shall keep the number of control actions a sector controller must take
             * within what one sector team can sustain.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::airTrafficControl;
            :>> objectiveRefs = ("ATC / ANSP: Sector workload", "ATC / ANSP: Traffic complexity");
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("rantanen2012conflictManeuvers", "kirwan2001coraStrategies");
            :>> rationale = "Struck in the first hand review and brought back in the second (owner, 2026-10-11: 'Let's bring back SN-ATC-04'). In the study: instruction count is one of the experiment's two scored columns. Workload is a ceiling, not something to minimize: a controller who is not overworked can give as many instructions as wanted (owner, same review).";
        }

        requirement <'SN-ATC-03'> pathKnownInAdvance : StakeholderNeed {
            doc /* The NAS shall make the path each controlled aircraft will fly known to
             * its controller in advance.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::airTrafficControl;
            :>> objectiveRefs = "ATC / ANSP: Predictability";
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "coppenbarger1999climbPrediction";
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'Not D-007'.";
        }

        requirement <'SN-ATC-05'> delaySharedEquitably : StakeholderNeed {
            doc /* The NAS shall share unavoidable delay equitably among airspace users.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::airTrafficControl;
            :>> objectiveRefs = "ATC / ANSP: Delay (ATC-attributed)";
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo72103ee";
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10 with no mark: its only system requirements were about traffic management initiatives.";
        }
    }

    package FlightCrews {
        doc /* Flight crew (captain and first officer). D-007: Modeled system (Flight Crew). */

        public import RequirementDefinitions::*;

        requirement <'SN-CRW-03'> flyableAndTimelyInstructions : StakeholderNeed {
            doc /* The NAS shall give the flight crew only trajectory clearances and instructions
             * that the aircraft can fly, with enough time to set them up.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = ("Flight Crew: Workload", "Flight Crew: Safety");
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "In the study: a climb the aircraft is too heavy to make is the clearance the baseline can issue and the improved architecture avoids. The only flight crew requirement of the first draft the owner kept. 'Clearances and' added by the owner (hand review 2026-10-20).";
        }

        requirement <'SN-CRW-06'> clearancesAccountForTraffic : StakeholderNeed {
            doc /* The NAS shall provide the flight crew clearances that account for air traffic. */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = "Flight Crew: Safety";
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Written by the owner in the hand review of 2026-10-10 (flight crew note 1). In the study: the clearance that resolves the conflict is the thing the crew receives. Objective row confirmed by the owner (hand review 2026-10-11).";
        }

        requirement <'SN-CRW-07'> crewInformedOfWeatherTrafficAndInitiatives : StakeholderNeed {
            doc /* The NAS shall inform the flight crew of weather, traffic and other safety
             * considerations.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = ("Flight Crew: Safety", "Flight Crew: Procedural compliance");
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Written by the owner in the hand review of 2026-10-10 (flight crew note 2). In the study: what the crew knows when it accepts, refuses or asks to change a clearance. On 2026-10-11 the owner replaced 'traffic management initiatives' with 'other safety considerations', as a catch-all. Objective rows confirmed by the owner (hand review 2026-10-11).";
        }

        requirement <'SN-CRW-08'> controlAcrossSectors : StakeholderNeed {
            doc /* The NAS shall facilitate control of the aircraft across regional sectors,
             * coordinating controls, clearances and handoffs.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = ("Flight Crew: Workload", "Flight Crew: Procedural compliance");
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Written by the owner in the hand review of 2026-10-10 (flight crew note 3). In the study: the conflict is resolved by one sector controller, whose authority ends at the sector boundary. Objective rows confirmed by the owner (hand review 2026-10-11).";
        }

        requirement <'SN-CRW-01'> captainFinalAuthority : StakeholderNeed {
            doc /* The NAS shall preserve the captain's final authority over the safe
             * conduct of the flight.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = ("Flight Crew: Safety", "Flight Crew: Operational flexibility");
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "14 CFR 91.3";
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10 (crossed out).";
        }

        requirement <'SN-CRW-02'> phaseInformationBeforePhase : StakeholderNeed {
            doc /* The NAS shall give the flight crew the information needed for each phase
             * of flight before that phase begins.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = ("Flight Crew: Safety", "Flight Crew: Procedural compliance");
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "seamster2011collabSystems";
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10 and replaced by the owner's SN-CRW-07.";
        }

        requirement <'SN-CRW-04'> crewMayRequestTrajectoryChange : StakeholderNeed {
            doc /* The NAS shall let the flight crew ask for a trajectory change and get an
             * answer.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = "Flight Crew: Operational flexibility";
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "engility2014tasarAlaska";
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10 (crossed out).";
        }

        requirement <'SN-CRW-05'> dutyTimeLimitsKept : StakeholderNeed {
            doc /* The NAS shall keep each flight crew member within flight and duty time
             * limits.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = "Flight Crew: Schedule/duty constraints";
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> evidenceRefs = "14 CFR Part 117";
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'Not D-007'.";
        }
    }

    package GovernmentsAndStandardsOrganizations {
        doc /* Regulator (FAA as rule maker; Department of Transportation). D-007: Boundary actor. */

        public import RequirementDefinitions::*;

        requirement <'SN-GOV-01'> operatingRulesFollowed : StakeholderNeed {
            doc /* The NAS shall conduct every flight within the operating rules of 14 CFR and the
             * FAA's air traffic orders.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::governmentsAndStandardsOrganizations;
            :>> studyScope = StudyScope::background; // D-031
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = ("faa2025jo711065bb", "faa2025jo72103ee", "14 CFR 91", "14 CFR 121");
            :>> rationale = "In the study: the rules are held fixed (D-007), so both the baseline and the improved architecture must stay inside them. Governance has no table in knowledge/models/stakeholder-objective-ontology.md; the objective is 'Regulatory Compliance' in the enterprise objective hierarchy in knowledge/models/stakeholder-register.md. The owner judged adding a Governance table not important (hand review 2026-10-10). Owner (hand review 2026-10-20): 'How is this relevant via D-007? I think I need to remove.' Kept and tagged background (D-031): the regulator is a boundary actor whose rules are an input to the study, not a stakeholder whose objectives it weighs.";
        }

        requirement <'SN-GOV-02'> accountableAuthorityPerDecision : StakeholderNeed {
            doc /* The NAS shall make one identified authority accountable for each
             * decision that changes a flight's trajectory.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::governmentsAndStandardsOrganizations;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = ("14 CFR 91.3", "14 CFR 121.533", "faa2025jo711065bb");
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'IDK about this one... the Note is an exception!' (the joint dispatcher and captain release). No objective row; from 'Regulatory Compliance' and 'Safety' in the enterprise objective hierarchy.";
        }
    }

    package EnvironmentalAndSocietalOrganizations {
        doc /* Communities and environmental organizations. D-007: Boundary actor (acts through Governance per D-007). */

        public import RequirementDefinitions::*;

        requirement <'SN-ENV-01'> lowCo2PerFlight : StakeholderNeed {
            doc /* The NAS shall keep the CO2 emitted by each flight as low as safety, economics
             * and capacity allow.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::environmentalAndSocietalOrganizations;
            :>> studyScope = StudyScope::background; // D-031
            :>> objectiveRefs = ("Environmental / Societal: CO2", "Environmental / Societal: NOx", "Environmental / Societal: Contrail/climate effects", "Environmental / Societal: Local air quality");
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> evidenceRefs = "icao2024icecMethodology";
            :>> rationale = "In the study: CO2 is fuel burned times 3.16 (D-015), so the experiment's fuel column is also this stakeholder's column. 'Economics' was added by the owner (hand review 2026-10-10) and left standing in the second review. Owner (hand review 2026-10-20): 'This is currently in my cost, but not in my stakeholders. They're treated as background/input.' Tagged background (D-031). Objective rows added by the owner in the workbook review of 2026-10-22 (D-032): Environmental / Societal: NOx; Environmental / Societal: Contrail/climate effects; Environmental / Societal: Local air quality.";
        }

        requirement <'SN-ENV-02'> noiseWithinAbatementProcedures : StakeholderNeed {
            doc /* The NAS shall keep aircraft noise over communities near airports within
             * the published noise abatement procedures.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::environmentalAndSocietalOrganizations;
            :>> objectiveRefs = "Environmental / Societal: Noise"; // Community impacts row struck from the ontology 2026-10-22 (D-033)
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'Not important for cruise.'";
        }
    }

    package AirportOperator {
        doc /* Airport operator. D-007: Modeled system (Airport Operations). Restored out of study (D-031). */

        public import RequirementDefinitions::*;

        requirement <'SN-APT-01'> reliableArrivalDepartureTimes : StakeholderNeed {
            doc /* The NAS shall give the airport operator arrival and departure times
             * reliable enough to assign gates and ground crews.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::airportAuthority;
            :>> objectiveRefs = ("Airport: Gate utilization", "Airport: Turnaround performance", "Airport: Passenger throughput");
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'All of these are not D-007'. Objective rows added by the owner in the workbook review of 2026-10-22 (D-032): Airport: Passenger throughput.";
        }

        requirement <'SN-APT-02'> declaredRunwayCapacityUsed : StakeholderNeed {
            doc /* The NAS shall use the runway capacity the airport has declared
             * available.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::airportAuthority;
            :>> objectiveRefs = "Airport: Runway utilization";
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'All of these are not D-007'.";
        }

        requirement <'SN-APT-03'> shortTaxiQueues : StakeholderNeed {
            doc /* The NAS shall keep the time aircraft wait on taxiways with engines
             * running as short as practical.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::airportAuthority;
            :>> objectiveRefs = "Airport: Surface congestion";
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'All of these are not D-007'.";
        }
    }

    package Passengers {
        doc /* Passengers. D-007: Boundary actor. Restored out of study (D-031). */

        public import RequirementDefinitions::*;

        requirement <'SN-PAX-01'> passengersCarriedWithoutInjury : StakeholderNeed {
            doc /* The NAS shall carry passengers without injury.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::passengers;
            :>> objectiveRefs = "Airline: Flight Safety";
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'Not D-007'. The Passenger table in stakeholder-objective-ontology.md has no safety row; the interest comes from stakeholder-register.md (Social: Passengers, safety and convenience).";
        }

        requirement <'SN-PAX-02'> passengersArriveAsSold : StakeholderNeed {
            doc /* The NAS shall get passengers to their destination, including
             * connections, at the time they were sold.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::passengers;
            :>> objectiveRefs = ("Passenger: Travel time", "Passenger: Connection reliability", "Passenger: Disruption risk");
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'Not D-007'.";
        }

        requirement <'SN-PAX-03'> knownTurbulenceAvoided : StakeholderNeed {
            doc /* The NAS shall avoid known turbulence where a route or altitude change
             * allows it.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::passengers;
            :>> objectiveRefs = "Passenger: Comfort";
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10: 'Not D-007'.";
        }
    }

    package MilitaryAirspaceUsers {
        doc /* Military airspace users. D-007: Boundary actor. Restored out of study (D-031). */

        public import RequirementDefinitions::*;

        requirement <'SN-MIL-01'> specialUseAirspaceForMilitary : StakeholderNeed {
            doc /* The NAS shall give military operations sole use of special use airspace
             * while it is scheduled active.
             */
            :>> status = RequirementStatus::draft;
            :>> studyScope = StudyScope::outOfStudy; // D-031
            :>> stakeholderGroup = StakeholderGroup::military;
            :>> objectiveRefs = "Military: Airspace access";
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "Restored as out of study (D-031): the owner's hand review of 2026-10-20 keeps every stakeholder requirement of the first draft and makes the cut at the sub-system (HLR) tier. Text as on the 2026-10-10 print. Struck 2026-10-10 (crossed out). D-007 makes military operations a boundary actor.";
        }
    }
}
