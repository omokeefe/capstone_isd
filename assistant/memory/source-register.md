# Source Register

This file tracks references at two different depths — keep them straight:

1. **Processing Ledger** (below) — a flat, complete inventory of every file physically in
   `references/`. Each entry gets a bibliography entry, a short summary, and a 0-5
   relevance rating. This is a *fast triage pass*, run with
   [assistant/workflows/process-references.md](../workflows/process-references.md)
   (skill: `/process-references`) whenever new files land in `references/`.
2. **Annotation status tables** (further down, organized by `Project_To-Do List.md`
   section) — the *deep* field-by-field extraction (actors, decisions, constraints,
   etc.) described in
   [assistant/workflows/annotate-source.md](../workflows/annotate-source.md). A source
   can be fully processed (rated, summarized, in the bib) while still `not started` on
   annotation — annotation happens later, when its to-do section is actively worked.

## Processing Ledger

**Last full sweep:** 2026-09-04
**Files in `references/` at last sweep:** 30 of 30 processed

Rating scale (be honest — a register where everything is a 4 or 5 is not useful):

| Rating | Meaning |
|---|---|
| 5 | Core — directly informs the trajectory-intent chain, a named to-do section, or a central stakeholder/objective; authoritative source; will likely be cited in the final paper. |
| 4 | Strong supporting — clearly relevant, solid rigor, probably cited but not central. |
| 3 | Useful background — relevant domain knowledge or methodology, but tangential to the core storyline; informs framing more than direct evidence. |
| 2 | Marginal — loosely related; may not survive to the final bibliography. |
| 1 | Weak — barely relevant, redundant with a stronger source already in the register, or low rigor. |
| 0 | Not relevant — recommend removal from `references/`. |

