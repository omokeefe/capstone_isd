"""Draw a PNG of every block definition diagram (BDD) and internal block diagram (IBD).

Writes to projects/nas-sos-capstone/cameo_models/print/block-diagrams/, for printing and
hand review:

  view-<viewName>.png        each curated BDD or IBD view in nas_package_my_views.sysml
                             (every InterconnectionView, and each GeneralView named *Bdd),
                             drawn from the view's own expose root and #tag filter: the parts,
                             ports and connections the report figure shows.
  <Package>-<Def>-bdd.png    one per system, meaning a part def in NationalAirspaceSystem that
                             composes other parts: its parts --bdd-depth levels down (default
                             1; deeper parts are listed in each block, and every subsystem has
                             its own page), with ports, and the system's own attributes.
  <Package>-<Def>-ibd.png    one per system, and per part def that has only ports: its parts
                             nested --ibd-depth levels down (default 2), with their ports. Drawn
                             from the definitions, which hold no connections; the wiring is on
                             the view-*.png diagrams.

A fallback while the Syside renderer is blocked on this machine (2026-11-24,
knowledge/models/sysml-diagram-rendering.md section 5). It reads the model with the
syside Python library and lays it out with Graphviz, so each picture carries the model's
content but not Syside's look. The report's figures still come from
render_sysml_diagrams.py. A derived copy (D-006): change the model and rerun. The folder
belongs to this script: PNGs in it that a run does not produce are removed.

Usage (from the repo root, with the project venv, which has the syside library):
    .venv/Scripts/python.exe tools/print_block_diagrams.py [--bdd-depth 1] [--ibd-depth 2] [--dpi 150] [--list]

Needs Graphviz (`dot`; set GRAPHVIZ_DOT to its full path if it is not on PATH).
"""

from __future__ import annotations

import argparse
import datetime
import html
import math
import os
import re
import shutil
import subprocess
import sys
import textwrap
from dataclasses import dataclass, field
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
MODEL_DIR = REPO / "projects" / "nas-sos-capstone" / "cameo_models"
VIEWS_FILE = MODEL_DIR / "nas_package_my_views.sysml"
OUT_DIR = MODEL_DIR / "print" / "block-diagrams"
DOT_DIR = REPO / ".tmp" / "block-diagrams"
SYSTEM_PACKAGE = "NationalAirspaceSystem::"
LIBRARY_ROOTS = {"Base", "Parts", "Items", "Objects", "Occurrences", "Ports", "Links",
                 "Connections", "Interfaces", "Performances", "Actions", "States"}
FONT = "Arial"
HEADER_FILL = "#dde6f0"
PORT_FILL = "#f2f2f2"

VIEW_RE = re.compile(r"^(\s*)view\s+(\w+)\s*:\s*(\w+)")
CAPTION_RE = re.compile(r"^\s*//\s*caption:\s*(.+?)\s*$", re.IGNORECASE)
NOTE_RE = re.compile(r"^\s*//\s*note:\s*(.+?)\s*$", re.IGNORECASE)
DIRECTIVE_RE = re.compile(r"^\s*//\s*(caption|placement|note):", re.IGNORECASE)
EXPOSE_RE = re.compile(r"^\s*expose\s+([\w:]+?)::\*::\*\*\s*;")
FILTER_RE = re.compile(r"^\s*filter\s+(.+?);")


# ---------------------------------------------------------------- model access

def find_dot() -> str:
    for exe in (os.environ.get("GRAPHVIZ_DOT"), shutil.which("dot"), r"C:\Program Files\Graphviz\bin\dot.exe"):
        if exe and Path(exe).exists():
            return exe
    sys.exit("Graphviz `dot` was not found. Install Graphviz or set GRAPHVIZ_DOT to dot.exe.")


def load_model():
    try:
        import syside
    except ImportError:
        sys.exit("The syside package is missing. Run this with the project venv: .venv/Scripts/python.exe")
    files = sorted(str(p) for p in MODEL_DIR.rglob("*.sysml"))
    model, diagnostics = syside.try_load_model(files)
    errors = list(diagnostics.errors)
    if errors:
        for error in errors:
            print("  ", error)
        sys.exit(f"The model has {len(errors)} error(s); fix them first. Nothing was drawn.")
    return syside, model


