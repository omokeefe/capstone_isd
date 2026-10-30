"""Altitude against time for the four aircraft when AC2 is moved down 4,000 ft and back.

Report figure ``scenario_altitude_vs_time.png`` (Section 3, Scenario), drawn from the
owner's hand sketch of 2026-10-29 (journal 2026-10-29). Time is minutes from the moment
AC1 and AC2 reach the waypoint at FL380 if nobody moves.

Timeline:
  - Decision 12 minutes before the waypoint (experiment-scenario-numbers.md §1);
    decision and radio call take under a minute, so the descent starts at -11.
  - Descent FL380 -> FL340 at the rate the scoring flies it, OpenAP's typical constant-Mach
    descent rate for the type (``PerformanceModel.descent_rate_fpm``).
  - Level at FL340 for ``maneuver_hold_min`` (15 min, owner confirmed 2026-10-29).
  - Climb back at the rate the scoring flies it: thrust minus drag at AC2's mass at the
    mid-altitude (``PerformanceModel.climb_rate_fpm``).
  - AC3 and AC4 at FL360 reach the waypoint about 1 and 2 minutes after AC1 (owner's
    sketch: very close behind AC1, about 60 s apart).

Run from the repo root:
    .venv/Scripts/python.exe projects/nas-sos-capstone/simulation/scenario_profile.py
Writes to projects/nas-sos-capstone/report/figures/.
"""

from __future__ import annotations

import warnings
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import yaml

from experiment_scoring import PerformanceModel

HERE = Path(__file__).resolve().parent
FIG_DIR = HERE.parent / "report" / "figures"
OUT = FIG_DIR / "scenario_altitude_vs_time.png"

DECISION_MIN = 12.0  # experiment-scenario-numbers.md §1; not in scenario_base.yaml
RADIO_MIN = 1.0  # decision plus clearance and read-back, owner's sketch
TRAIL_AT_WAYPOINT_MIN = {"AC3": 1.0, "AC4": 2.0}  # owner's sketch


def main() -> Path:
    sc = yaml.safe_load((HERE / "scenario_base.yaml").read_text(encoding="utf-8"))
    g = sc["geometry"]
    ac2 = next(f for f in sc["flights"] if f["flight"]["flightNumber"] == "AC2")
    mass, mach, level = ac2["cruise"]["massKg"], ac2["cruise"]["machNumber"], ac2["cruise"]["altitudeFt"]
    low = level - 4000

    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        perf = PerformanceModel("B39M")
    descent_fpm = -perf.descent_rate_fpm
    climb_fpm = perf.climb_rate_fpm(mass, mach, low, level)

    t_clear = -DECISION_MIN + RADIO_MIN
    t_low = t_clear + 4000 / descent_fpm
    t_up = t_low + g["maneuver_hold_min"]
    t_back = t_up + 4000 / climb_fpm
    t0, t1 = -DECISION_MIN - 1.5, t_back + 2.5

    blue, red, grey, ink, muted = "#2166ac", "#b2182b", "#7a7a7a", "#0b0b0b", "#52514e"
    fig, ax = plt.subplots(figsize=(8.0, 4.2))
    for fl in (340, 360, 380):
        ax.axhline(fl, color="#e2e2e2", linewidth=0.8, zorder=0)

    ax.plot([t0, t1], [380, 380], color=red, linewidth=1.6, label="AC1 (heavy), FL380")
    ax.plot(0, 380, "o", color=red, markersize=7, zorder=5)
    for name, shade in (("AC3", grey), ("AC4", "#a9a9a9")):
        ax.plot([t0, t1], [360, 360], color=shade, linewidth=1.2)
        ax.plot(TRAIL_AT_WAYPOINT_MIN[name], 360, "o", color=shade, markersize=6, zorder=5)
    ax.plot([], [], color=grey, linewidth=1.2, label="AC3, AC4 in trail, FL360")
    ax.text(TRAIL_AT_WAYPOINT_MIN["AC4"] + 0.4, 361.2, "AC3, AC4 at the waypoint", fontsize=8, color=muted, va="bottom")
    ax.text(0.4, 381.2, "AC1 at the waypoint", fontsize=8, color=red, va="bottom")

    ax.plot([t0, t_clear, t_low, t_up, t_back, t1], [380, 380, low / 100, low / 100, 380, 380], color=blue, linewidth=2.0, label="AC2 (light), descended and returned")

    ax.axvline(-DECISION_MIN, color=ink, linewidth=0.8, linestyle="--")
    ax.text(-DECISION_MIN - 0.2, 343, "decision", rotation=90, fontsize=8, color=ink, ha="right", va="bottom")
    ax.axvline(0, color=muted, linewidth=0.6, linestyle="--")

    def span(a: float, b: float, y: float, text: str) -> None:
        ax.annotate("", (a, y), (b, y), arrowprops={"arrowstyle": "<->", "color": muted, "linewidth": 0.8})
        ax.text((a + b) / 2, y - 0.8, text, fontsize=8, color=muted, ha="center", va="top")

    span(t_clear, t_low, 336.5, f"descend\n{t_low - t_clear:.1f} min")
    span(t_low, t_up, 336.5, f"level at FL{low // 100}\n{g['maneuver_hold_min']:.0f} min")
    span(t_up, t_back, 336.5, f"climb back\n{t_back - t_up:.1f} min")

    ax.set_xlim(t0, t1)
    ax.set_ylim(328, 386)
    ax.set_yticks([340, 360, 380], ["FL340", "FL360", "FL380"])
    ax.set_xlabel("minutes from AC1 and AC2 reaching the waypoint")
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    ax.legend(loc="lower center", bbox_to_anchor=(0.5, 1.0), fontsize=8, frameon=False, ncol=3)
    fig.tight_layout()
    FIG_DIR.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, dpi=200)
    print(f"descent {descent_fpm:.0f} ft/min ({t_low - t_clear:.2f} min), climb {climb_fpm:.0f} ft/min ({t_back - t_up:.2f} min), back at FL380 at +{t_back:.1f} min")
    print(f"wrote {OUT}")
    return OUT


if __name__ == "__main__":
    main()