| File | Bib key | Rating | Summary | Last processed |
|---|---|---|---|---|
| 2026_SciTech_Lupp_et_al_REACT_Database.pdf | `lupp2026reactMbseMdo` | 3 | [lupp2026reactMbseMdo.md](../../references/summaries/lupp2026reactMbseMdo.md) | 2026-08-29 |
| A review of aircraft turnaround operations and simulations.pdf | `schultz2017turnaround` | 5 | [schultz2017turnaround.md](../../references/summaries/schultz2017turnaround.md) | 2026-08-29 |
| Airline Disruption Management A Literature Review.pdf | `hassanDisruptionReview` | 5 | [hassanDisruptionReview.md](../../references/summaries/hassanDisruptionReview.md) | 2026-08-29 |
| Airline Schedule Planning A Review and Future Directions.pdf | `eltoukhy2017airline` | 5 | [eltoukhy2017airline.md](../../references/summaries/eltoukhy2017airline.md) | 2026-08-29 |
| Airline Schedule Planning Integrated Models and Algorithms for Schedule Design and Fleet Assignment.pdf | `lohatepanont2004airline` | 4 | [lohatepanont2004airline.md](../../references/summaries/lohatepanont2004airline.md) | 2026-08-29 |
| Airline_scheduling_optimizatio.pdf | `xu2024airlineSchedOpt` (renamed from `deng2023airline` — see flag in summary) | 4 | [xu2024airlineSchedOpt.md](../../references/summaries/xu2024airlineSchedOpt.md) | 2026-08-29 |
| Design Ontology Supporting Model-based Systems-engineering formalisms.pdf | `luDesignOntologyMBSE2020` | 2 | [luDesignOntologyMBSE2020.md](../../references/summaries/luDesignOntologyMBSE2020.md) | 2026-08-29 |
| FAA_data_standards_initiative_systems_engineering_base_for_air_traffic_modernization.pdf | `mitreFAADataStandards` | 4 | [mitreFAADataStandards.md](../../references/summaries/mitreFAADataStandards.md) | 2026-08-29 |
| FROM ONTOLOGY TO SYSTEM ARCHITECTURE - AN MBSE APPROACH TOWARD THE REALIZATION OF URBAN AIR MOBILITY.pdf | `sinharoy2024ontologyUAM` | 4 | [sinharoy2024ontologyUAM.md](../../references/summaries/sinharoy2024ontologyUAM.md) | 2026-08-29 |
| Irregular airline operations a review of the state-of-the-practice in airline operations control centers.pdf | `clarke1998irregular` | 5 | [clarke1998irregular.md](../../references/summaries/clarke1998irregular.md) | 2026-08-29 |
| MBSE Approach for designing aircraft engine inlet - cinar.pdf | `jagtap2025mbseEngineInlet` (duplicate — see flag) | 2 | [jagtap2025mbseEngineInlet-duplicate-cinar.md](../../references/summaries/jagtap2025mbseEngineInlet-duplicate-cinar.md) | 2026-08-29 |
| Model-Based Systems Engineering Approach for a Systematic Design of Aircraft Engine Inlet.pdf | `jagtap2025mbseEngineInlet` | 2 | [jagtap2025mbseEngineInlet.md](../../references/summaries/jagtap2025mbseEngineInlet.md) | 2026-08-29 |
| NAS-Infrastructure-Roadmaps-v20.pdf | `faaNasInfrastructureRoadmaps2025` | 5 | [faaNasInfrastructureRoadmaps2025.md](../../references/summaries/faaNasInfrastructureRoadmaps2025.md) | 2026-08-29 |
| NASA's Use of MBSE and SysML Modeling to Architect the Future of Human Exploration.pdf | `hill2024nasaMbseHumanExploration` | 3 | [hill2024nasaMbseHumanExploration.md](../../references/summaries/hill2024nasaMbseHumanExploration.md) | 2026-08-29 |
| Systems Engineering - 2011 - Bartolomei - Engineering Systems Multiple‐Domain Matrix ... .pdf | `bartolomei2012esmdm` | 4 | [bartolomei2012esmdm.md](../../references/summaries/bartolomei2012esmdm.md) | 2026-08-29 |
| Workload Balancing for Flight Dispatchers.pdf | `dispatcherWorkload2025` | 5 | [dispatcherWorkload2025.md](../../references/summaries/dispatcherWorkload2025.md) | 2026-08-29 |
| an-approach-for-system-analysis-with-model-based-systems-engineering-and-graph-data-engineering.pdf | `schummer2022mbseGraphAnalysis` | 2 | [schummer2022mbseGraphAnalysis.md](../../references/summaries/schummer2022mbseGraphAnalysis.md) | 2026-08-29 |
| de Neufville_Engineering Systems.pdf | `bartolomei2012esmdm` (duplicate/earlier draft — see flag) | 1 | [de-neufville-conference-draft-of-bartolomei2012esmdm.md](../../references/summaries/de-neufville-conference-draft-of-bartolomei2012esmdm.md) | 2026-08-29 |
| delaurentis-2012-understanding-transportation-as-a-system-of-systems-design-problem.pdf | `delaurentis2005sosTransportation` (year corrected — see flag) | 5 | [delaurentis2005sosTransportation.md](../../references/summaries/delaurentis2005sosTransportation.md) | 2026-08-29 |
| eurocontrol-specification-for-acdm.pdf | `eurocontrolACDMSpec` | 5 | [eurocontrolACDMSpec.md](../../references/summaries/eurocontrolACDMSpec.md) | 2026-08-29 |
| A Predictive Services Architecture for Efficient Airspace Operations.pdf | `romanideoliveira2026predictiveservices` | 4 | [4 - romanideoliveira2026predictiveservices.md](../../references/summaries/4%20-%20romanideoliveira2026predictiveservices.md) | 2026-09-04 |
| AI- and Ontology-Based Enhancements to FMEA for Advanced Systems Engineering - Current Developments and Future Directions.pdf | `younus2026fmeaOntology` | 3 | [3 - younus2026fmeaOntology.md](../../references/summaries/3%20-%20younus2026fmeaOntology.md) | 2026-09-04 |
| Harnessing Digital Twin Technology for Enhanced Aircraft Turnaround Efficiency.pdf | `lu2025digitalTwinTurnaround` | 2 | [2 - lu2025digitalTwinTurnaround.md](../../references/summaries/2%20-%20lu2025digitalTwinTurnaround.md) | 2026-09-04 |
| Knowledge-Based Aerospace Engineering A Systematic Literature Review.pdf | `wittenborg2025kbeAerospace` | 2 | [2 - wittenborg2025kbeAerospace.md](../../references/summaries/2%20-%20wittenborg2025kbeAerospace.md) | 2026-09-04 |
| Personal knowledge management the foundation of organisational knowledge management.pdf | `jain2011pkm` | 1 | [1 - jain2011pkm.md](../../references/summaries/1%20-%20jain2011pkm.md) | 2026-09-04 |
| Review of Optimization Problems, Models and Methods for Airline Disruption Management from 2010 to 2024,.pdf | `hu2024disruptionOptReview` | 3 | [3 - hu2024disruptionOptReview.md](../../references/summaries/3%20-%20hu2024disruptionOptReview.md) | 2026-09-04 |
| System-of-systems safety for low-altitude aviation transportation.pdf | `yao2026loAltitudeSoSSafety` | 4 | [4 - yao2026loAltitudeSoSSafety.md](../../references/summaries/4%20-%20yao2026loAltitudeSoSSafety.md) | 2026-09-04 |
| The Aircraft Recovery Problem A Systematic Literature Review.pdf | `santana2023arpReview` | 4 | [4 - santana2023arpReview.md](../../references/summaries/4%20-%20santana2023arpReview.md) | 2026-09-04 |
| Urban Air Mobility as a System of Systems An LLM-Enhanced Holonic Approach.pdf | `sadik2025holonicUAM` | 3 | [3 - sadik2025holonicUAM.md](../../references/summaries/3%20-%20sadik2025holonicUAM.md) | 2026-09-04 |
| Proactive Aircraft Turnaround Buffer Optimization Integrating Machine Learning and Scenario Analysis.pdf | `kontodimou2026turnaroundBuffer` | 3 | [3 - kontodimou2026turnaroundBuffer.md](../../references/summaries/3%20-%20kontodimou2026turnaroundBuffer.md) | 2026-09-04 |

