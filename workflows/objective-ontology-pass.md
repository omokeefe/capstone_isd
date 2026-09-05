# Workflow: Objective / Cost / Value Ontology Pass

Covers `to-do-list.md` §7 (stakeholder/responsibility analysis) and §8
(objective/cost/value ontology) and §9 (myopic-optimization conflict analysis).

## Steps

1. Bootstrap per `workflows/new-session-bootstrap.md`. Read
   `knowledge/models/stakeholder-register.md` in full — it already seeds the PESTLE
   inventory and enterprise-objective hierarchy from `prework/gpt_convos.md`.
2. **§7 pass** — for the stakeholder(s) in scope this session, fill in the "still open"
   columns in `stakeholder-register.md`: needs, goals, responsibilities, authorities,
   resources, constraints, information needs, measures of value. Pull evidence from
   annotated sources in `evidence/source-register.md` where available rather than
   guessing.
3. Build/extend the RACCI matrix for the operational decision(s) in scope. Store it
   wherever the architecture work lives (likely as a table feeding into
   `to-do-list.md` §10's "responsibility swimlanes"); reference it from
   `stakeholder-register.md` rather than duplicating it there.
4. **§8 pass** — for each of the seven §8 stakeholder categories (Airline, Passenger,
   ATC/ANSP, Airport, Flight Crew, Environmental/Societal, Military), classify each
   candidate objective as: hard constraint, optimization objective, cost/penalty, MOE,
   or MOP. Cross-check each against the PESTLE reconciliation note already in
   `stakeholder-register.md`.
5. **§9 pass** — for each candidate local-vs-system conflict (the to-do list has eight
   starter examples, e.g. "airline fuel burn vs passenger delay"), document: decision
   maker, decision variable, local objective, local constraints, affected stakeholders,
   externalized costs, SoS consequence, and information needed to recognize the
   consequence. These conflicts are the raw material for the §11 optimization study — a
   good conflict write-up should be specific enough to become a scenario, and a strong
   candidate for a `knowledge/claims/` note (see `knowledge/claims/README.md` for how
   to add one — the user should state the claim in their own words first).
6. Update `decisions/decisions-log.md` if this pass changes which stakeholders or
   objectives are treated as in-scope vs. background.
7. Check off the corresponding boxes in `projects/nas-sos-capstone/to-do-list.md` §7-§9.
8. Wrap up per `workflows/session-wrap-up.md`.

## Notes

- Objectives that only make sense in isolation (i.e., no other stakeholder's objective
  ever trades off against them) are lower priority than ones with a documented conflict —
  the capstone's demonstration (§14) needs real tradeoffs, not just a long list.
