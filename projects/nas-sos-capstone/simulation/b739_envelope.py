"""Two analysis figures for the B737-9 from OpenAP (D-017).

Figure 1, ``b739_fuelflow_altitude.png``: fuel flow and specific range against
altitude at a fixed Mach for the heavy and light aircraft of the experiment, with
each one's best altitude marked and the thrust-limited levels greyed out. This is
the mechanism the experiment rests on and the acceptance check against
mori2022massCruise (the cost-optimal altitude falls as mass rises).

Figure 2, ``b739_envelope.png``: the cruise envelope of the heavy aircraft (AC1)
assuming lift equals weight, drawn to show how little room it has to manoeuvre at
its cruise level. Left panel: the low-speed boundary from CL = 2W / (rho V^2 S) at
an assumed clean maximum lift coefficient, the high-speed boundary from MMO and VMO,
three lines of constant rate of climb left (0, 100 and 150 ft/min), the aircraft's
present level and Mach, and each altitude and speed instruction the scenario offers
it, marked available or not. Right panels: the width of the usable speed band and
the rate of climb left at the cruise Mach, level by level.

The three climb lines, and which one bounds the usable region:
  - 0 ft/min: OpenAP's maximum thrust equals clean drag; no level flight above it.
  - 100 ft/min: the service ceiling, "the maximum height above MSL at which an
    airplane can maintain a rate of climb of 100 ft per minute (ft/min) under normal
    conditions" (faa2015ac61107b para. 1-4r, p. 2).
  - ``min_climb_rate_ft_min`` in scenario_base.yaml (150 ft/min): the margin many
    airlines keep for clear air turbulence and other unknowns [SME]. A speed and level
    is usable only if at least this much climb is left there.

Assumptions, all stated in the figure text:
  - ISA atmosphere, no wind.
  - CL_MAX_CLEAN below is an assumption [C]; OpenAP does not publish one. A 1.3 margin
    on stall speed is applied (14 CFR 25 style). Replace with a sourced value.
  - OpenAP borrows the 737 MAX 8 drag polar for B39M (use_synonym=True).

Run from the repo root:
    .venv/Scripts/python.exe projects/nas-sos-capstone/simulation/b739_envelope.py
Writes to projects/nas-sos-capstone/report/figures/.
"""

from __future__ import annotations

import math
import warnings
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402
import numpy as np  # noqa: E402
import yaml  # noqa: E402
from openap import Drag, FuelFlow, Thrust, prop  # noqa: E402

HERE = Path(__file__).resolve().parent
FIG_DIR = HERE.parent / "report" / "figures"
SCENARIO = HERE / "scenario_base.yaml"

AC = yaml.safe_load(SCENARIO.read_text(encoding="utf-8"))["type"]["aircraftType"]  # NasAnalysis::PerformanceModel.aircraftType; B39M
CL_MAX_CLEAN = 1.45  # [C] assumption; see module docstring
STALL_MARGIN = 1.3
SERVICE_CEILING_ROC_FPM = 100.0  # faa2015ac61107b para. 1-4r
KT = 0.514444  # m/s per knot
FT = 0.3048


def isa(alt_ft: float) -> tuple[float, float, float]:
    """ISA temperature (K), pressure (Pa), density (kg/m^3) up to 20 km."""
    h = alt_ft * FT
    if h < 11_000:
        t = 288.15 - 0.0065 * h
        p = 101_325 * (t / 288.15) ** 5.2559
    else:
        t = 216.65
        p = 22_632 * math.exp(-9.80665 * (h - 11_000) / (287.05 * t))
    return t, p, p / (287.05 * t)


def tas_from_mach(mach: float, alt_ft: float) -> float:
    t, _, _ = isa(alt_ft)
    return mach * math.sqrt(1.4 * 287.05 * t) / KT


def tas_from_cas(cas_kt: float, alt_ft: float) -> float:
    """Convert calibrated to true airspeed (compressible, ISA)."""
    _, p, rho = isa(alt_ft)
    p0, rho0 = 101_325.0, 1.225
    v = cas_kt * KT
    qc = p0 * ((1 + 0.2 * (v / math.sqrt(1.4 * p0 / rho0)) ** 2) ** 3.5 - 1)
    mach = math.sqrt(5 * ((qc / p + 1) ** (2 / 7) - 1))
    return mach * math.sqrt(1.4 * p / rho) / KT


def load_masses() -> tuple[float, float, float]:
    data = yaml.safe_load(SCENARIO.read_text(encoding="utf-8"))
    masses = {f["flight"]["flightNumber"]: f["cruise"]["massKg"] for f in data["flights"]}
    heavy = masses["AC1"]
    light = masses["AC2"]
    nominal = data["type"]["nominalMassKg"]
    return heavy, light, nominal


