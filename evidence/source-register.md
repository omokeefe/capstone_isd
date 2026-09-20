# Source Register

This file tracks references at two different depths — keep them straight:

1. **Processing Ledger** (below) — a flat, complete inventory of every file physically in
   `evidence/sources/`. Each entry gets a bibliography entry, a short summary, and a 0-5
   relevance rating. This is a *fast triage pass*, run with
   [workflows/process-references.md](../workflows/process-references.md)
   (skill: `/process-references`) whenever new files land in `evidence/sources/`.
2. **Annotation status tables** (further down, organized by
   `projects/nas-sos-capstone/to-do-list.md` section) — the *deep* field-by-field
   extraction (actors, decisions, constraints, etc.) described in
   [workflows/annotate-source.md](../workflows/annotate-source.md). A source
   can be fully processed (rated, summarized, in the bib) while still `not started` on
   annotation — annotation happens later, when its to-do section is actively worked.

## Processing Ledger

**Last full sweep:** 2026-09-13
**Files in `evidence/sources/` at last sweep:** 52 of 52 processed

**PDF highlight extraction (2026-09-14):** ran `tools/extract_pdf_annotations.py` (skill
`extract-pdf-annotations`) against all 51 PDFs in `evidence/sources/`. **15 of 51 PDFs had
digital highlights/underlines/comments** in their annotation layer; all 15 were merged
into a `## Highlighted passages` section in that source's summary note (36 PDFs had no
digital markup at all). Several of the 15 also carry handwritten/ink annotations, which
were counted but not extracted (not requested; see `workflows/extract-pdf-annotations.md`
for how to opt in later). Sources with highlights merged: `liu2025mbseAtmSmt`,
`luDesignOntologyMBSE2020`, `sinharoy2024ontologyUAM`, `chami2018d3MbseAdoption`,
`mcdermott2020ai4seSe4ai`, `clarke1998irregular`, `maiden2004rescueDman`,
`kontodimou2026turnaroundBuffer`, `hu2024disruptionOptReview`, `bartolomei2012esmdm`,
`castro2013aoccMasThesis`, `santana2023arpReview`, `sadik2025holonicUAM`,
`dispatcherWorkload2025`, `delaurentis2005sosTransportation`.

Rating scale (be honest — a register where everything is a 4 or 5 is not useful):

| Rating | Meaning |
|---|---|
| 5 | Core — directly informs the trajectory-intent chain, a named to-do section, or a central stakeholder/objective; authoritative source; will likely be cited in the final paper. |
| 4 | Strong supporting — clearly relevant, solid rigor, probably cited but not central. |
| 3 | Useful background — relevant domain knowledge or methodology, but tangential to the core storyline; informs framing more than direct evidence. |
| 2 | Marginal — loosely related; may not survive to the final bibliography. |
| 1 | Weak — barely relevant, redundant with a stronger source already in the register, or low rigor. |
| 0 | Not relevant — recommend removal from `evidence/sources/`. |