def items(value) -> list:
    if value is None:
        return []
    try:
        return list(value.collect())
    except AttributeError:
        return list(value)


def qname(element) -> str:
    return str(element.qualified_name)


def tags(element) -> set[str]:
    found = set()
    for usage in items(element.metadata):
        definition = getattr(usage, "metadata_definition", None)
        if definition is not None:
            found.add(qname(definition))
    return found


def declared_type(element):
    """The element's own type, or None if it is typed only by the standard library."""
    for kind in items(element.types):
        if qname(kind).split("::")[0] not in LIBRARY_ROOTS:
            return kind
        return None
    return None


def multiplicity(element) -> str:
    rng = getattr(element, "declared_multiplicity", None)
    if rng is None or not hasattr(rng, "upper_bound"):
        return ""

    def bound(value) -> str:
        if value is None:
            return ""
        if type(value).__name__ == "LiteralInfinity":
            return "*"
        return str(getattr(value, "value", "?"))

    lower, upper = bound(rng.lower_bound), bound(rng.upper_bound)
    if not upper:
        return ""
    return f"[{lower}..{upper}]" if lower else f"[{upper}]"


def direction(element) -> str:
    value = getattr(element, "direction", None)
    return str(value).rsplit(".", 1)[-1].lower() if value is not None else ""


def nas_supertypes(syside, definition) -> list:
    out = []
    for spec in items(definition.owned_specializations):
        general = getattr(spec, "general", None)
        if isinstance(general, syside.PartDefinition) and qname(general).startswith(SYSTEM_PACKAGE):
            out.append(general)
            out.extend(nas_supertypes(syside, general))
    return out


def def_usages(syside, definition) -> list:
    """The definition's own usages, then those it inherits from NAS supertypes, minus redefined ones."""
    seen, out = set(), []
    for source in [definition] + nas_supertypes(syside, definition):
        for usage in items(source.owned_usages):
            if usage.name in seen:
                continue
            seen.add(usage.name)
            out.append(usage)
    return out


def kind_of(syside, usage) -> str | None:
    if isinstance(usage, syside.ConnectionUsage):   # also InterfaceUsage
        return "connection"
    if isinstance(usage, syside.PortUsage):
        return "port"
    if isinstance(usage, syside.PartUsage):
        return "part"
    return None


# ---------------------------------------------------------------- drawn tree

@dataclass
class Node:
    path: tuple
    kind: str           # "part" or "port"
    usage: object
    children: list = field(default_factory=list)
    node_id: str = ""


def view_tree(syside, root_def, wanted: set[str]):
    """Tagged usages under a diagram file's part def, as the Syside view draws them."""
    roots, connections = [], []

    def visit(usages, owner_path, out):
        for usage in usages:
            kind = kind_of(syside, usage)
            if kind is None or (wanted and not tags(usage) & wanted):
                continue
            if kind == "connection":
                connections.append((usage, owner_path))
                continue
            node = Node(owner_path + (usage.name,), kind, usage)
            out.append(node)
            if kind == "part":
                visit(items(usage.nested_usages), node.path, node.children)

    visit(items(root_def.owned_usages), (), roots)
    return roots, connections


def def_tree(syside, definition, depth: int):
    """A definition's ports and parts, nested `depth` levels, children taken from each part's type."""
    roots, connections = [], []

    def visit(usages, owner_path, out, level):
        for usage in usages:
            kind = kind_of(syside, usage)
            if kind is None:
                continue
            if kind == "connection":
                connections.append((usage, owner_path))
                continue
            node = Node(owner_path + (usage.name,), kind, usage)
            out.append(node)
            if kind == "part" and level < depth:
                inner = items(usage.nested_usages)
                names = {u.name for u in inner}
                part_type = declared_type(usage)
                if isinstance(part_type, syside.PartDefinition):
                    inner += [u for u in def_usages(syside, part_type) if u.name not in names]
                visit(inner, node.path, node.children, level + 1)

    visit(def_usages(syside, definition), (), roots, 1)
    return roots, connections


