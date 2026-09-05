# Airline Scheduling Optimization: Literature Review and a Discussion of Modelling Methodologies

- **File:** `references/Airline_scheduling_optimizatio.pdf`
- **Bib key:** `xu2024airlineSchedOpt` (renamed — see flag below)
- **Authors:** Xu, Yifan; Wandelt, Sebastian; Sun, Xiaoqian
- **Year:** 2024 (accepted 2023, journal issue dated 2024)
- **Venue:** Intelligent Transportation Infrastructure, Vol. 2, p. liad026
- **DOI:** 10.1093/itinfr/liad026

## What it is

An open-access review dissecting thirteen representative mathematical models (M1-M13)
across the schedule-design, fleet-assignment, aircraft-routing, and crew-scheduling
subproblems, with a specific focus on integrated and robust-scheduling formulations and
their potential for further integration.

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §2 — complements
  `eltoukhy2017airline`'s broader survey with concrete mathematical model formulations
  (Table 1/2 in the paper give sets, parameters, and model characteristics directly).
- Decomposition / architecture (§6, §10): the model taxonomy (by problem × network ×
  horizon × characteristic) is a useful pattern for how to tag decision-support capabilities
  in the architecture.
- Stakeholder / objective ontology (§7-§9): robust-scheduling models (M12/M13) explicitly
  model uncertainty/disruption risk — relevant to §9's local-vs-system conflict analysis.
- Optimization study (§11-§13): the most directly reusable of the airline-planning reviews
  for actually building the §11 multi-objective formulation, since it gives explicit sets/
  parameters/objectives rather than prose description alone.

## Rating

**4/5** — strong supporting evidence, especially for the optimization-study formulation
work in §11-§13; not rated 5 only because it overlaps substantially with
`eltoukhy2017airline` and `lohatepanont2004airline` rather than opening new ground.

## Flags

**Citation-integrity issue, corrected in `references.bib`:** this source was previously
cataloged under the bib key `deng2023airline` with the author list "Deng, Qi and Santos,
Bruno F." — that author list, and the DOI prefix `10.1093/iti/...`, do **not** match this
PDF. The actual authors (per the PDF byline) are Xu, Wandelt & Sun, and the correct DOI
prefix is `itinfr`. The bib key has been renamed to `xu2024airlineSchedOpt` to match the
real first author; the old key is documented in the new entry's `note` field for
traceability. **Recommend checking whether a separate, correctly-attributed
Deng & Santos paper was ever intended and simply never downloaded** — this looks like a
mismatch between an intended citation and the PDF that actually ended up in `references/`,
not a fabricated paper (the PDF itself is real and verifiable).

## Processing metadata

- **Read depth:** skimmed (pages 1-2, abstract + Table 1/2)
- **Date processed:** 2026-08-29
