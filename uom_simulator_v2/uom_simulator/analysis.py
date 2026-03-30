from __future__ import annotations

from statistics import mean


def analyze_aeon_history(history: list[dict], tail_n: int = 20) -> dict:
    if not history:
        return {}

    r_prev = [abs(rec.get("R_signed_prev", float("nan"))) for rec in history]
    min_r = min(r_prev)
    tick_min_r = r_prev.index(min_r)

    def _safe_h(rec: dict) -> float:
        h = rec.get("H_src", float("nan"))
        return h if h and h > 0.0 else float("nan")

    q_rg_sum = 0.0
    i_rg_sum = 0.0
    for rec in history:
        q = rec.get("Q_rg", 0.0)
        if q and q > 0.0:
            q_rg_sum += q
            h = _safe_h(rec)
            if h == h:  # not NaN
                i_rg_sum += q / h

    tail = history[-tail_n:] if len(history) >= tail_n else history

    def _mean(key: str) -> float:
        vals = [rec.get(key, float("nan")) for rec in tail]
        return mean(vals) if vals else float("nan")

    def _mean_ratio(num_key: str, den_key: str) -> float:
        ratios = []
        for rec in tail:
            den = rec.get(den_key, 0.0)
            if den != 0.0:
                ratios.append(rec.get(num_key, 0.0) / den)
        return mean(ratios) if ratios else float("nan")

    return {
        "min_R_abs_prev": min_r,
        "tick_min_R_abs_prev": tick_min_r,
        "theta_tail_mean": _mean("Theta_k"),
        "beta_tail_mean": _mean("beta_k"),
        "band_fraction_tail_mean": _mean("band_fraction"),
        "residual_tail_mean": _mean("Residual"),
        "k_tail_mean": _mean_ratio("Theta_k", "delta_I_k"),
        "Q_rg_sum": q_rg_sum,
        "I_rg_sum": i_rg_sum,
    }


def analyze_multi_aeon(summaries: list[dict]) -> dict:
    if not summaries:
        return {}

    r0_series = [s.get("initial_R0_abs", float("nan")) for s in summaries]
    q_actual = [s.get("q_actual", float("nan")) for s in summaries if s.get("q_actual") is not None]
    q_pred = [s.get("q_pred_formula_B", float("nan")) for s in summaries if s.get("q_pred_formula_B") is not None]

    return {
        "aeon_count": len(summaries),
        "q_actual_series": q_actual,
        "q_pred_series": q_pred,
        "q_actual_mean": mean(q_actual) if q_actual else float("nan"),
        "q_pred_mean": mean(q_pred) if q_pred else float("nan"),
    }