# ---------------------------------------------------------------- DOT output

def esc(text: str) -> str:
    return text.replace("\\", "\\\\").replace('"', '\\"')


def h(text: str) -> str:
    return html.escape(text, quote=True)


def columns(count: int) -> int:
    return max(1, math.ceil(math.sqrt(count)))


def graph_header(title: str, subtitle: str, rankdir: str, packed_count: int = 0) -> list[str]:
    """`packed_count` > 0: lay out with osage, which packs nested boxes into a grid (no edges to rank by)."""
    wrapped = [h(line) for paragraph in subtitle.split("\n") for line in textwrap.wrap(paragraph, 170)]
    label = f'<<B>{h(title)}</B><BR/><FONT POINT-SIZE="10">{"<BR/>".join(wrapped)}</FONT>>'
    packing = f', layout=osage, packmode="array_c{columns(packed_count)}"' if packed_count else ""
    return [
        "digraph G {",
        f'  graph [compound=true, rankdir={rankdir}, labelloc=t, labeljust=l, fontname="{FONT}", '
        f'fontsize=16, label={label}, nodesep=0.3, ranksep=0.5, pad=0.3{packing}];',
        f'  node [fontname="{FONT}", fontsize=11];',
        f'  edge [fontname="{FONT}", fontsize=9, color="#444444"];',
    ]


def part_label(usage) -> str:
    part_type = declared_type(usage)
    text = usage.name or "(unnamed)"
    if part_type is not None:
        text += f" : {part_type.name}"
    return text + multiplicity(usage)


def port_label(usage) -> str:
    port_type = declared_type(usage)
    text = usage.name
    if port_type is not None:
        text += f" : {port_type.name}"
    side = direction(usage)
    return f"{side} {text}" if side else text


def ibd_dot(title: str, subtitle: str, roots: list[Node], connections: list, frame: str | None) -> tuple[str, int, int]:
    """Nested IBD. Returns the DOT text, the number of links drawn, and the number left out.

    With no connections there is nothing for dot to rank by, so it would stack every box in
    one column; osage packs the boxes into a grid instead.
    """
    packed = not connections
    lines = graph_header(title, subtitle, "LR", (1 if frame else len(roots)) if packed else 0)
    by_path: dict[tuple, Node] = {}
    counter = iter(range(1_000_000))

    def packing(count: int) -> str:
        return f' packmode="array_c{columns(count)}";' if packed else ""

    def anchor(node_id: str) -> str:
        return "" if packed else f"{node_id} [shape=point, style=invis, width=0.01];"

    def emit(node: Node, indent: str):
        node.node_id = f"n{next(counter)}"
        by_path[node.path] = node
        usage = node.usage
        if node.kind == "port":
            lines.append(f'{indent}{node.node_id} [shape=box, style="filled", fillcolor="{PORT_FILL}", '
                         f'fontsize=9, height=0.25, label="{esc(port_label(usage))}"];')
            return
        style = "rounded,dashed" if usage.is_reference else "rounded"
        if node.children:
            lines.append(f"{indent}subgraph cluster_{node.node_id} {{")
            lines.append(f'{indent}  label="{esc(part_label(usage))}"; style="{style}"; '
                         f'color="#555555"; fontsize=12; margin=12;{packing(len(node.children))}')
            lines.append(f"{indent}  {anchor(node.node_id)}")
            for child in node.children:
                emit(child, indent + "  ")
            lines.append(f"{indent}}}")
        else:
            lines.append(f'{indent}{node.node_id} [shape=box, style="{style}", label="{esc(part_label(usage))}"];')

    indent = "  "
    if frame:
        lines.append("  subgraph cluster_frame {")
        lines.append(f'    label="{esc(frame)}"; style="rounded"; color="#222222"; penwidth=1.6; '
                     f'fontsize=13; margin=16;{packing(len(roots))}')
        indent = "    "
    for node in roots:
        emit(node, indent)
    if frame:
        lines.append("  }")

    def end_path(end, owner_path):
        feature = getattr(end, "referenced_feature", None)
        if feature is None:
            return None
        chain = [f.name for f in items(feature.chaining_features)] or [feature.name]
        for keep in range(len(owner_path), -1, -1):
            candidate = owner_path[:keep] + tuple(chain)
            if candidate in by_path:
                return candidate
        return None

    def role(path, other):
        """'src' or 'dst' for a port end, from its direction and whether it delegates inward."""
        node = by_path[path]
        if node.kind != "port":
            return None
        side = direction(node.usage)
        owner_is_ancestor = other[: len(path) - 1] == path[:-1]
        if side == "out":
            return "dst" if owner_is_ancestor else "src"
        if side == "in":
            return "src" if owner_is_ancestor else "dst"
        return None

    drawn = skipped = 0
    for connection, owner_path in connections:
        ends = items(connection.owned_end_features)
        paths = [end_path(end, owner_path) for end in ends]
        if len(paths) != 2 or None in paths:
            skipped += 1
            continue
        a, b = paths
        attrs = [f'label="{esc(connection.name or "")}"']
        role_a, role_b = role(a, b), role(b, a)
        if role_a == "src" or role_b == "dst":
            attrs.append("dir=forward")
        elif role_a == "dst" or role_b == "src":
            attrs.append("dir=back")
        else:
            attrs.append("dir=none")
        node_a, node_b = by_path[a], by_path[b]
        if node_a.kind == "part" and node_a.children:
            attrs.append(f"ltail=cluster_{node_a.node_id}")
        if node_b.kind == "part" and node_b.children:
            attrs.append(f"lhead=cluster_{node_b.node_id}")
        lines.append(f"  {node_a.node_id} -> {node_b.node_id} [{', '.join(attrs)}];")
        drawn += 1
    lines.append("}")
    return "\n".join(lines), drawn, skipped


