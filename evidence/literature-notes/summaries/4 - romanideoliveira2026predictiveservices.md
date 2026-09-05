# A Predictive Services Architecture for Efficient Airspace Operations

- **File:** `references/A Predictive Services Architecture for Efficient Airspace Operations.pdf`
- **Bib key:** `romanideoliveira2026predictiveservices`
- **Authors:** Romani de Oliveira, Ítalo; Ayhan, Samet; Balvedi, Glaucia; Biglin, Michael;
  Costas, Pablo; Pinto Neto, Euclides C.; Leite, Alexandre; de Azevedo, Felipe C. F.
- **Year:** 2026
- **Venue:** 2026 Integrated Communications, Navigation and Surveillance Conference (ICNS), IEEE
- **DOI:** 10.1109/ICNS69853.2026.11570268

## What it is

An IEEE conference paper from Boeing Technology Innovation and collaborators presenting a
big-data/ML predictive-services architecture for the NAS: it ingests noisy streaming SWIM
data into layered NoSQL stores (R-SWIM → P-SWIM), trains regression/ML models (Gradient
Boosting performed best) to predict airspace sector aircraft counts and airport
arrival/departure capacity, and generalizes this into a compositional
micro-service → higher-level service → meta-service architecture. Validated on real US
NAS data (1,534 CONUS sectors) and European data (Frankfurt), ~80% prediction accuracy.

## Why it's valuable — and to what

- Literature review section: none of §2-4 directly (ANSP/traffic-flow-management side,
  not airline schedule/turnaround/OCC-dispatch).
- Decomposition / architecture (§6, §10): strong fit — Fig. 8's "Compositional Services
  Architecture" (Cloud Infrastructure → Input Data Processing → Predictive Micro-Services
  → Higher-Level Predictive Services → Meta-Services) is a concrete real-world example of
  layered service composition inside the NAS, including a real distinction between
  "micro-service" (no end-user interface) and "higher-level service."
- Stakeholder / objective ontology (§7-9): weak direct fit, but a concrete illustration of
  a tactical predictive capability feeding higher-level decision tools (CTOP, dynamic
  re-sectorization) — the "local capability feeds higher-level objective" pattern.
- Optimization study (§11-13): reinforces framing optimization/prediction as an
  architectural capability a higher-level decision process consumes, not the object of
  study itself.
- Glossary / terminology: SWIM, R-SWIM/P-SWIM, TFMS/TFMData, Dynamic Density (DD), FAA
  Monitor Alert Parameter (MAP), METAR/TAF, Collaborative Trajectory Options Program
  (CTOP), micro-service/meta-service.
- Other: directly useful raw material for `knowledge/models/interface-exchange-draft.md`
  — names concrete NAS data interfaces (SWIM flight plans, aircraft positions,
  trajectories, flow-control messages; METAR/TAF; TFMData).

## Rating

**4/5** — Not central to the enterprise-objective-to-trajectory intent chain, but a
rigorous, recent (2026), industry-authored example of a real layered SoS-style predictive
architecture inside the NAS with concrete interfaces, directly reusable for §6/§10 and the
interface-exchange draft, and well-aligned with the capstone's "optimization as an
architectural capability" framing. Selected for deep annotation (§6/§10 architecture
angle) in the 2026-09-04 literature-review pass.

## Flags

Complements (does not duplicate) `mitreFAADataStandards` and `faaNasInfrastructureRoadmaps2025`
— this paper is an applied ML/architecture paper built on top of the data infrastructure
those sources describe. All bib fields confirmed directly from the PDF; no unverifiable
fields.

## Processing metadata

- **Read depth:** Fully read (all ~8 content pages plus reference list skim)
- **Date processed:** 2026-09-04
