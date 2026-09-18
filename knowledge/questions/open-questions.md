# Open Questions

A parking lot for unresolved scope/boundary/definitional questions. When one gets
resolved, move the resolution into the relevant file (usually
`../../projects/nas-sos-capstone/index.md` or `../../decisions/decisions-log.md`) and
delete it from here — don't let answered questions linger.

## System boundary (to-do-list.md §1 "Define initial System of Interest")

- [x] Included/excluded scope has a working draft: `index.md` names 9 candidate domains;
  general aviation, military airspace (beyond its PESTLE/objective stakeholder role), and
  international airspace are provisionally excluded. Not yet ratified as a formal
  boundary.
- [ ] What level(s) of abstraction will the model operate at? (Enterprise policy down to
  control-surface deflection is an enormous range — the trajectory-intent chain in
  `index.md` spans it conceptually, but the model can't render every level in equal
  detail.)
- [ ] What criteria decide where a *system* boundary is drawn (vs. just listing
  components)?
- [ ] What criteria decide where a *stakeholder/actor* boundary is drawn?

## Decomposition choice (§6)

- [ ] Is the authority/responsibility/information-ownership decomposition
  ([[decisions-log]] D-002) final, or will the project retain multiple parallel
  viewpoints (organization-based, lifecycle-based, physical, information-flow,
  decision-authority) as §6 suggests?

## Literature gaps

- [ ] Nominal ATC/IFR flight-execution research (§4) hasn't identified specific FAA
  source documents yet (AIM? 7110.65? advisory circulars?).

## Reference-register housekeeping

- [ ] `yao2026loAltitudeSoSSafety` cites a DeLaurentis 2005 SoS-taxonomy paper ("A
  Taxonomy-Based Perspective for Systems-of-Systems Design Methods," IEEE SMC 2005) that
  may differ from the PDF registered as `delaurentis2005sosTransportation`
  ("Understanding Transportation as a System-of-Systems Design Problem," AIAA 2005-123) —
  confirm which paper `yao2026` actually cites. See [[source-register]]. - DONE Yao cites the 2005 DeLaurentis paper as ref 128:

```There are various definitions and characteristics in the research of SoS. For example, Maier summarizes SoS characteristics into five properties (“Maier’s criteria”) [126]: (i) operational independence, (ii) managerial independence, (iii) geographic distribution, (iv) emergent behavior, and (v) evolutionary development. Moreover, Boardman and Sauser distinguish SoS from conventional systems using five identifying characteristics—Autonomy, Belonging, Connectivity, Diversity, and Emergence [127], while DeLaurentis propose a taxonomy along three orthogonal dimensions, namely Connectivity, Control/Autonomy, and System Type, to characterize and compare different SoS forms [128]. In this review, we describe LA SoS according to standards of ISO/IEC/IEEE 42010:2020 [129]. ISO/IEC/IEEE 42010:2020 states that an entity’s architecture includes “its constituent elements, interactions among elements, interactions with the environment, as well as its behavior/structure and the principles governing its design, use, operation and evolution.”```

- [ ] `younus2026fmeaOntology` cites the same Lu et al. design-ontology work as
  `luDesignOntologyMBSE2020` but gives its venue/year as *IEEE Systems Journal*, 2022, vs.
  the registered arXiv 2020 preprint — reconcile which is authoritative.
  Looks like the paper was reprinted in a different publiction (IEEE as opposed to airXiv's capture)
- [ ] `faaFixmUsExtension2024`'s exact release year for FIXM US Extension v4.4.0 isn't
  stated in-document — verify against fixm.aero before citing precisely. See
  [[source-register]]. It was acquired from a download from the website https://www.fixm.aero/downloads.html, which has 4.4. published Sept 2 2025. 

## Optimization study scope (§11)

- [ ] §12 as written (full experiment matrix, Pareto fronts, sensitivity analysis,
  tipping-point identification) reads as a full optimization study — in tension with the
  "not an optimization paper" guardrail (README.md, CLAUDE.md) and the report's 15–40
  page cap. Recommend scoping §11–§14 to one representative scenario, a single weight
  sweep, and one Pareto-style comparison, with broader sweep/sensitivity work kept as
  future work. Not yet decided; revisit once §7–§8 progress.