def block_label(stereotype: str, name: str, compartments: list[tuple[str, list[str]]]) -> str:
    rows = [f'<TR><TD BGCOLOR="{HEADER_FILL}"><FONT POINT-SIZE="9">{h(stereotype)}</FONT><BR/><B>{h(name)}</B></TD></TR>']
    for heading, entries in compartments:
        if entries:
            body = "<BR/>".join(h(e) for e in entries)
            rows.append(f'<TR><TD ALIGN="LEFT" BALIGN="LEFT"><I>{h(heading)}</I><BR/>{body}</TD></TR>')
    return f'<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0" CELLPADDING="4">{"".join(rows)}</TABLE>>'


def bdd_dot(syside, root, depth: int, title: str, subtitle: str) -> str:
    """Composition tree of definitions below `root`, `depth` levels down."""
    nodes: dict[str, str] = {}
    edges: list[str] = []
    labels: dict[str, str] = {}
    counter = iter(range(1_000_000))

    def ports_of(definition) -> list[str]:
        return [port_label(u) for u in def_usages(syside, definition) if kind_of(syside, u) == "port"]

    def parts_of(definition) -> list:
        return [u for u in def_usages(syside, definition) if kind_of(syside, u) == "part"]

    def add(definition, level: int) -> str:
        key = qname(definition)
        if key in nodes:
            return nodes[key]
        node_id = f"b{next(counter)}"
        nodes[key] = node_id
        compartments = [("ports", ports_of(definition))]
        if level == 0:
            attributes = [f"{u.name} : {declared_type(u).name if declared_type(u) else '?'}{multiplicity(u)}"
                          for u in def_usages(syside, definition) if isinstance(u, syside.AttributeUsage)]
            compartments.append(("attributes", attributes))
        parts = parts_of(definition)
        if level >= depth:
            compartments.append(("parts", [part_label(p) for p in parts]))
        labels[node_id] = block_label("«part def»", definition.name, compartments)
        if level < depth:
            for part in parts:
                part_type = declared_type(part)
                label = f"{part.name}{multiplicity(part)}"
                if isinstance(part_type, syside.PartDefinition):
                    target = add(part_type, level + 1)
                else:
                    target = f"b{next(counter)}"
                    labels[target] = block_label("«part»", f"{part.name} (untyped)", [])
                if part.is_reference:
                    edges.append(f'  {node_id} -> {target} [label="{esc(label)}", style=dashed, arrowhead=vee];')
                else:
                    edges.append(f'  {node_id} -> {target} [label="{esc(label)}", dir=back, arrowtail=diamond];')
        return node_id

    root_id = add(root, 0)
    for general in nas_supertypes(syside, root)[:1]:
        general_id = add(general, depth)  # drawn with its parts listed, not expanded
        edges.append(f"  {general_id} -> {root_id} [dir=back, arrowtail=empty];")
    rankdir = "LR" if len(nodes) > 14 else "TB"
    lines = graph_header(title, subtitle, rankdir)
    lines += [f"  {nid} [shape=plaintext, margin=0, label={label}];" for nid, label in labels.items()]
    lines += edges
    lines.append("}")
    return "\n".join(lines)