| File | Bib key | Rating | Summary | Last processed |
|---|---|---|---|---|
| 2026_SciTech_Lupp_et_al_REACT_Database.pdf | `lupp2026reactMbseMdo` | 3 | [lupp2026reactMbseMdo.md](literature-notes/summaries/lupp2026reactMbseMdo.md) | 2026-08-29 |
| A review of aircraft turnaround operations and simulations.pdf | `schultz2017turnaround` | 5 | [schultz2017turnaround.md](literature-notes/summaries/schultz2017turnaround.md) | 2026-08-29 |
| Airline Disruption Management A Literature Review.pdf | `hassanDisruptionReview` | 5 | [hassanDisruptionReview.md](literature-notes/summaries/hassanDisruptionReview.md) | 2026-08-29 |
| Airline Schedule Planning A Review and Future Directions.pdf | `eltoukhy2017airline` | 5 | [eltoukhy2017airline.md](literature-notes/summaries/eltoukhy2017airline.md) | 2026-08-29 |
| Airline Schedule Planning Integrated Models and Algorithms for Schedule Design and Fleet Assignment.pdf | `lohatepanont2004airline` | 4 | [lohatepanont2004airline.md](literature-notes/summaries/lohatepanont2004airline.md) | 2026-08-29 |
| Airline_scheduling_optimizatio.pdf | `xu2024airlineSchedOpt` (renamed from `deng2023airline` — see flag in summary) | 4 | [xu2024airlineSchedOpt.md](literature-notes/summaries/xu2024airlineSchedOpt.md) | 2026-08-29 |
| Design Ontology Supporting Model-based Systems-engineering formalisms.pdf | `luDesignOntologyMBSE2020` | 2 | [luDesignOntologyMBSE2020.md](literature-notes/summaries/luDesignOntologyMBSE2020.md) | 2026-08-29 |
| FAA_data_standards_initiative_systems_engineering_base_for_air_traffic_modernization.pdf | `mitreFAADataStandards` | 4 | [mitreFAADataStandards.md](literature-notes/summaries/mitreFAADataStandards.md) | 2026-08-29 |
| FROM ONTOLOGY TO SYSTEM ARCHITECTURE - AN MBSE APPROACH TOWARD THE REALIZATION OF URBAN AIR MOBILITY.pdf | `sinharoy2024ontologyUAM` | 4 | [sinharoy2024ontologyUAM.md](literature-notes/summaries/sinharoy2024ontologyUAM.md) | 2026-08-29 |
| Irregular airline operations a review of the state-of-the-practice in airline operations control centers.pdf | `clarke1998irregular` | 5 | [clarke1998irregular.md](literature-notes/summaries/clarke1998irregular.md) | 2026-08-29 |
| Model-Based Systems Engineering Approach for a Systematic Design of Aircraft Engine Inlet.pdf | `jagtap2025mbseEngineInlet` | 2 | [jagtap2025mbseEngineInlet.md](literature-notes/summaries/jagtap2025mbseEngineInlet.md) | 2026-08-29 |
| NAS-Infrastructure-Roadmaps-v20.pdf | `faaNasInfrastructureRoadmaps2025` | 5 | [faaNasInfrastructureRoadmaps2025.md](literature-notes/summaries/faaNasInfrastructureRoadmaps2025.md) | 2026-08-29 |
| NASA's Use of MBSE and SysML Modeling to Architect the Future of Human Exploration.pdf | `hill2024nasaMbseHumanExploration` | 3 | [hill2024nasaMbseHumanExploration.md](literature-notes/summaries/hill2024nasaMbseHumanExploration.md) | 2026-08-29 |
| Systems Engineering - 2011 - Bartolomei - Engineering Systems Multiple‐Domain Matrix ... .pdf | `bartolomei2012esmdm` | 4 | [bartolomei2012esmdm.md](literature-notes/summaries/bartolomei2012esmdm.md) | 2026-08-29 |
| Workload Balancing for Flight Dispatchers.pdf | `dispatcherWorkload2025` | 5 | [dispatcherWorkload2025.md](literature-notes/summaries/dispatcherWorkload2025.md) | 2026-08-29 |
| an-approach-for-system-analysis-with-model-based-systems-engineering-and-graph-data-engineering.pdf | `schummer2022mbseGraphAnalysis` | 2 | [schummer2022mbseGraphAnalysis.md](literature-notes/summaries/schummer2022mbseGraphAnalysis.md) | 2026-08-29 |
| de Neufville_Engineering Systems.pdf | `bartolomei2012esmdm` (duplicate/earlier draft — see flag) | 1 | [de-neufville-conference-draft-of-bartolomei2012esmdm.md](literature-notes/summaries/de-neufville-conference-draft-of-bartolomei2012esmdm.md) | 2026-08-29 |
| delaurentis-2005-understanding-transportation-as-a-system-of-systems-design-problem.pdf | `delaurentis2005sosTransportation` (year corrected — see flag) | 0 | [0 - delaurentis2005sosTransportation.md](literature-notes/summaries/0%20-%20delaurentis2005sosTransportation.md) | 2026-09-19 (re-rated 5 → 0 by user) |
| eurocontrol-specification-for-acdm.pdf | `eurocontrolACDMSpec` | 5 | [eurocontrolACDMSpec.md](literature-notes/summaries/eurocontrolACDMSpec.md) | 2026-08-29 |
| A Predictive Services Architecture for Efficient Airspace Operations.pdf | `romanideoliveira2026predictiveservices` | 4 | [4 - romanideoliveira2026predictiveservices.md](literature-notes/summaries/4%20-%20romanideoliveira2026predictiveservices.md) | 2026-09-04 |
| AI- and Ontology-Based Enhancements to FMEA for Advanced Systems Engineering - Current Developments and Future Directions.pdf | `younus2026fmeaOntology` | 3 | [3 - younus2026fmeaOntology.md](literature-notes/summaries/3%20-%20younus2026fmeaOntology.md) | 2026-09-04 |
| Harnessing Digital Twin Technology for Enhanced Aircraft Turnaround Efficiency.pdf | `lu2025digitalTwinTurnaround` | 2 | [2 - lu2025digitalTwinTurnaround.md](literature-notes/summaries/2%20-%20lu2025digitalTwinTurnaround.md) | 2026-09-04 |
| Knowledge-Based Aerospace Engineering A Systematic Literature Review.pdf | `wittenborg2025kbeAerospace` | 2 | [2 - wittenborg2025kbeAerospace.md](literature-notes/summaries/2%20-%20wittenborg2025kbeAerospace.md) | 2026-09-04 |
| Personal knowledge management the foundation of organisational knowledge management.pdf | `jain2011pkm` | 1 | [1 - jain2011pkm.md](literature-notes/summaries/1%20-%20jain2011pkm.md) | 2026-09-04 |
| Review of Optimization Problems, Models and Methods for Airline Disruption Management from 2010 to 2024,.pdf | `hu2024disruptionOptReview` | 3 | [3 - hu2024disruptionOptReview.md](literature-notes/summaries/3%20-%20hu2024disruptionOptReview.md) | 2026-09-04 |
| System-of-systems safety for low-altitude aviation transportation.pdf | `yao2026loAltitudeSoSSafety` | 4 | [4 - yao2026loAltitudeSoSSafety.md](literature-notes/summaries/4%20-%20yao2026loAltitudeSoSSafety.md) | 2026-09-04 |
| The Aircraft Recovery Problem A Systematic Literature Review.pdf | `santana2023arpReview` | 4 | [4 - santana2023arpReview.md](literature-notes/summaries/4%20-%20santana2023arpReview.md) | 2026-09-04 |
| Urban Air Mobility as a System of Systems An LLM-Enhanced Holonic Approach.pdf | `sadik2025holonicUAM` | 3 | [3 - sadik2025holonicUAM.md](literature-notes/summaries/3%20-%20sadik2025holonicUAM.md) | 2026-09-04 |
| Proactive Aircraft Turnaround Buffer Optimization Integrating Machine Learning and Scenario Analysis.pdf | `kontodimou2026turnaroundBuffer` | 3 | [3 - kontodimou2026turnaroundBuffer.md](literature-notes/summaries/3%20-%20kontodimou2026turnaroundBuffer.md) | 2026-09-04 |
| 51.Model-BasedSystemsEngineeringSupportingArchitectureModelingofAirTrafficManagementSystemandModelVerifyingBasedonSMT.pdf | `liu2025mbseAtmSmt` | 4 | [4 - liu2025mbseAtmSmt.md](literature-notes/summaries/4%20-%20liu2025mbseAtmSmt.md) | 2026-09-05 |
| mudumba-et-al-2022-model-based-systems-engineering-approach-for-simulating-uml-5-uam-operations.pdf | `mudumba2022mbseUml5uam` | 3 | [3 - mudumba2022mbseUml5uam.md](literature-notes/summaries/3%20-%20mudumba2022mbseUml5uam.md) | 2026-09-05 |
| PritiJainpaperaspublishedliasa_v77_n1_a2.pdf | `jain2011pkm` (duplicate PDF — see flag) | 1 | [1 - jain2011pkm.md](literature-notes/summaries/1%20-%20jain2011pkm.md) | 2026-09-05 |
| Article Modeling and Analysis of Unmanned Aerial Vehicle System Leveraging Systems Modeling Language (SysML).pdf | `hossain2022uavSysml` | 2 | [2 - hossain2022uavSysml.md](literature-notes/summaries/2%20-%20hossain2022uavSysml.md) | 2026-09-13 |
| Conceptual Modeling of Cyber-Physical Gaps in Air Traffic Control.pdf | `mordecai2018cyberPhysicalGapAtc` | 4 | [4 - mordecai2018cyberPhysicalGapAtc.md](literature-notes/summaries/4%20-%20mordecai2018cyberPhysicalGapAtc.md) | 2026-09-13 |
| Creating Executable Agent-Based Models Using SysML.pdf | `maheshwari2015sysmlAbmAtc` | 3 | [3 - maheshwari2015sysmlAbmAtc.md](literature-notes/summaries/3%20-%20maheshwari2015sysmlAbmAtc.md) | 2026-09-13 |
| FIXM_US_Extension_v4.4.0_Logical_Model_Diagrams.pdf | `faaFixmUsExtension2024` | 4 | [4 - faaFixmUsExtension2024.md](literature-notes/summaries/4%20-%20faaFixmUsExtension2024.md) | 2026-09-13 |
| Flight Control System Modeling with SysML to Support Validation, Qualification and Certification.pdf | `mhenni2016fcsSysml` | 2 | [2 - mhenni2016fcsSysml.md](literature-notes/summaries/2%20-%20mhenni2016fcsSysml.md) | 2026-09-13 |
| Formal modeling of a complex adaptive air traffic control system.pdf | `jarrar2018formalAtcEventB` | 3 | [3 - jarrar2018formalAtcEventB.md](literature-notes/summaries/3%20-%20jarrar2018formalAtcEventB.md) | 2026-09-13 |
| GREAT_D2.1_Concept_VF - Good Content.pdf | `great2020d21tboConcept` | 5 | [5 - great2020d21tboConcept.md](literature-notes/summaries/5%20-%20great2020d21tboConcept.md) | 2026-09-13 |
| GREAT_D2.2_Modelling_operational_system_architecture_VF - Good Content.pdf | `great2021d22operationalArch` | 5 | [5 - great2021d22operationalArch.md](literature-notes/summaries/5%20-%20great2021d22operationalArch.md) | 2026-09-13 |
| GreAT_D5.1-ATM-avionic-system-architecture-development_VF.pdf | `great2021d51avionicsArch` | 4 | [4 - great2021d51avionicsArch.md](literature-notes/summaries/4%20-%20great2021d51avionicsArch.md) | 2026-09-13 |
| INCOSE International Symp - 2018 - Chami - Towards Solving MBSE Adoption Challenges  The D3 MBSE Adoption Toolbox.pdf | `chami2018d3MbseAdoption` | 2 | [2 - chami2018d3MbseAdoption.md](literature-notes/summaries/2%20-%20chami2018d3MbseAdoption.md) | 2026-09-13 |
| INCOSEInternationalSymp-2022-Lu-SemanticModelbasedSystemsEngineeringbasedonKARMAAResearchandPractice.pdf | `lu2022karmaRoadmap` | 3 | [3 - lu2022karmaRoadmap.md](literature-notes/summaries/3%20-%20lu2022karmaRoadmap.md) | 2026-09-13 |
| INSIGHT - 2020 - McDermott - AI4SE and SE4AI  A Research Roadmap.pdf | `mcdermott2020ai4seSe4ai` | 2 | [2 - mcdermott2020ai4seSe4ai.md](literature-notes/summaries/2%20-%20mcdermott2020ai4seSe4ai.md) | 2026-09-13 |
| Model-Driven Requirements Engineering - Synchronising Models in an Air Traffic Management Case Study.pdf | `maiden2004rescueDman` | 4 | [4 - maiden2004rescueDman.md](literature-notes/summaries/4%20-%20maiden2004rescueDman.md) | 2026-09-13 |
| Modelling Traffic Scenarios for Realistic Air Traffic Control Environment Testing.pdf | `axholt2004atcScenarios` | 2 | [2 - axholt2004atcScenarios.md](literature-notes/summaries/2%20-%20axholt2004atcScenarios.md) | 2026-09-13 |
| SESAR Master Plan 2025.pdf | `sesarju2025masterPlan` | 5 | [5 - sesarju2025masterPlan.md](literature-notes/summaries/5%20-%20sesarju2025masterPlan.md) | 2026-09-13 |
| SESAR_eATM_ATM_Capabilities.xlsx | `sesarju2025eatmCapabilities` | 3 | [3 - sesarju2025eatmCapabilities.md](literature-notes/summaries/3%20-%20sesarju2025eatmCapabilities.md) | 2026-09-13 |
| Towards a Comparative Analysis of Meta-Metamodels (Kern, Hummel, Kuhne).pdf | `kern2011metametamodels` | 2 | [2 - kern2011metametamodels.md](literature-notes/summaries/2%20-%20kern2011metametamodels.md) | 2026-09-13 |
| Understanding the Implications for Airports of Distributed Air Transportation Using a System-of-Systems Approach.pdf | `delaurentis2008airportsSos` | 4 | [4 - delaurentis2008airportsSos.md](literature-notes/summaries/4%20-%20delaurentis2008airportsSos.md) | 2026-09-13 |
| Tese_Doutoramento_AntonioCastro_18Julho2013.pdf | `castro2013aoccMasThesis` | 5 | [5 - castro2013aoccMasThesis.md](literature-notes/summaries/5%20-%20castro2013aoccMasThesis.md) | 2026-09-13 |
| Evaluation of a Multi-Agent System approach to airline disruption management.pdf | `bouarfa2018masDisruption` | 4 | [4 - bouarfa2018masDisruption.md](literature-notes/summaries/4%20-%20bouarfa2018masDisruption.md) | 2026-09-13 |