**Distribution:** eight 5s, eight 4s, six 3s, six 2s, two 1s, zero 0s — 30 files, but only
28 distinct works (the two exact-duplicate pairs from the 2026-08-29 sweep, see Flags
below; no duplicates found among the ten files added 2026-09-04, though several overlap
topically with existing sources — see the new Flags entry below).

### Flags raised by this sweep

- **Two citation-integrity errors found and corrected in `references.bib`:**
  - `deng2023airline` → renamed `xu2024airlineSchedOpt`: the old entry's author list
    ("Deng, Qi and Santos, Bruno F.") did not match the actual PDF (authors are Xu,
    Wandelt & Sun). Old key preserved in the new entry's `note` for traceability.
  - `schultz2017turnaround`: author corrected from "Schultz, Michael" to the PDF's actual
    byline, "Schmidt, Michael." Bib key kept as-is for continuity.
  - `Project_To-Do List.md`'s section headers for these two sources still say
    "Schultz" and imply "Deng & Santos" — not edited automatically; flagged for the user.
- **Two exact-duplicate PDF pairs** found in `references/`:
  - `MBSE Approach for designing aircraft engine inlet - cinar.pdf` ==
    `Model-Based Systems Engineering Approach for a Systematic Design of Aircraft Engine Inlet.pdf`
    (identical paper, same DOI 10.2514/6.2025-1410).
  - `de Neufville_Engineering Systems.pdf` is a 2009 conference-manuscript draft of the
    same work published as `Systems Engineering - 2011 - Bartolomei - ...pdf` (2012 journal
    version, DOI 10.1002/sys.20193).
  - Recommend removing one file from each pair; not done automatically.
- **Two filename/version mismatches** worth double-checking against the source:
  - `NAS-Infrastructure-Roadmaps-v20.pdf`'s title page reads "v19.1," not v20.
  - `delaurentis-2012-...pdf`'s filename says 2012; the paper itself is AIAA 2005-123
    (year 2005). Bib entry uses the verified 2005 date.
- Also fixed a **stray trailing `}`** at the end of the previous `references.bib` (a
  syntax error left over from an earlier edit).

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
  — flagged in `references.bib` and `assistant/memory/open-questions.md` for
  confirmation.
- **`jain2011pkm`** (Personal Knowledge Management) rated 1/5 — off-topic for this
  register (library/information-science survey, zero aerospace/MBSE content). Flagged for
  a user decision on whether to keep it in `references/` at all, per its summary file.
