# Annotation: A Predictive Services Architecture for Efficient Airspace Operations

- **File:** `references/A Predictive Services Architecture for Efficient Airspace Operations.pdf`
- **Bib key:** `romanideoliveira2026predictiveservices`
- **Type:** conference paper (IEEE ICNS 2026)
- **To-do section:** `Project_To-Do List.md` §6 (Explore Alternative System Decompositions)
  / §10 (Build the SysML Architecture) — no §2-4 fit (ANSP/traffic-flow-management side,
  not airline schedule/turnaround/OCC-dispatch)

## Extraction

- **Actors / stakeholders:** ANSP/FAA traffic-flow management (ATCSCC and equivalent),
  the industry technology provider (Boeing Technology Innovation + MWF Services, as the
  paper's authors/builders of the predictive service), and — as downstream consumers of
  the predictions — traffic managers issuing CTOP and dynamic re-sectorization decisions.
  Airlines/flights are affected indirectly (their trajectories are constrained by the
  flow-management decisions the predictions inform) but are not actors in the paper
  itself. Maps to existing PESTLE rows "Federal Aviation Administration" and
  "Air traffic controllers" in `stakeholder-register.md` — no new stakeholder type
  surfaced.
- **Systems / organizations:** SWIM (System Wide Information Management) as the shared
  data backbone; a two-tier internal data store (R-SWIM raw → P-SWIM processed); ML
  training/serving infrastructure; TFMS/TFMData as an upstream flow-management data
  system; European counterpart data (Frankfurt/EUROCONTROL-adjacent) used for
  cross-validation.
- **Objectives:** Accurate, timely prediction of airspace sector aircraft counts and
  airport arrival/departure capacity, to support proactive (rather than reactive) traffic
  flow management and reduce congestion/delay. No explicit cost/dollar objective — the
  paper's own measure of success is prediction accuracy (~80%), not an operational or
  economic outcome metric.
- **Costs / penalties:** Not modeled directly. Implicit: congestion, delay, and
  controller workload are the costs a good prediction is meant to help avoid downstream,
  but the paper does not quantify them.
- **Decisions:** The paper does not make operational decisions itself — it is a
  prediction/forecasting service. The decisions it feeds are made downstream by traffic
  management: whether to issue a Collaborative Trajectory Options Program (CTOP), whether
  to dynamically re-sector airspace, and how to allocate arrival/departure capacity at an
  airport.
- **Decision authority:** ATCSCC (US) / equivalent Network Manager function (Europe) holds
  authority over the flow-management decisions the predictions inform; the predictive
  service itself has no decision authority, only an advisory/informational role.
- **Activities / processes:** Streaming ingestion of noisy SWIM data → layered storage
  (R-SWIM → P-SWIM) → feature engineering → ML model training (several regressors
  compared; Gradient Boosting performed best) → model serving as a micro-service →
  composition of micro-services into higher-level services → composition of higher-level
  services into meta-services.
- **Resources:** SWIM data feed (flight plans, aircraft positions, trajectories,
  flow-control messages), METAR/TAF weather feeds, TFMData, historical NAS operational
  data (1,534 CONUS sectors), cloud compute infrastructure.
- **Information inputs:** SWIM streams (flight plans, positions, trajectories,
  flow-control messages), METAR/TAF weather observations/forecasts, TFMData.
- **Information outputs:** Predicted sector aircraft counts; predicted airport
  arrival/departure capacity — both consumed by downstream flow-management decision
  processes (CTOP, dynamic re-sectorization).
- **Constraints:** SWIM data is noisy at the raw-ingestion level, which is why the
  architecture needs a two-tier (R-SWIM/P-SWIM) data-quality layer before modeling;
  prediction accuracy tops out around 80% in the reported validation.
- **Interfaces / handoffs:** SWIM publish/subscribe interface as the system's primary
  external data interface; internal micro-service → higher-level-service → meta-service
  composition as an architectural interface pattern; a final handoff from the predictive
  service's output to human traffic managers / flow-management automation, which is
  outside this paper's scope.
- **Timescales of decisions:** Tactical/short-horizon — sector-count and capacity
  predictions are consumed by near-term (hours-scale) traffic-flow-management decisions,
  not strategic/schedule-planning-horizon decisions.
- **Upstream dependencies:** Raw NAS surveillance and flight-plan data via SWIM; weather
  observation/forecast feeds; historical operational data for model training.
- **Downstream consequences:** Predictions inform CTOP issuance and dynamic
  re-sectorization, which constrain airline routing/scheduling and ultimately the
  trajectories individual aircraft fly — a concrete instance of the capstone's
  enterprise-objective-to-aircraft-trajectory intent chain, but entered partway down the
  chain (at the tactical flow-management layer, not the enterprise-objective layer).
- **Optimization variables:** n/a — this is a predictive/forecasting service, not an
  optimizer. The "optimization" (e.g., CTOP slot allocation) happens in the downstream
  decision processes this service feeds, which are outside the paper's scope.
- **Objective functions / measures of effectiveness:** Prediction accuracy (~80%
  reported); implied regression-error metrics (not fully specified in the portions read).
- **Evidence of local-vs-system-level conflicts:** None directly addressed — the paper
  does not discuss competing stakeholder objectives or tradeoffs. Notably absent: no
  treatment of how a false-positive/false-negative prediction error would asymmetrically
  affect different stakeholders (e.g., an airline vs. an ANSP), which is itself worth
  flagging as a limitation relative to the capstone's stakeholder-conflict focus.

## Mapping to architecture

- **Candidate SysML elements:** A "Predictive Capacity Service" block sitting inside a
  Decision Support (or Airspace Management) domain, with a port/interface to SWIM as an
  information-exchange element; the paper's own compositional layering
  (micro-service → higher-level service → meta-service) is a ready-made template for a
  block hierarchy or a set of nested Internal Block Diagrams showing how a narrow
  predictive capability composes into a broader decision-support capability. Useful as a
  concrete, citable example when justifying the granularity of Decision Support domain
  elements in the D-002 decomposition.
- **New glossary terms surfaced:** SWIM (already in glossary), R-SWIM / P-SWIM, TFMS /
  TFMData, Dynamic Density (DD), FAA Monitor Alert Parameter (MAP), Collaborative
  Trajectory Options Program (CTOP), micro-service / higher-level service / meta-service
  (as a compositional pattern). Not yet added to `glossary.md` — flagged as a follow-up
  since none of these are in active use elsewhere in the project yet; add if/when the
  interface-exchange or Decision Support domain work references them directly.
- **New stakeholders/objectives not yet in `stakeholder-register.md`:** None new — this
  source reinforces the existing "Federal Aviation Administration" and "Air traffic
  controllers" PESTLE rows rather than introducing a new stakeholder class.

## Confidence / limitations

High confidence in the extraction — the paper was fully read (all ~8 content pages) by
the triage agent, all bibliographic fields were confirmed directly from the PDF, and the
architecture/data-flow description is explicit and diagrammed (Fig. 8) in the source. The
main limitation for capstone use: this is an industry-authored conference paper reporting
a real deployed/prototyped capability, not a peer-reviewed academic study with
independent validation, and it is silent on stakeholder tradeoffs/conflicts — useful for
architecture/interface content, not for the stakeholder-objective-conflict narrative.