**Distribution:** thirteen 5s, sixteen 4s, eleven 3s, eleven 2s, three 1s, zero 0s — 52 files, 50
distinct works (one remaining draft/published pair, see Flags below, plus the `jain2011pkm`
duplicate PDF pair found 2026-09-05; the exact-duplicate `jagtap2025mbseEngineInlet` PDF pair
was resolved during the 2026-09-05 PKM reorg — one copy removed). No exact duplicates found
among the 18 files added 2026-09-13, though several overlap topically with existing sources —
see the Flags entry below. Two more files (a PhD thesis and its companion journal paper) were
added and processed later the same day — see the follow-up flags note below.

### Flags raised by this sweep (2026-09-13, 18 new files)

- **No exact duplicates.** All 18 files are distinct works from the 32 already in the register.
- **Three GreAT (Greener Air Traffic Operations, EU-China H2020, Grant 875154) project
  deliverables added** — `great2020d21tboConcept` (D2.1, TBO concept baseline), 
  `great2021d22operationalArch` (D2.2, MBSE-derived operational + system architecture), and
  `great2021d51avionicsArch` (D5.1, avionics-level functional architecture). Confirmed
  complementary volumes of one project's concept -> architecture -> avionics progression, not
  duplicates of one another. `great2021d22operationalArch` (rated 5) is arguably the single most
  directly useful new source in this batch for the capstone's core architecture work (§6, §10) —
  a rare real-world precedent for deriving ATM system architecture from an operational concept via
  MBSE.