- **Filename correction:** the file on disk named "roactive Aircraft Turnaround Buffer
  Optimization..." (truncated) was renamed to "Proactive Aircraft Turnaround Buffer
  Optimization Integrating Machine Learning and Scenario Analysis.pdf" to match the
  verified title (`kontodimou2026turnaroundBuffer`).
- **DOI not confirmed on the pages read** for `sadik2025holonicUAM` (IEEE Xplore document
  ID found, not the DOI string) and `wittenborg2025kbeAerospace` (arXiv preprint, no DOI
  exists yet) — verify before final citation.

## Annotation status (by `Project_To-Do List.md` section)

Only the identifying columns are filled in below — the deep-annotation analysis columns
(NAS lifecycle phase, systems, stakeholders, architectural evidence, optimization
evidence, SysML artifacts) are genuinely unstarted, matching every unchecked box in
§1–§4 of the to-do list as of 2026-08-29. Fill a row in as its "Read and annotate"
checklist gets worked, using
[assistant/workflows/annotate-source.md](../workflows/annotate-source.md) and
[assistant/templates/source-annotation-template.md](../templates/source-annotation-template.md).

Status values: `not started` · `in progress` · `annotated` · `mapped to architecture`.

### Airline planning & operations (to-do §2)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| Airline Schedule Planning A Review and Future Directions.pdf | `eltoukhy2017airline` | journal review | not started |
| Airline_scheduling_optimizatio.pdf | `xu2024airlineSchedOpt` | journal review | not started |
| Airline Schedule Planning Integrated Models and Algorithms for Schedule Design and Fleet Assignment.pdf | `lohatepanont2004airline` | journal article | not started |
| — (no PDF yet) | `yan2008integrated` (Integrated Airline Scheduling) | journal article | not started — bib entry flagged "verify authors/volume/DOI" |
| — (no PDF yet) | `timetableFleetPassengerChoice` (timetable/fleet assignment + passenger choice) | journal article | not started |
| — (no PDF yet) | `crewSchedulingReview` (Airline Crew Scheduling: Models, Algorithms, Data Sets) | journal review | not started |
| — (no PDF yet) | `aircraftMaintenanceRoutingReview` | journal review | not started |
| — (no PDF yet) | `garg2024integrated` (Integrated Airline Planning) | journal article | not started |

### Turnaround & day-of-operations (to-do §3)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| A review of aircraft turnaround operations and simulations.pdf | `schultz2017turnaround` | journal review | not started |
| — (no PDF yet) | `turnaroundCDM` (Managing Turnaround Performance through CDM) | journal article | not started |
| eurocontrol-specification-for-acdm.pdf | `eurocontrolACDMSpec` | EUROCONTROL spec | not started |
| — (no PDF yet) | `eurocontrolACDMManual` (A-CDM Implementation Manual) | EUROCONTROL manual | not started |
| — (no PDF yet) | `loadControl2026` (Automated Load Control and W&B Validation) | journal/technical article | not started |
| Harnessing Digital Twin Technology for Enhanced Aircraft Turnaround Efficiency.pdf | `lu2025digitalTwinTurnaround` | journal article | not started |
| Proactive Aircraft Turnaround Buffer Optimization Integrating Machine Learning and Scenario Analysis.pdf | `kontodimou2026turnaroundBuffer` | journal article | not started |

### OCC, dispatch & flight execution (to-do §4)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| Airline Disruption Management A Literature Review.pdf | `hassanDisruptionReview` | journal review | not started |
| Irregular airline operations a review of the state-of-the-practice in airline operations control centers.pdf | `clarke1998irregular` | journal review | not started |
| Workload Balancing for Flight Dispatchers.pdf | `dispatcherWorkload2025` | journal article | not started |
| Review of Optimization Problems, Models and Methods for Airline Disruption Management from 2010 to 2024,.pdf | `hu2024disruptionOptReview` | journal review | not started |
| The Aircraft Recovery Problem A Systematic Literature Review.pdf | `santana2023arpReview` | journal review | not started |
| — (nominal ATC/IFR flight execution) | none yet | FAA source(s) TBD | not started — need to identify specific FAA/AIM references per to-do §4 |