def usage_bdd_dot(title: str, subtitle: str, roots: list[Node]) -> str:
    """A curated GeneralView drawn as a tree: each tagged part and the parts it composes."""
    lines = graph_header(title, subtitle, "TB")
    counter = iter(range(1_000_000))

    def emit(node: Node) -> str:
        node_id = f"u{next(counter)}"
        usage = node.usage
        part_type = declared_type(usage)
        label = block_label("«part»", f"{usage.name}{multiplicity(usage)} : {part_type.name if part_type else '?'}", [])
        lines.append(f"  {node_id} [shape=plaintext, margin=0, label={label}];")
        for child in node.children:
            if child.kind == "part":
                lines.append(f"  {node_id} -> {emit(child)} [dir=back, arrowtail=diamond];")
        return node_id

    for node in roots:
        if node.kind == "part":
            emit(node)
    lines.append("}")
    return "\n".join(lines)


# ---------------------------------------------------------------- what to draw

def curated_views() -> list[dict]:
    """BDD and IBD views in nas_package_my_views.sysml, with their expose root and tag filter."""
    lines = VIEWS_FILE.read_text(encoding="utf-8").splitlines()
    views = []
    for i, line in enumerate(lines):
        match = VIEW_RE.match(line)
        if not match:
            continue
        indent, name, kind = match.groups()
        if not (kind == "InterconnectionView" or (kind == "GeneralView" and name.lower().endswith("bdd"))):
            continue
        caption, notes = name, []
        j = i - 1
        while j >= 0 and DIRECTIVE_RE.match(lines[j]):   # the comment block directly above the view
            if CAPTION_RE.match(lines[j]):
                caption = CAPTION_RE.match(lines[j]).group(1)
            if NOTE_RE.match(lines[j]):
                notes.insert(0, NOTE_RE.match(lines[j]).group(1))
            j -= 1
        root, wanted = None, set()
        for body in lines[i + 1:]:
            if body.strip() == "}" and len(body) - len(body.lstrip()) == len(indent):
                break
            exposed = EXPOSE_RE.match(body)
            if exposed:
                root = exposed.group(1)
            filtered = FILTER_RE.match(body)
            if filtered:
                wanted |= set(re.findall(r"@\s*([\w:]+)", filtered.group(1)))
        views.append({"name": name, "kind": kind, "caption": caption, "note": " ".join(notes),
                      "root": root, "tags": wanted})
    return views


def systems(syside, model) -> list[tuple]:
    """(definition, draw_bdd, draw_ibd) for every NAS part def with parts or ports."""
    out = []
    for definition in model.nodes(syside.PartDefinition):
        if not qname(definition).startswith(SYSTEM_PACKAGE):
            continue
        usages = def_usages(syside, definition)
        composite = [u for u in usages if kind_of(syside, u) == "part" and not u.is_reference]
        ports = [u for u in usages if kind_of(syside, u) == "port"]
        if composite or ports:
            out.append((definition, bool(composite), True))
    return sorted(out, key=lambda row: qname(row[0]))


def file_stem(definition) -> str:
    parts = qname(definition).split("::")
    return f"{parts[-2]}-{parts[-1]}"


# ---------------------------------------------------------------- main