- **`sesarju2025masterPlan`** (SESAR European ATM Master Plan, 2025 edition) is flagged, per the
  task instructions, as a **topical parallel** (not a duplicate) to the already-registered
  `faaNasInfrastructureRoadmaps2025` — the European and US counterparts of the same kind of
  national/regional ATM roadmap document; natural to cite as a comparative pair.
- **`sesarju2025eatmCapabilities`** (the SESAR eATM capability-model .xlsx) is a structured-data
  extraction from the public ATM Master Plan website, not an authored publication — flagged as
  such in its bib `note` and summary. It complements `sesarju2025masterPlan` as its structured-data
  counterpart.
- **`lu2022karmaRoadmap`** (INCOSE 2022, general KARMA-methodology research roadmap) is flagged as
  a companion/precursor to the already-registered `liu2025mbseAtmSmt` (KARMA applied to ATM
  architecture modeling, KSEM 2024/Springer) — same KARMA language, overlapping Jinzhi Lu
  authorship, but a distinct paper (general methodology vs. ATM-domain application), not a
  duplicate.
- **`delaurentis2008airportsSos`** (2008 journal article on airports under distributed/on-demand
  air transportation, using an SoS approach) is flagged as a **same-author, different-paper**
  relationship to the already-registered `delaurentis2005sosTransportation` (2005 AIAA conference
  paper on general SoS-for-transportation taxonomy) — extends rather than duplicates that source;
  worth citing as a pair.
- **`mcdermott2020ai4seSe4ai`** shares co-author Dan DeLaurentis with
  `delaurentis2005sosTransportation`, `mudumba2022mbseUml5uam`, and `maheshwari2015sysmlAbmAtc`,
  but is a distinct, broader SERC research-roadmap paper (no ATM-specific content) — not a
  duplicate of any of those.