### MBSE methodology & systems-architecture references (not yet tied to a to-do §; background/methods reading)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| Design Ontology Supporting Model-based Systems-engineering formalisms.pdf | `luDesignOntologyMBSE2020` | arXiv preprint | not started |
| FROM ONTOLOGY TO SYSTEM ARCHITECTURE - AN MBSE APPROACH TOWARD THE REALIZATION OF URBAN AIR MOBILITY.pdf | `sinharoy2024ontologyUAM` | conference paper (ICAS) | not started |
| MBSE Approach for designing aircraft engine inlet - cinar.pdf | `jagtap2025mbseEngineInlet` | conference paper (AIAA) | not started — confirmed exact duplicate of next row, same DOI |
| Model-Based Systems Engineering Approach for a Systematic Design of Aircraft Engine Inlet.pdf | `jagtap2025mbseEngineInlet` | conference paper (AIAA) | not started — confirmed exact duplicate of row above |
| NASA's Use of MBSE and SysML Modeling to Architect the Future of Human Exploration.pdf | `hill2024nasaMbseHumanExploration` | conference paper (INCOSE) | not started |
| an-approach-for-system-analysis-with-model-based-systems-engineering-and-graph-data-engineering.pdf | `schummer2022mbseGraphAnalysis` | journal article | not started |
| Systems Engineering - 2011 - Bartolomei - Engineering Systems Multiple-Domain Matrix.pdf | `bartolomei2012esmdm` | journal article | not started |
| de Neufville_Engineering Systems.pdf | `bartolomei2012esmdm` | conference manuscript draft | not started — confirmed earlier draft of the row above, not a distinct de Neufville-authored work |
| delaurentis-2012-understanding-transportation-as-a-system-of-systems-design-problem.pdf | `delaurentis2005sosTransportation` | conference paper (AIAA) | not started — likely directly relevant to §6 (decomposition); year corrected from filename's "2012" to verified 2005 |
| NAS-Infrastructure-Roadmaps-v20.pdf | `faaNasInfrastructureRoadmaps2025` | FAA/government roadmap document | not started |
| FAA_data_standards_initiative_systems_engineering_base_for_air_traffic_modernization.pdf | `mitreFAADataStandards` | conference paper (IEEE/MITRE) | not started |
| 2026_SciTech_Lupp_et_al_REACT_Database.pdf | `lupp2026reactMbseMdo` | conference paper (AIAA SciTech) | not started |
| A Predictive Services Architecture for Efficient Airspace Operations.pdf | `romanideoliveira2026predictiveservices` | conference paper (IEEE ICNS) | not started |
| AI- and Ontology-Based Enhancements to FMEA for Advanced Systems Engineering - Current Developments and Future Directions.pdf | `younus2026fmeaOntology` | journal review | not started |
| Knowledge-Based Aerospace Engineering A Systematic Literature Review.pdf | `wittenborg2025kbeAerospace` | arXiv preprint | not started |
| System-of-systems safety for low-altitude aviation transportation.pdf | `yao2026loAltitudeSoSSafety` | journal review | not started |
| Urban Air Mobility as a System of Systems An LLM-Enhanced Holonic Approach.pdf | `sadik2025holonicUAM` | conference paper (IEEE SOSE) | not started |

### Off-topic / process background (not tied to any to-do §; flagged for a keep-or-remove decision)

| Source (file) | Bib key | Type | Status |
|---|---|---|---|
| Personal knowledge management the foundation of organisational knowledge management.pdf | `jain2011pkm` | journal article | not started — rated 1/5, off-topic for this register (library/information science, no aerospace/MBSE content); see Flags above for the keep-or-remove decision |

## Housekeeping

- Rows with "no PDF yet" mean the bib entry exists in `references/references.bib` but no
  PDF has been added to `references/` — chase these down before annotating.
- Rows with "no bib entry yet" mean a PDF exists in `references/` with no matching
  `references.bib` entry — add one when the source is first processed, using the
  citation-key style already in use (`lastname+year+shorttitle`, e.g.
  `schultz2017turnaround`).
- `de Neufville_Engineering Systems.pdf` and the Bartolomei Multiple-Domain Matrix paper
  are the same work (draft + published version) — general engineering-systems background,
  not airline-ops literature. Relevant to the "Explore Alternative System Decompositions"
  work (to-do §6), not §2–§4.
