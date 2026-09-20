---
name: update-architecture
description: Make a change to the SysML v2 model, domain decomposition, or the legacy XML architecture draft, with traceability back to stakeholder needs or literature evidence. Use for to-do-list.md §6-§10 architecture work.
---

Follow `workflows/update-architecture.md` exactly. Treat the `.sysml` text under
`cameo_models/` (authored in Syside/VS Code) as the source of truth (D-006); Cameo is
optional and downstream, and `prework/nas_system_of_systems_architecture.xml` is a
pre-modeling draft that is not kept in sync. Ensure every new element traces to a stakeholder need
(`knowledge/models/stakeholder-register.md`), a source's evidence
(`evidence/source-register.md`), or the trajectory-intent chain
(`projects/nas-sos-capstone/index.md`). Log real structural decisions in
`decisions/decisions-log.md`, check off the relevant `projects/nas-sos-capstone/to-do-list.md`
§10 boxes, and wrap up the session.
