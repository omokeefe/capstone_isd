---
name: sysml-instance-modeling
description: Add instance-level SysML v2 content — a specific flight, its route (airports, enroute segment, SIDs/STARs/approaches), or any other concrete occurrence of a structural type already defined in cameo_models/nas_sysml_package_definitions.sysml. Use for scenario/instance modeling, distinct from adding new domain/system definitions (that's update-architecture).
---

Follow `workflows/sysml-instance-modeling.md` exactly. Definitions (domains, system
types) live in `cameo_models/nas_sysml_package_definitions.sysml` and are `workflows/update-architecture.md`'s
job; this skill only adds concrete usages under `cameo_models/scenarios/`. Save early and
often and fix against the IDE's SysML language-server diagnostics before considering any
change done — don't hand-verify complex textual SysML v2 from memory alone. Flag
pattern-demo scenarios as illustrative (not a decided ConOps scenario) in a header `doc`
comment, note real gaps in `knowledge/questions/open-questions.md`, and sign off per
`workflows/session-signoff.md`.