- **One bibliographic detail flagged as unconfirmed:** `faaFixmUsExtension2024`'s exact release
  year is not stated in the document itself (no title-page byline or date); inferred as ~2024 from
  FIXM's known v4.3.0 (2023) release cadence — **verify against fixm.aero before citing precisely.**
  Similarly, `maiden2004rescueDman` and `kern2011metametamodels` had their year/venue confirmed via
  web search rather than the PDF text itself (neither showed a visible masthead/header on the pages
  captured) — both confirmed against independent sources (City Research Online; ACM Digital
  Library) with reasonable confidence.
- **No files rated 0 or 1 in this batch.** Lowest ratings were six 2s (`hossain2022uavSysml`,
  `mhenni2016fcsSysml`, `chami2018d3MbseAdoption`, `mcdermott2020ai4seSe4ai`,
  `axholt2004atcScenarios`, `kern2011metametamodels`) — all methodologically sound but tangential
  to the NAS-as-SoS/trajectory-intent storyline (vehicle/component-level MBSE case studies,
  organizational-adoption process papers, or pure modeling-theory background); none flagged as
  candidates for removal.

### Flags raised by the follow-up 2026-09-13 sweep (2 new files)

- **No duplicates; the two files are a matched pair, not independent sources.**
  `castro2013aoccMasThesis` (António Castro's 2013 FEUP PhD thesis) originates MASDIMA, a
  distributed Multi-Agent System for AOC disruption management, plus the GQN negotiation
  protocol and the PORTO AOSE methodology. `bouarfa2018masDisruption` (Bouarfa, Müller & Blom,
  *Journal of Air Transport Management* 2018) is a later TU Delft benchmark/evaluation of that
  same MASDIMA policy against human-team AOC coordination policies. Cite together.
- **`castro2013aoccMasThesis` rated 5/5** — the strongest new source found since the 18-file
  sweep earlier today: a real, implemented distributed-agent decomposition of AOC disruption
  management with explicit per-stakeholder (aircraft/crew/passenger) utility functions, directly
  useful for both the architecture-decomposition work (§6, §10) and the
  objective/cost-ontology and myopic-optimization-conflict analysis (§7-9). Only skimmed (front
  matter) on this triage pass — flagged as a priority candidate for a full
  `annotate-source.md` deep-read.
- No bibliographic ambiguity — both sources had complete author/venue/DOI (or thesis
  institution) metadata directly on the pages read.
- No files rated 0-1 in this follow-up batch.

### Flags raised by this sweep

- **Two citation-integrity errors found and corrected in `references.bib`:**
  - `deng2023airline` → renamed `xu2024airlineSchedOpt`: the old entry's author list
    ("Deng, Qi and Santos, Bruno F.") did not match the actual PDF (authors are Xu,
    Wandelt & Sun). Old key preserved in the new entry's `note` for traceability.
  - `schultz2017turnaround`: author corrected from "Schultz, Michael" to the PDF's actual
    byline, "Schmidt, Michael." Bib key kept as-is for continuity.
  - `to-do-list.md`'s section headers for these two sources still say
    "Schultz" and imply "Deng & Santos" — not edited automatically; flagged for the user.
- **Two exact-duplicate PDF pairs** found in `references/` (as it then was):
  - `MBSE Approach for designing aircraft engine inlet - cinar.pdf` ==
    `Model-Based Systems Engineering Approach for a Systematic Design of Aircraft Engine Inlet.pdf`
    (identical paper, same DOI 10.2514/6.2025-1410). **Resolved 2026-09-05** — the
    `- cinar` copy and its duplicate summary stub were removed during the PKM reorg.
  - `de Neufville_Engineering Systems.pdf` is a 2009 conference-manuscript draft of the
    same work published as `Systems Engineering - 2011 - Bartolomei - ...pdf` (2012 journal
    version, DOI 10.1002/sys.20193). Draft vs. published, not byte-identical — kept as two
    files; still a candidate for consolidation if a user decision is made later.
- **Two filename/version mismatches** worth double-checking against the source:
  - `NAS-Infrastructure-Roadmaps-v20.pdf`'s title page reads "v19.1," not v20.
  - `delaurentis-2005-...pdf`'s filename says 2012; the paper itself is AIAA 2005-123
    (year 2005). Bib entry uses the verified 2005 date.
- Also fixed a **stray trailing `}`** at the end of the previous `references.bib` (a
  syntax error left over from an earlier edit).

### Flags raised by this sweep (2026-09-05, 3 new files)

- **Exact-duplicate PDF found:** `PritiJainpaperaspublishedliasa_v77_n1_a2.pdf` is the
  same paper as the already-registered `jain2011pkm`
  (`Personal knowledge management the foundation of organisational knowledge
  management.pdf`) — identical title, author, journal, volume/issue/pages (SA Jnl Libs &
  Info Sci, 77(1), 1-14). No new bib entry or summary written; the new file is just noted
  in the ledger row above. **Recommend a user decision** on which copy to keep (or remove
  both, given the existing 1/5 off-topic rating) — same pattern as the resolved
  `jagtap2025mbseEngineInlet` duplicate pair, not resolved automatically.
- **Two new MBSE-methodology papers added, no duplicates:** `liu2025mbseAtmSmt` (ATM
  architecture modeling + SMT-based requirements verification, KSEM 2024/Springer) and
  `mudumba2022mbseUml5uam` (SysML modeling of UAM Maturity Level 5 operations, AIAA 2022,
  Purdue/DeLaurentis group). Neither overlaps with an existing source; `mudumba2022mbseUml5uam`
  extends the existing UAM-as-SoS cluster (`sinharoy2024ontologyUAM`, `sadik2025holonicUAM`,
  `yao2026loAltitudeSoSSafety`) from a state-machine/activity-diagram angle rather than
  duplicating it, and its own reference list independently confirms
  `delaurentis2005sosTransportation`'s title and DOI as already registered.

### Flags raised by the 2026-09-04 sweep (10 new files)

- **No exact duplicates** among the ten new files, but several overlap topically with
  existing or other new sources — treated as complementary, not redundant, per each
  summary's Flags section:
  - `hu2024disruptionOptReview` (2010-2024 optimization-methods review) and
    `santana2023arpReview` (aircraft-recovery-specific SLR) both extend/complement
    `hassanDisruptionReview` rather than duplicating it — different scope/framing/cutoff.
  - `sadik2025holonicUAM` (holonic + LLM architecture) and `yao2026loAltitudeSoSSafety`
    (safety-literature review) both cover UAM/low-altitude airspace as an SoS but from
    different angles (architecture/coordination vs. safety) — not duplicative of each
    other or of `sinharoy2024ontologyUAM` (ontology-driven MBSE approach to the same
    general topic).
  - `lu2025digitalTwinTurnaround` (robotics/digital-twin automation) and
    `kontodimou2026turnaroundBuffer` (ML + stochastic-MILP buffer optimization) both
    address turnaround efficiency but via distinct methods — complementary additions to
    §3 alongside `schultz2017turnaround`.
- **`younus2026fmeaOntology`** cites the same Lu et al. design-ontology work as
  `luDesignOntologyMBSE2020` but with a different venue/year (*IEEE Systems Journal*,
  2022, vs. the registered arXiv 2020 entry) — worth reconciling which is the
  authoritative citation.
- **`yao2026loAltitudeSoSSafety`** cites a DeLaurentis 2005 SoS-taxonomy paper ("A
  Taxonomy-Based Perspective for Systems-of-Systems Design Methods," IEEE SMC 2005) that
  may be a *different* work from the PDF registered as `delaurentis2005sosTransportation`
  — flagged in `evidence/sources/references.bib` and
  `knowledge/questions/open-questions.md` for confirmation.
- **`jain2011pkm`** (Personal Knowledge Management) rated 1/5 — off-topic for this
  register (library/information-science survey, zero aerospace/MBSE content). Resolved
  2026-09-14: kept in `evidence/sources/` — relevant for personal PKM practice tied to
  project execution, even though off-topic for the NAS/MBSE literature itself.
- **Filename correction:** the file on disk named "roactive Aircraft Turnaround Buffer
  Optimization..." (truncated) was renamed to "Proactive Aircraft Turnaround Buffer
  Optimization Integrating Machine Learning and Scenario Analysis.pdf" to match the
  verified title (`kontodimou2026turnaroundBuffer`).
- **DOI not confirmed on the pages read** for `sadik2025holonicUAM` (IEEE Xplore document
  ID found, not the DOI string) and `wittenborg2025kbeAerospace` (arXiv preprint, no DOI
  exists yet) — verify before final citation.

## Annotation status (by `projects/nas-sos-capstone/to-do-list.md` section)

Only the identifying columns are filled in below — the deep-annotation analysis columns
(NAS lifecycle phase, systems, stakeholders, architectural evidence, optimization
evidence, SysML artifacts) are genuinely unstarted, matching every unchecked box in
§1–§4 of the to-do list as of 2026-08-29. Fill a row in as its "Read and annotate"
checklist gets worked, using
[workflows/annotate-source.md](../workflows/annotate-source.md) and
[templates/source-annotation-template.md](../templates/source-annotation-template.md).

Status values: `not started` · `in progress` · `annotated` · `mapped to architecture`.

### Airline planning & operations (to-do §2)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| Airline Schedule Planning A Review and Future Directions.pdf | `eltoukhy2017airline` | journal review | not started |
| Airline_scheduling_optimizatio.pdf | `xu2024airlineSchedOpt` | journal review | not started |
| Airline Schedule Planning Integrated Models and Algorithms for Schedule Design and Fleet Assignment.pdf | `lohatepanont2004airline` | journal article | not started |
| — (no PDF yet) | `yan2008integrated` (Integrated Airline Scheduling) | journal article | not started — bib entry removed from `references.bib` 2026-09-14 (never had a PDF; author/volume/DOI were also unverified); re-add once a PDF is found and metadata confirmed |
| — (no PDF yet) | `timetableFleetPassengerChoice` (timetable/fleet assignment + passenger choice) | journal article | not started — bib entry removed 2026-09-14, no PDF ever collected |
| — (no PDF yet) | `crewSchedulingReview` (Airline Crew Scheduling: Models, Algorithms, Data Sets) | journal review | not started — bib entry removed 2026-09-14, no PDF ever collected |
| — (no PDF yet) | `aircraftMaintenanceRoutingReview` | journal review | not started — bib entry removed 2026-09-14, no PDF ever collected |
| — (no PDF yet) | `garg2024integrated` (Integrated Airline Planning) | journal article | not started — bib entry removed 2026-09-14, no PDF ever collected |

### Turnaround & day-of-operations (to-do §3)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| A review of aircraft turnaround operations and simulations.pdf | `schultz2017turnaround` | journal review | not started |
| — (no PDF yet) | `turnaroundCDM` (Managing Turnaround Performance through CDM) | journal article | not started — bib entry removed 2026-09-14, no PDF ever collected |
| eurocontrol-specification-for-acdm.pdf | `eurocontrolACDMSpec` | EUROCONTROL spec | not started |
| — (no PDF yet) | `eurocontrolACDMManual` (A-CDM Implementation Manual) | EUROCONTROL manual | not started — bib entry removed 2026-09-14, no PDF ever collected |
| — (no PDF yet) | `loadControl2026` (Automated Load Control and W&B Validation) | journal/technical article | not started — bib entry removed 2026-09-14, no PDF ever collected |
| Harnessing Digital Twin Technology for Enhanced Aircraft Turnaround Efficiency.pdf | `lu2025digitalTwinTurnaround` | journal article | not started |
| Proactive Aircraft Turnaround Buffer Optimization Integrating Machine Learning and Scenario Analysis.pdf | `kontodimou2026turnaroundBuffer` | journal article | not started |

### OCC, dispatch & flight execution (to-do §4)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| Airline Disruption Management A Literature Review.pdf | `hassanDisruptionReview` | journal review | not started |
| Irregular airline operations a review of the state-of-the-practice in airline operations control centers.pdf | `clarke1998irregular` | journal review | not started |
| Workload Balancing for Flight Dispatchers.pdf | `dispatcherWorkload2025` | journal article | not started |
| Review of Optimization Problems, Models and Methods for Airline Disruption Management from 2010 to 2024,.pdf | `hu2024disruptionOptReview` | journal review | not started |
| The Aircraft Recovery Problem A Systematic Literature Review.pdf | `santana2023arpReview` | journal review | annotated — see [santana2023arpReview.md](literature-notes/annotations/santana2023arpReview.md) |
| Tese_Doutoramento_AntonioCastro_18Julho2013.pdf | `castro2013aoccMasThesis` | PhD thesis | not started — high priority given 5/5 rating; see [5 - castro2013aoccMasThesis.md](literature-notes/summaries/5%20-%20castro2013aoccMasThesis.md) |
| Evaluation of a Multi-Agent System approach to airline disruption management.pdf | `bouarfa2018masDisruption` | journal article | not started |
| — (nominal ATC/IFR flight execution) | none yet | FAA source(s) TBD | not started — need to identify specific FAA/AIM references per to-do §4 |

### MBSE methodology & systems-architecture references (not yet tied to a to-do §; background/methods reading)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| Design Ontology Supporting Model-based Systems-engineering formalisms.pdf | `luDesignOntologyMBSE2020` | arXiv preprint | not started |
| FROM ONTOLOGY TO SYSTEM ARCHITECTURE - AN MBSE APPROACH TOWARD THE REALIZATION OF URBAN AIR MOBILITY.pdf | `sinharoy2024ontologyUAM` | conference paper (ICAS) | not started |
| Model-Based Systems Engineering Approach for a Systematic Design of Aircraft Engine Inlet.pdf | `jagtap2025mbseEngineInlet` | conference paper (AIAA) | not started |
| NASA's Use of MBSE and SysML Modeling to Architect the Future of Human Exploration.pdf | `hill2024nasaMbseHumanExploration` | conference paper (INCOSE) | not started |
| an-approach-for-system-analysis-with-model-based-systems-engineering-and-graph-data-engineering.pdf | `schummer2022mbseGraphAnalysis` | journal article | not started |
| Systems Engineering - 2011 - Bartolomei - Engineering Systems Multiple-Domain Matrix.pdf | `bartolomei2012esmdm` | journal article | not started |
| de Neufville_Engineering Systems.pdf | `bartolomei2012esmdm` | conference manuscript draft | not started — confirmed earlier draft of the row above, not a distinct de Neufville-authored work |
| delaurentis-2005-understanding-transportation-as-a-system-of-systems-design-problem.pdf | `delaurentis2005sosTransportation` | conference paper (AIAA) | not started — rated 0 (not relevant) by user 2026-09-19, so no annotation planned; year corrected from filename's "2012" to verified 2005 |
| NAS-Infrastructure-Roadmaps-v20.pdf | `faaNasInfrastructureRoadmaps2025` | FAA/government roadmap document | not started |
| FAA_data_standards_initiative_systems_engineering_base_for_air_traffic_modernization.pdf | `mitreFAADataStandards` | conference paper (IEEE/MITRE) | not started |
| 2026_SciTech_Lupp_et_al_REACT_Database.pdf | `lupp2026reactMbseMdo` | conference paper (AIAA SciTech) | not started |
| A Predictive Services Architecture for Efficient Airspace Operations.pdf | `romanideoliveira2026predictiveservices` | conference paper (IEEE ICNS) | annotated — see [romanideoliveira2026predictiveservices.md](literature-notes/annotations/romanideoliveira2026predictiveservices.md) |
| AI- and Ontology-Based Enhancements to FMEA for Advanced Systems Engineering - Current Developments and Future Directions.pdf | `younus2026fmeaOntology` | journal review | not started |
| Knowledge-Based Aerospace Engineering A Systematic Literature Review.pdf | `wittenborg2025kbeAerospace` | arXiv preprint | not started |
| System-of-systems safety for low-altitude aviation transportation.pdf | `yao2026loAltitudeSoSSafety` | journal review | annotated — see [yao2026loAltitudeSoSSafety.md](literature-notes/annotations/yao2026loAltitudeSoSSafety.md) |
| Urban Air Mobility as a System of Systems An LLM-Enhanced Holonic Approach.pdf | `sadik2025holonicUAM` | conference paper (IEEE SOSE) | not started |
| 51.Model-BasedSystemsEngineeringSupportingArchitectureModelingofAirTrafficManagementSystemandModelVerifyingBasedonSMT.pdf | `liu2025mbseAtmSmt` | conference paper (KSEM/Springer) | not started |
| mudumba-et-al-2022-model-based-systems-engineering-approach-for-simulating-uml-5-uam-operations.pdf | `mudumba2022mbseUml5uam` | conference paper (AIAA) | not started |
| Article Modeling and Analysis of Unmanned Aerial Vehicle System Leveraging Systems Modeling Language (SysML).pdf | `hossain2022uavSysml` | journal article (MDPI Systems) | not started |
| Conceptual Modeling of Cyber-Physical Gaps in Air Traffic Control.pdf | `mordecai2018cyberPhysicalGapAtc` | conference paper (Procedia CS) | not started — likely relevant to trajectory-intent framing |
| Creating Executable Agent-Based Models Using SysML.pdf | `maheshwari2015sysmlAbmAtc` | conference paper (INCOSE) | not started |
| FIXM_US_Extension_v4.4.0_Logical_Model_Diagrams.pdf | `faaFixmUsExtension2024` | FAA data-standard diagram export | not started — candidate reference for §6/§10 data-model work |
| Flight Control System Modeling with SysML to Support Validation, Qualification and Certification.pdf | `mhenni2016fcsSysml` | conference paper (IFAC) | not started |
| Formal modeling of a complex adaptive air traffic control system.pdf | `jarrar2018formalAtcEventB` | journal article | not started |
| GREAT_D2.1_Concept_VF - Good Content.pdf | `great2020d21tboConcept` | EU-China project deliverable (GreAT) | not started — likely directly relevant to trajectory-intent/ConOps framing |
| GREAT_D2.2_Modelling_operational_system_architecture_VF - Good Content.pdf | `great2021d22operationalArch` | EU-China project deliverable (GreAT) | not started — priority candidate for §6/§10 architecture work |
| GreAT_D5.1-ATM-avionic-system-architecture-development_VF.pdf | `great2021d51avionicsArch` | EU-China project deliverable (GreAT) | not started |
| INCOSE International Symp - 2018 - Chami - Towards Solving MBSE Adoption Challenges  The D3 MBSE Adoption Toolbox.pdf | `chami2018d3MbseAdoption` | conference paper (INCOSE) | not started |
| INCOSEInternationalSymp-2022-Lu-SemanticModelbasedSystemsEngineeringbasedonKARMAAResearchandPractice.pdf | `lu2022karmaRoadmap` | conference paper (INCOSE) | not started |
| INSIGHT - 2020 - McDermott - AI4SE and SE4AI  A Research Roadmap.pdf | `mcdermott2020ai4seSe4ai` | journal article (INSIGHT) | not started |
| Model-Driven Requirements Engineering - Synchronising Models in an Air Traffic Management Case Study.pdf | `maiden2004rescueDman` | conference paper (CAiSE) | not started — likely relevant to §7-§9 stakeholder/goal ontology methodology |
| Modelling Traffic Scenarios for Realistic Air Traffic Control Environment Testing.pdf | `axholt2004atcScenarios` | master's thesis | not started |
| SESAR Master Plan 2025.pdf | `sesarju2025masterPlan` | SESAR JU roadmap document | not started — priority candidate, European counterpart to faaNasInfrastructureRoadmaps2025 |
| SESAR_eATM_ATM_Capabilities.xlsx | `sesarju2025eatmCapabilities` | extracted capability taxonomy (data) | not started |
| Towards a Comparative Analysis of Meta-Metamodels (Kern, Hummel, Kuhne).pdf | `kern2011metametamodels` | workshop paper (DSM'11/SPLASH) | not started |
| Understanding the Implications for Airports of Distributed Air Transportation Using a System-of-Systems Approach.pdf | `delaurentis2008airportsSos` | journal article | not started — likely relevant to §6 (decomposition), extends delaurentis2005sosTransportation |

### Off-topic / process background (not tied to any to-do §; flagged for a keep-or-remove decision)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| Personal knowledge management the foundation of organisational knowledge management.pdf | `jain2011pkm` | journal article | not started — rated 1/5, off-topic for this register (library/information science, no aerospace/MBSE content); see Flags above for the keep-or-remove decision |
| PritiJainpaperaspublishedliasa_v77_n1_a2.pdf | `jain2011pkm` (duplicate) | journal article | n/a — duplicate PDF of the row above, found 2026-09-05; see Flags above |

## Housekeeping

- Rows with "no PDF yet" mean the bib entry exists in `evidence/sources/references.bib`
  but no PDF has been added to `evidence/sources/` — chase these down before annotating.
- Rows with "no bib entry yet" mean a PDF exists in `evidence/sources/` with no matching
  `references.bib` entry — add one when the source is first processed, using the
  citation-key style already in use (`lastname+year+shorttitle`, e.g.
  `schultz2017turnaround`).
- `de Neufville_Engineering Systems.pdf` and the Bartolomei Multiple-Domain Matrix paper
  are the same work (draft + published version) — general engineering-systems background,
  not airline-ops literature. Relevant to the "Explore Alternative System Decompositions"
  work (to-do §6), not §2–§4.