def figure_fuelflow(ff: FuelFlow, th: Thrust, dr: Drag, heavy: float, light: float, mach: float) -> Path:
    levels = np.arange(300, 412, 2)
    fig, axes = plt.subplots(1, 2, figsize=(11, 4.6))
    for mass, label, color in ((heavy, f"heavy, {heavy/1000:.1f} t", "#b2182b"), (light, f"light, {light/1000:.1f} t", "#2166ac")):
        fuel, srange, ok = [], [], []
        for fl in levels:
            alt = float(fl * 100)
            tas = tas_from_mach(mach, alt)
            f = float(ff.enroute(mass, tas, alt)) * 3600
            fuel.append(f)
            srange.append(tas / f)  # NM per kg (TAS kt = NM/h)
            ok.append(float(th.cruise(tas, alt)) >= float(dr.clean(mass, tas, alt)))
        fuel, srange, ok = np.array(fuel), np.array(srange), np.array(ok)
        axes[0].plot(fuel, levels, color=color, label=label)
        axes[1].plot(srange, levels, color=color, label=label)
        feasible = np.where(ok)[0]
        if feasible.size:
            best = feasible[np.argmax(srange[feasible])]
            axes[1].plot(srange[best], levels[best], "o", color=color)
            axes[1].annotate(f"best FL{levels[best]}", (srange[best], levels[best]), xytext=(6, -4), textcoords="offset points", color=color, fontsize=8)
            top = levels[feasible[-1]]
            for ax in axes:
                ax.axhline(top, color=color, linestyle=":", linewidth=0.8)
                ax.annotate(f"thrust limit FL{top}", (ax.get_xlim()[0], top), xytext=(4, 3), textcoords="offset points", color=color, fontsize=7)
    axes[0].set_xlabel("fuel flow, kg/h")
    axes[1].set_xlabel("specific range, NM per kg of fuel")
    for ax in axes:
        ax.set_ylabel("flight level")
        ax.grid(True, linewidth=0.4, alpha=0.6)
        ax.legend(loc="lower right", fontsize=8)
    fig.suptitle(f"B737-9 at Mach {mach:.2f}, ISA, still air (OpenAP; drag polar borrowed from the 737 MAX 8)", fontsize=10)
    fig.tight_layout()
    out = FIG_DIR / "b739_fuelflow_altitude.png"
    fig.savefig(out, dpi=200)
    plt.close(fig)
    return out


