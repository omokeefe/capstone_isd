# SysML v2 / Syside Modelling Methods

Working reference for authoring the NAS SoS model in Syside Modeler (VS Code). It covers the SysML v2 textual patterns behind each classic SE diagram and how to get Syside to render them. Examples use NAS names from [nas_sysml_package_definitions.sysml](../../projects/nas-sos-capstone/cameo_models/nas_sysml_package_definitions.sysml) so they can be pasted in and adapted. The `.sysml` text is the source of truth (D-006); diagrams are *views* of it, never hand-drawn artifacts.

Sources: [Syside docs](https://docs.sensmetry.com/) — [Diagram views](https://docs.sensmetry.com/modeler/diagram-views/), [Diagram coverage](https://docs.sensmetry.com/about/sysml-v2-diagram-coverage/), [Modeler essentials](https://docs.sensmetry.com/modeler/essentials/), [Matrix views](https://docs.sensmetry.com/modeler/grid-views/matrix-views/), [CLI commands](https://docs.sensmetry.com/modeler/cli/commands/). The Syside pages cover views, filters and tooling; the language patterns (ports, states, actions, requirements) are standard SysML v2 (OMG SysML 2.0) and are not documented by Sensmetry. Treat those as "check with `syside check`," not as vendor-verified.

---

## 1. Core language in one screen

| Concept | Syntax | Notes |
| --- | --- | --- |
| Definition (the type, "block") | `part def Aircraft { … }` | Reusable. What a SysML v1 BDD shows. |
| Usage (an instance-role inside something) | `part aircraft : Aircraft;` | What an IBD shows. Always prefer usages inside a def. |
| Typed by | `:` | `part atc : AirTrafficControlSystem;` |
| Specializes (generalization) | `:>` | `part def TRACON :> AtcFacility;` |
| Redefines | `:>>` | `part :>> atc;` re-declares an inherited feature (used for the `#ContextVisible` tag trick). |
| Reference (not owned) | `ref part` | The AOC *refers to* an aircraft; it doesn't *contain* it. |
| Multiplicity | `[0..*]`, `[1]`, `[2..4]` | `part aircraft : Aircraft[0..*];` |
| Attribute (value) | `attribute altitude : Real;` | Values, not things. Types go in `attribute def`. |
| Item (thing that flows) | `item def Clearance;` | Clearances, flight plans, fuel, passengers. |
| Port (interaction point) | `port def VoicePort { … }` / `port voice : VoicePort;` | `~VoicePort` is the conjugate (in↔out flipped). |
| Connection | `connection c connect a to b;` | Named connections render as labelled edges. |
| Metadata tag | `metadata def ContextVisible;` then `#ContextVisible part …` | Used for view filtering. |
| Documentation | `doc /* … */` | Put evidence tags ([A]/[B]/[C]) here. |

Qualified names use `::` (`NationalAirspaceSystem::AirspaceManagement::TRACON`). Import with `public import Pkg::*;` (members) or `Pkg::**` (recursive).

## 2. Views: how Syside turns text into diagrams

A diagram is a `view` that **exposes** part of the model, optionally **filters** it, and is **typed** by a view kind that chooses the renderer.

```sysml
package MyViews {
    private import StandardViewDefinitions::*;
    private import Views::asTreeDiagram;

    view 'NAS Domain Tree' : GeneralView {
        expose NationalAirspaceSystem::NationalAirspaceSystem::**;
        filter @ SysML::PartUsage;
        attribute depth = 2;
        render asTreeDiagram;
    }
}
```

| View kind | Classic equivalent | Use it for |
| --- | --- | --- |
| `GeneralView` (default) | BDD, package diagram, req. diagram | Defs, specialization, containment, requirements |
| `InterconnectionView` | IBD, context diagram | Part usages wired through ports/connections/flows |
| `ActionFlowView` | Activity diagram | Actions, control nodes, object flows |
| `StateTransitionView` | State machine | States, transitions, entry/do/exit |
| `SequenceView` | Sequence diagram | Lifelines, messages, ordering |
| `GridView` (via SysideViews library) | Tables / traceability matrices | Requirement ↔ component, function ↔ component |

An untyped view renders as General. `render asInterconnectionDiagram;` is an alternative to typing it `: InterconnectionView`.

**Expose patterns**

| Syntax | Exposes |
| --- | --- |
| `expose X;` | X itself |
| `expose X::*;` | X's direct children |
| `expose X::**;` | X and all descendants |
| `expose X::*::**;` | All descendants, not X |
| `expose X::**[@MyTag];` | Descendants carrying metadata `MyTag` (inline filter). Chooses where the diagram starts only: each exposed part is still drawn with all of its contents. To hide untagged sub-parts, use `expose X::*::**;` plus `filter @MyTag;` ([sysml-diagram-rendering.md](sysml-diagram-rendering.md) §2) |
| `expose X::*[hastype SysML::PartUsage];` | Children that are exactly part usages |

**Filter operators:** `@` = at least one classification matches, includes subtypes (use for metadata tags); `istype` = all match, includes subtypes; `hastype` = exact type only. Combine with `and` / `not`, e.g. `filter (as SysML::PartDefinition) hastype SysML::PartDefinition and not (as SysML::Type).isAbstract;`

**Attributes:** `depth` (`-1` = all, `0` = elements only with *no* edges, `1` = elements + relationships between them); `render asTreeDiagram` (omit for nested); CLI-only: `fileType` (svg/png/jpeg), `fileName`, `exposeMode` (`subtree`/`promoted`/`flat`), `maxCompartmentEntries`, `showInheritedRows`.

**Gotchas (from the Syside docs, all have bitten or will bite this project):**

- **The view name is the diagram title**, rendered verbatim. Name views for the report: `view 'NAS Context Diagram'`, not `view v1`.
- **An edge disappears if either endpoint is missing** or demoted to a compartment row by `depth`. If a connection won't draw, check both ends are exposed.
- **Interconnection views need usages, not defs.** A `part def` isn't a feature. Expose a part-usage subtree (hence `NASContextDiagram` instantiates `part airspaceMgmt : AirspaceManagementDomain`).
- **`expose` is not inherited** (filters are). Each view must declare its own exposes.
- **Depth demotes rather than hides**: children past the limit become compartment rows.
- **Save before visualizing**: the renderer reads the saved file.
- **Keep Mode: Folder** (status bar). All `.sysml` in `cameo_models/` resolve as one model; Standalone shows cross-file refs as `<placeholder>`.

**Rendering:** setup, CLI commands, expose modes and troubleshooting are in [sysml-diagram-rendering.md](sysml-diagram-rendering.md). In short: `Ctrl+Alt+V` on a view (or right-click → *Visualize view*) renders that view across files. `Ctrl+Alt+E` renders one element's subtree. `Ctrl+Shift+V` renders the whole current file (rarely useful at our size). Layout buttons: Hierarchical for trees, Orthogonal for IBDs/context. *Save As Image* gives a quick PNG/SVG. For report figures, use the CLI so they're reproducible:

```bash
syside check "projects/nas-sos-capstone/cameo_models/**/*.sysml"
syside viz view projects/nas-sos-capstone/cameo_models/ -n "MyViews::NASMyViews::systemContext" -f svg -o projects/nas-sos-capstone/report/figures
syside table export projects/nas-sos-capstone/cameo_models/ -n "MyViews::reqTrace" -o evidence/
```

---

## 3. Context diagram

**Purpose:** show the SoI boundary and what crosses it. It shows **external actors ↔ SoI** plus the **exchanges** (items/information), and nothing internal. Per D-007 the SoI is `NationalAirspaceSystem` and the actors live in `Environment`.

**Pattern:** a context `part def` instantiates the SoI and each actor as usages, connects them through ports, and tags what should render. The view draws only tagged elements, at every level (tested pattern and pitfalls: [sysml-diagram-rendering.md](sysml-diagram-rendering.md) §2). (This is what [nas_context_diagram.sysml](../../projects/nas-sos-capstone/cameo_models/nas_context_diagram.sysml) does; the example below adds ports and typed flows, which the current file doesn't have yet.)

```sysml
package ContextExample {
    private import NationalAirspaceSystem::*;

    metadata def ContextVisible;

    item def Regulation;           // Governance -> NAS
    item def WeatherObservation;   // Environment -> NAS
    item def TravelDemand;         // Passengers -> NAS

    port def RulesPort    { out item rule : Regulation; }
    port def WeatherPort  { out item wx : WeatherObservation; }
    port def DemandPort   { out item demand : TravelDemand; }

    part def NASContext {
        #ContextVisible part nas : NationalAirspaceSystem {
            port rulesIn   : ~RulesPort;     // conjugate = receiving side
            port weatherIn : ~WeatherPort;
            port demandIn  : ~DemandPort;
        }
        #ContextVisible part governance : Governance::GovernanceDomain  { port rulesOut  : RulesPort; }
        #ContextVisible part weather    : Infrastructure::InfrastructureDomain { port wxOut : WeatherPort; }
        #ContextVisible part passengers : Passengers::PassengersDomain  { port demandOut : DemandPort; }

        #ContextVisible connection regulates connect governance.rulesOut to nas.rulesIn {
            doc /* [A] 14 CFR / FAA orders constrain every constituent system. */
        }
        #ContextVisible flow of WeatherObservation from weather.wxOut.wx to nas.weatherIn.wx;
        #ContextVisible flow of TravelDemand from passengers.demandOut.demand to nas.demandIn.demand;
    }
}

// in MyViews:
view 'NAS Context Diagram' : InterconnectionView {
    expose ContextExample::NASContext::*::**;       // not ::** (would include untagged NASContext)
    filter @ContextExample::ContextVisible;         // applies at every level, hides untagged sub-parts
}
```

Rules of thumb: keep the SoI a **black box** here (a second view with the SoI opened is really a top-level IBD). Every edge should name *what* crosses (a typed `flow of X` or a named connection with a `doc`). If an actor has no edge, drop its tag instead of letting it float (the open `cabinCrew` TODO).

---

## 4. BDD (structure / taxonomy): `GeneralView`

**Purpose:** definitions and how they relate. Composition (what a domain is made of), specialization (kinds of facility), and key attributes. No wiring.

```sysml
package BddExample {
    private import ScalarValues::*;

    abstract part def AtcFacility {
        attribute facilityId : String;
        attribute sectorCount : Integer;
    }
    part def TRACON :> AtcFacility;          // specialization -> hollow-triangle edge
    part def ARTCC  :> AtcFacility;
    part def ATCT   :> AtcFacility;          // tower

    part def AirspaceManagementDomain {
        part artccs  : ARTCC[20];            // composition with multiplicity
        part tracons : TRACON[1..*];
        part towers  : ATCT[1..*];
        ref part managedTraffic : AircraftSystems::Aircraft[0..*];  // referenced, not owned
    }
}

view 'Airspace Management BDD' : GeneralView {
    expose BddExample::*;                    // defs as nodes
    filter @ SysML::PartDefinition;
    attribute depth = 1;                     // 1 = draw the relationships between them
}
```

Use `render asTreeDiagram` when you want the classic decomposition tree (NAS → domains → systems). Use nested (default) when you want attributes visible in compartments. The distinction to defend: **`part` = owned lifecycle** (a TRACON is part of Airspace Mgmt), **`ref part` = association** (ATC controls aircraft it doesn't own).

---

## 5. IBD (internal wiring): `InterconnectionView`

**Purpose:** inside one def, which usages connect, through which ports, carrying what. This is where the intent chain becomes visible: AOC → ATC → Crew → Aircraft.

```sysml
package IbdExample {
    item def FlightPlan;
    item def Clearance;
    item def Readback;
    item def ControlInput;

    port def FlightPlanPort { out item plan : FlightPlan; }
    port def VoicePort {                        // bidirectional: declare both directions
        out item clearance : Clearance;
        in  item readback  : Readback;
    }
    port def ControlPort { out item cmd : ControlInput; }

    interface def AtcCrewVoice {                // reusable typed connection (e.g. VHF)
        end atcEnd  : VoicePort;
        end crewEnd : ~VoicePort;
        flow of Clearance from atcEnd.clearance to crewEnd.clearance;
        flow of Readback  from crewEnd.readback to atcEnd.readback;
    }

    part def IntentChain {
        part aoc  : FlightOperations::AirlineOperationsCenter { port fpOut : FlightPlanPort; }
        part atc  : AirspaceManagement::AirTrafficControlSystem {
            port fpIn  : ~FlightPlanPort;
            port voice : VoicePort;
        }
        part captain : FlightCrew::Captain {
            port voice  : ~VoicePort;
            port stick  : ControlPort;
        }
        part aircraft : AircraftSystems::Aircraft { port controls : ~ControlPort; }

        flow of FlightPlan from aoc.fpOut.plan to atc.fpIn.plan;
        interface vhf : AtcCrewVoice connect atc.voice to captain.voice;
        flow of ControlInput from captain.stick.cmd to aircraft.controls.cmd;
    }
}

view 'Intent Chain IBD' : InterconnectionView {
    expose IbdExample::IntentChain::**;
}
```

Choosing the edge: **`connection`** says "these are linked" (fine for context-level). **`flow of X`** says "X moves from A to B" (use when the *item* is the point). **`interface`** is a typed, reusable connection between compatible ports, carrying its own flows (use for a real channel like VHF voice, CPDLC, ACARS, used in more than one place). **`bind a = b;`** equates two features; it's for delegating a boundary port to an inner part's port.

---

## 6. State machine: `StateTransitionView`

**Purpose:** modes of one thing and what drives changes. The aircraft's flight phases are the natural one for this project, because transitions are triggered by the clearances that carry intent.

```sysml
package StateExample {
    item def PushbackClearance;
    item def TakeoffClearance;
    item def LandingClearance;

    state def FlightPhase {
        entry; then atGate;

        state atGate;
        state taxiOut;
        state airborne {
            entry action startTracking;           // entry/do/exit render as compartments
            do action followTrajectory;
            exit action stopTracking;
        }
        state taxiIn;

        transition pushback  first atGate   accept PushbackClearance then taxiOut;
        transition takeoff   first taxiOut  accept TakeoffClearance  then airborne;
        transition landing   first airborne accept LandingClearance  then taxiIn;
        transition blockIn   first taxiIn   then atGate;
    }

    part def Aircraft2 {
        attribute fuelKg : ScalarValues::Real;
        exhibit state phase : FlightPhase;       // tie behavior to structure
    }
}

view 'Flight Phase States' : StateTransitionView {
    expose StateExample::FlightPhase::**;
}
```

Transition anatomy: `transition name first <source> accept <trigger> if <guard> do <effect> then <target>;`. Triggers can be an item/signal type (`accept TakeoffClearance`), a change (`accept when fuelKg < 2000`), or a time (`accept after 20 [min]`, needs `SI` units). Nest states for hierarchy (e.g. `airborne` → `climb`, `cruise`, `descent`); use `state def X parallel { … }` for concurrent regions.

---

## 7. Activity / action flow: `ActionFlowView`

**Purpose:** the ordered functions that carry intent, with decisions and object flows. Good for the "enterprise objective → trajectory" chain as a functional (not structural) view.

```sysml
package ActionExample {
    private import ScalarValues::*;
    item def FlightPlan;
    item def Clearance;

    action def DepartureIntentChain {
        in item plan : FlightPlan;
        attribute edctIssued : Boolean;

        first start;
        then action file   { in item plan : FlightPlan; out item filed : FlightPlan; }
        then action evaluateFlow;                           // TFM / ATCSCC check
        then decide;
            if edctIssued     then holdForEdct;
            if not edctIssued then issueClearance;

        action holdForEdct;
        then issueClearance;

        action issueClearance { out item clr : Clearance; }
        then action readback  { in item clr : Clearance; }
        then action executeDeparture;
        then done;

        flow file.filed to evaluateFlow;                    // object flow
        flow issueClearance.clr to readback.clr;
    }

    // Allocation: function -> structure (who performs it)
    part def Allocations {
        allocate DepartureIntentChain::file           to NationalAirspaceSystem::FlightOperations::AirlineOperationsCenter;
        allocate DepartureIntentChain::issueClearance to NationalAirspaceSystem::AirspaceManagement::AirTrafficControlSystem;
    }
}

view 'Departure Intent Flow' : ActionFlowView {
    expose ActionExample::DepartureIntentChain::**;
}
```

Control nodes: `start`, `done`, `decide`, `merge`, `fork`, `join`. `then` is control succession; `flow` is data/item movement. Syside doesn't yet render **swim lanes**. Show responsibility with `allocate` + an allocation matrix (§9) instead, or perform actions inside the owning parts (`perform action`).

---

## 8. Sequence diagram: `SequenceView`

**Purpose:** time-ordered messages between lifelines for one scenario. Pairs naturally with the instance scenarios in `cameo_models/scenarios/`.

```sysml
package SequenceExample {
    item def ClearanceRequest;
    item def Clearance;
    item def Readback;

    part def ClearanceDelivery {
        part captain : NationalAirspaceSystem::FlightCrew::Captain;
        part atc : NationalAirspaceSystem::AirspaceManagement::AirTrafficControlSystem;

        message request  of ClearanceRequest from captain to atc;
        message clearance of Clearance       from atc to captain;
        message readback  of Readback        from captain to atc;

        first request then clearance;
        first clearance then readback;
    }
}

view 'Clearance Delivery Sequence' : SequenceView {
    expose SequenceExample::ClearanceDelivery::**;
}
```

Parts become lifelines, `message`s become arrows, and `first … then …` fixes the ordering. Nested sequence references (interaction uses) aren't supported yet, so keep one scenario per view.

---

## 9. Requirements & traceability: `GeneralView` + matrix

Follow the existing hierarchy in [requirements_definitions.sysml](../../projects/nas-sos-capstone/cameo_models/requirements_definitions.sysml) (`NasRequirement` → `StakeholderNeed` / `SystemLevelRequirement`).

```sysml
requirement def ClearanceReadbackReq :> RequirementDefinitions::SystemLevelRequirement {
    doc /* The flight crew shall read back each ATC clearance. [A] JO 7110.65 */
    subject crew : NationalAirspaceSystem::FlightCrew::FlightCrewDomain;
}
requirement readbackReq : ClearanceReadbackReq;

part def TraceExample {
    part crew : NationalAirspaceSystem::FlightCrew::FlightCrewDomain;
    satisfy readbackReq by crew;          // requirement -> component
}
```

Traceability matrix (needs the `SysideViews.sysml` library, offered on first open of the *SysMLv2 Views (labs)* panel; don't rename that file):

```sysml
package MyGrids {
    private import SysideViews::*;

    view reqTrace : MVD::MatrixView {
        view :>> rowView    { expose RequirementsNasSystem::*;  filter hastype SysML::RequirementUsage; }
        view :>> columnView { expose NationalAirspaceSystem::**; filter hastype SysML::PartUsage; }
        view :>> cellView   { expose ::**; }
    }
}
```

Use `MVD::AllocationMatrixView` with `attribute :>> direction = Dir::row2col;` for function → component allocation. Allocation matrices are **editable**: cell edits write back to the `.sysml`, so review the diff. `syside table export` produces CSV for the report.

---

## 10. Working checklist

1. Author **defs** in `nas_sysml_package_definitions.sysml`. Author **usages/wiring for a specific diagram** in its own file (like `nas_context_diagram.sysml`). Author **views** only in `nas_package_my_views.sysml`.
2. Every connection/flow gets a name or a typed item, plus a `doc` with an evidence tag ([A]/[B]/[C]) that points to [context-diagram-exchange-evidence.md](context-diagram-exchange-evidence.md) where relevant.
3. Save, run `syside check`, then `Ctrl+Alt+V` on the view. If an edge is missing, check that both endpoints are exposed and within `depth`.
4. Export report figures with `syside viz view … -f svg` so they can be regenerated after model changes.
5. A change to the boundary or decomposition means updating [decisions-log.md](../../decisions/decisions-log.md) (D-002 / D-007) as well as the model.

Minimum diagram set for the capstone: **Context** (§3) → **Domain BDD** (§4) → **Intent-chain IBD** (§5) → **Departure action flow + allocation** (§7, §9) → **Flight-phase states** (§6) → **one scenario sequence** (§8) → **requirement trace matrix** (§9).