def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--bdd-depth", type=int, default=1,
                        help="levels of composition each system's BDD expands (default 1; deeper parts are "
                             "listed in a parts compartment, and every subsystem has its own BDD)")
    parser.add_argument("--ibd-depth", type=int, default=2, help="levels of parts nested in each system's IBD (default 2)")
    parser.add_argument("--dpi", type=int, default=150, help="PNG resolution (default 150)")
    parser.add_argument("--list", action="store_true", help="list what would be drawn; draw nothing")
    args = parser.parse_args()

    syside, model = load_model()
    today = datetime.date.today().isoformat()
    stamp = f"Drawn {today} by tools/print_block_diagrams.py with Graphviz from the .sysml model (not the Syside render)."
    jobs: list[tuple[str, str]] = []   # (file name, DOT text)
    notes: list[str] = []

    definitions = {qname(d): d for d in model.nodes(syside.PartDefinition)}
    for view in curated_views():
        root = definitions.get(view["root"] or "")
        if root is None:
            notes.append(f"view {view['name']}: expose root {view['root']!r} not found; skipped")
            continue
        roots, connections = view_tree(syside, root, view["tags"])
        title = f"{'BDD' if view['kind'] == 'GeneralView' else 'IBD'} view {view['name']}: {view['caption']}"
        subtitle = f"Expose {view['root']}, filter {' or '.join(sorted(view['tags'])) or 'none'}. {stamp}"
        if view["note"]:
            subtitle = f"{view['note']}\n{subtitle}"
        if view["kind"] == "GeneralView":
            jobs.append((f"view-{view['name']}.png", usage_bdd_dot(title, subtitle, roots)))
        else:
            text, drawn, skipped = ibd_dot(title, subtitle, roots, connections, None)
            jobs.append((f"view-{view['name']}.png", text))
            if skipped:
                notes.append(f"view {view['name']}: {skipped} tagged link(s) left out because an end is not drawn")

    for definition, draw_bdd, draw_ibd in systems(syside, model):
        stem, name = file_stem(definition), qname(definition)
        if draw_bdd:
            jobs.append((f"{stem}-bdd.png", bdd_dot(
                syside, definition, args.bdd_depth, f"BDD: {definition.name}",
                f"{name}, composition {args.bdd_depth} level(s) down. {stamp}")))
        if draw_ibd:
            roots, connections = def_tree(syside, definition, args.ibd_depth)
            text, _, _ = ibd_dot(
                f"IBD: {definition.name}",
                f"{name}, parts {args.ibd_depth} levels down. Definitions hold no connections; "
                f"the wiring is on the view-*.png diagrams. {stamp}",
                roots, connections, f"«part def» {definition.name}")
            jobs.append((f"{stem}-ibd.png", text))

    if args.list:
        for file_name, _ in jobs:
            print(" ", file_name)
        for note in notes:
            print("  note:", note)
        print(f"{len(jobs)} diagrams would be drawn into {OUT_DIR.relative_to(REPO)}.")
        return 0

    dot = find_dot()
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    DOT_DIR.mkdir(parents=True, exist_ok=True)
    failures = 0
    for file_name, text in jobs:
        source = DOT_DIR / (Path(file_name).stem + ".dot")
        source.write_text(text, encoding="utf-8")
        done = subprocess.run([dot, "-Tpng", f"-Gdpi={args.dpi}", "-o", str(OUT_DIR / file_name), str(source)],
                              capture_output=True, text=True)
        warnings = [l for l in done.stderr.splitlines() if l.strip()]
        if done.returncode != 0:
            failures += 1
            print(f"  FAILED  {file_name}: {warnings[-1] if warnings else done.returncode}")
        else:
            print(f"  drawn   {file_name}" + (f"   ({len(warnings)} Graphviz warning(s))" if warnings else ""))
    produced = {file_name for file_name, _ in jobs}
    for stale in OUT_DIR.glob("*.png"):
        if stale.name not in produced:
            stale.unlink()
            print(f"  removed {stale.name} (no longer in the model)")
    for note in notes:
        print("  note:", note)
    print(f"{len(jobs) - failures} of {len(jobs)} diagrams written to {OUT_DIR.relative_to(REPO)}.")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