def figure_envelope(th: Thrust, dr: Drag, heavy: float, ac: dict, scenario: dict) -> Path:
    """Heavy aircraft only: the envelope, and how much room to manoeuvre is left in it."""
    s = ac["wing"]["area"]
    mmo, vmo = ac["mmo"], ac["vmo"]
    geo = scenario["geometry"]
    ac1 = next(f for f in scenario["flights"] if f["flight"]["flightNumber"] == "AC1")
    level, mach = ac1["cruise"]["altitudeFt"], ac1["cruise"]["machNumber"]
    # Climb an operator wants left at a level before it will fly there [SME]; never below the service-ceiling 100.
    margin = max(float(geo.get("min_climb_rate_ft_min", SERVICE_CEILING_ROC_FPM)), SERVICE_CEILING_ROC_FPM)
    color, ink, muted = "#b2182b", "#0b0b0b", "#52514e"

    # From FL310 up: OpenAP's cruise thrust model steps at 30,000 ft, below every level in the scenario.
    alts = np.arange(31_000, 42_001, 100)
    speeds = np.arange(250.0, 521.0, 2.0)
    hi = np.array([min(tas_from_mach(mmo, a), tas_from_cas(vmo, a)) for a in alts])
    lo = np.array([STALL_MARGIN * math.sqrt(2 * heavy * 9.80665 / (isa(a)[2] * s * CL_MAX_CLEAN)) / KT for a in alts])

    # Rate of climb left: excess thrust (maximum thrust minus clean drag) x speed / weight, in ft/min.
    def climb_left(v_kt: float, alt_ft: float) -> float:
        ex = float(th.cruise(v_kt, alt_ft)) - float(dr.clean(heavy, v_kt, alt_ft))
        return ex * v_kt * KT / (heavy * 9.80665) / FT * 60

    roc_grid = np.array([[climb_left(v, a) for v in speeds] for a in alts])
    within = (speeds[None, :] >= lo[:, None]) & (speeds[None, :] <= hi[:, None])
    # Usable speed band at each altitude: inside both speed limits and with the operator's climb margin left.
    band_lo, band_hi = np.full(alts.size, np.nan), np.full(alts.size, np.nan)
    for i in range(alts.size):
        ok = speeds[(roc_grid[i] >= margin) & within[i]]
        if ok.size:
            band_lo[i], band_hi[i] = max(lo[i], ok.min() - 2.0), min(hi[i], ok.max() + 2.0)
    inside = ~np.isnan(band_lo)
    width = np.where(inside, band_hi - band_lo, 0.0)
    roc_raw = np.array([climb_left(tas_from_mach(mach, a), a) for a in alts])
    roc = np.maximum(roc_raw, 0.0)

    # Highest level with a given climb left: at the best speed inside the limits, and at the cruise Mach.
    def top_level(need: float) -> tuple[int, int]:
        best = np.where(within, roc_grid, -np.inf).max(axis=1)
        return int(alts[best >= need][-1]), int(alts[roc_raw >= need][-1])

    lines = [(0.0, "no level flight above (thrust = drag)", ":"), (SERVICE_CEILING_ROC_FPM, "service ceiling, 100 ft/min left", "--")]
    if margin > SERVICE_CEILING_ROC_FPM:
        lines.append((margin, f"operator margin, {margin:.0f} ft/min left", "-"))
    widths = (0.9, 1.2, 1.6)[: len(lines)]
    tops = {need: top_level(need) for need, _, _ in lines}

    fig, (ax, axw, axr) = plt.subplots(1, 3, figsize=(11.5, 5.6), sharey=True, gridspec_kw={"width_ratios": [3.1, 1, 1], "wspace": 0.07})
    fl = alts / 100

    # Panel 1: the envelope.
    ax.fill_betweenx(fl, band_lo, band_hi, where=inside, color=color, alpha=0.13, linewidth=0)
    ax.plot(hi, fl, color=ink, linewidth=1.4)
    ax.plot(lo, fl, color=color, linewidth=1.4, linestyle="--")
    between = (speeds[None, :] >= lo[:, None] - 2.0) & (speeds[None, :] <= hi[:, None] + 2.0)
    ax.contour(speeds, fl, np.ma.masked_where(~between, roc_grid), levels=[n for n, _, _ in lines], colors=[color], linewidths=widths, linestyles=[ls for _, _, ls in lines])
    ax.text(hi[10] + 4, fl[10], f"MMO {mmo}", ha="left", va="center", fontsize=8, color=ink)
    ax.text(lo[40] - 5, fl[40], f"{STALL_MARGIN} x stall,\nCLmax {CL_MAX_CLEAN} (assumed)", ha="right", va="center", fontsize=8, color=ink)
    ax.text(415, 328, "usable speeds\nand levels", ha="center", va="center", fontsize=9, color=muted)

    # The aircraft now, and the instructions the scenario offers it.
    def usable(alt_ft: float, m: float) -> bool:
        i = int(np.argmin(np.abs(alts - alt_ft)))
        return bool(inside[i]) and band_lo[i] <= tas_from_mach(m, alt_ft) <= band_hi[i]

    v_now = tas_from_mach(mach, level)
    levers = [(level + d, mach, f"{d:+,} ft") for d in geo["altitude_steps_ft"]]
    levers += [(level, mach + sgn * geo["speed_change_mach"], f"{sgn * geo['speed_change_mach']:+.2f} Mach") for sgn in (1, -1)]
    for alt_ft, m, text in levers:
        v = tas_from_mach(m, alt_ft)
        good = usable(alt_ft, m)
        ax.plot([v_now, v], [level / 100, alt_ft / 100], color=muted, linewidth=0.9, zorder=4)
        if good:
            ax.plot(v, alt_ft / 100, "o", markersize=7, markerfacecolor=ink, markeredgecolor="white", markeredgewidth=1.2, zorder=5)
        else:
            ax.plot(v, alt_ft / 100, "X", markersize=8.5, markerfacecolor="white", markeredgecolor=ink, markeredgewidth=1.3, zorder=5)
        left = m <= mach
        if alt_ft != level:
            ax.annotate(text, (v, alt_ft / 100), xytext=(-9, 0), textcoords="offset points", ha="right", va="center", fontsize=8, color=ink)
        else:
            ax.annotate(text, (v, alt_ft / 100), xytext=(0, -9), textcoords="offset points", ha="right" if left else "left", va="top", fontsize=8, color=ink)
    ax.plot(v_now, level / 100, "o", markersize=9, markerfacecolor=color, markeredgecolor="white", markeredgewidth=1.4, zorder=6)
    ax.annotate(f"now: FL{level // 100}, Mach {mach:.2f}", (v_now, level / 100), xytext=(-9, 30), textcoords="offset points", ha="right", va="bottom", fontsize=8.5, fontweight="bold", color=ink, bbox={"facecolor": "white", "edgecolor": "none", "pad": 1.5}, zorder=7)
    handles = [plt.Line2D([], [], color=color, linestyle=ls, linewidth=lw, label=f"{text}: top FL{tops[need][0] // 100}") for (need, text, ls), lw in zip(lines, widths)]
    handles += [
        plt.Line2D([], [], marker="o", linestyle="", markersize=7, markerfacecolor=ink, markeredgecolor="white", label="instruction it can fly"),
        plt.Line2D([], [], marker="X", linestyle="", markersize=8.5, markerfacecolor="white", markeredgecolor=ink, label="instruction outside the envelope"),
    ]
    ax.legend(handles=handles, loc="upper left", fontsize=8, frameon=False)
    ax.set_xlim(300, 510)
    ax.set_xlabel("true airspeed, kt")
    ax.set_ylabel("flight level")
    ax.set_title("Envelope", fontsize=9.5, loc="left")

    # Panels 2 and 3: the room left, level by level.
    i_now = int(np.argmin(np.abs(alts - level)))
    i_ref = int(np.argmin(np.abs(alts - (level + min(geo["altitude_steps_ft"])))))
    for a_, vals, unit, title in ((axw, width, "kt", "Width of the usable\nspeed band, kt"), (axr, roc, "ft/min", f"Rate of climb left at\nMach {mach:.2f}, ft/min")):
        a_.fill_betweenx(fl, 0, vals, color=color, alpha=0.13, linewidth=0)
        a_.plot(vals, fl, color=color, linewidth=1.6)
        a_.set_xlim(0, vals.max() * 1.18)
        a_.set_title(title, fontsize=9.5, loc="left")
        for i in (i_ref, i_now):
            a_.plot(vals[i], fl[i], "o", markersize=6, markerfacecolor=color, markeredgecolor="white", markeredgewidth=1.1, zorder=5)
            a_.annotate(f"{vals[i]:.0f} {unit}", (vals[i], fl[i]), xytext=(7, 8), textcoords="offset points", ha="left", va="bottom", fontsize=8, color=ink)
        a_.tick_params(axis="y", length=0)
    for need, _, ls in lines[1:]:
        axr.axvline(need, color=muted, linewidth=0.8, linestyle=ls)
        axr.annotate(f"{need:.0f}", (need, 418), xytext=(-3 if need == SERVICE_CEILING_ROC_FPM else 3, 0), textcoords="offset points", ha="right" if need == SERVICE_CEILING_ROC_FPM else "left", va="top", fontsize=7, color=muted)
    for a_ in (ax, axw, axr):
        a_.axhline(level / 100, color=muted, linewidth=0.7, linestyle=":")
        a_.set_ylim(310, 420)
        a_.grid(True, linewidth=0.4, color="#e1e0d9")
        a_.set_axisbelow(True)
        for side in ("top", "right"):
            a_.spines[side].set_visible(False)
    # No title or footnote in the image: the report's caption carries the title and
    # Section 3.4 lists the simplifications (owner's review of the print, 2026-10-11).
    fig.subplots_adjust(left=0.055, right=0.99, top=0.93, bottom=0.10)
    out = FIG_DIR / "b739_envelope.png"
    fig.savefig(out, dpi=200)
    plt.close(fig)
    for need, text, _ in lines:
        print(f"heavy envelope, {text}: top FL{tops[need][0] / 100:.0f} at the best speed, FL{tops[need][1] / 100:.0f} at Mach {mach:.2f}")
    print(f"heavy envelope: speed band {width[i_ref]:.0f} kt at FL{alts[i_ref] // 100}, {width[i_now]:.0f} kt at FL{level // 100}; climb left {roc[i_ref]:.0f} and {roc[i_now]:.0f} ft/min")
    return out


def main() -> None:
    FIG_DIR.mkdir(parents=True, exist_ok=True)
    heavy, light, _ = load_masses()
    data = yaml.safe_load(SCENARIO.read_text(encoding="utf-8"))
    mach = data["flights"][0]["cruise"]["machNumber"]
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        ff, th, dr = FuelFlow(AC, use_synonym=True), Thrust(AC, use_synonym=True), Drag(AC, use_synonym=True)
    ac = prop.aircraft(AC)
    print("wrote", figure_fuelflow(ff, th, dr, heavy, light, mach))
    print("wrote", figure_envelope(th, dr, heavy, ac, data))


if __name__ == "__main__":
    main()
