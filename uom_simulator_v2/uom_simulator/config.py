# uom_simulator/config.py

import json
from dataclasses import dataclass, field
from typing import get_args, get_origin

@dataclass
class PhysicsConstants:
    m5_ell: float
    kappa_ct: float
    M5_cubed: float
    gamma_anomaly: float

@dataclass
class SourceParams:
    H_src: float; L4_src: float; Lambda_src: float; a_cft_src: float
    m_src: float; l_max_source: int; cost_t_factor: float
    cost_x_factor: float; deltaL_soft_src: float

@dataclass
class ReceiverParams:
    L4_init: float; a_cft_rec: float; m_bullet: float
    v_geom: float; alpha_t: float; alpha_x: float; eta_wall_work: float
    lambda_by: float; lambda_conf: float; lambda_wall: float
    deltaL_soft: float; deltaL_taper: float;

@dataclass
class AeonRunParams:
    initial_R0_abs: float; initial_Lambda: float; initial_d_sep: float
    Lambda_star: float; max_ticks: int; tick_duration: float
    initial_F_dS_factor: float
    beta_factor: float;

@dataclass
class LeakParams:
    model: str
    chi: float
    gamma: float

@dataclass
class ScenarioParams:
    source: SourceParams
    receiver: ReceiverParams
    aeon: AeonRunParams


@dataclass
class SplitModelParams:
    eps_num: float = 1e-300
    eps_lambda: float = 1e-16
    split_resid_tol: float = 1e-20
    theta_min_abs: float = 0.0
    theta_min_rel: float = 1e-20
    landau_s_a: float = 1.0
    landau_eps: float | None = None
    q0_to_FdS_scale: float = 1.0
    FdS_floor: float = 0.0


@dataclass
class ShadowParams:
    G_shadow: float = 0.0
    d_growth_factor: float = 0.0
    insert_offset: float = 0.0
    kernel_mode_ads: str = "exp"
    kernel_mode_ds: str = "exp_cos"
    k_eff_factor: float = 1.0
    mass_scale: float = 1.0
    stack_seed: list["ShadowSeed"] = field(default_factory=list)


@dataclass
class ShadowSeed:
    Lambda_frozen: float
    R_signed_frozen: float
    H_frozen: float
    d0: float
    a_cft_src: float | None = None


@dataclass
class SeparationParams:
    active_init_mode: str = "birth_by"
    birth_by_method: str = "by_peak"
    c_by: float = 1.0
    active_growth_model: str = "aeon_expansion"
    shadow_growth_model: str = "frozen_H"
    tick_duration_mode: str = "config"
    c_tick: float = 1.0
    numeric_eps: float = 1e-300


@dataclass
class MultiAeonParams:
    n_aeons: int = 1
    max_ticks_per_aeon: int | None = None
    inheritance_model: str = "v1_residual_pin"
    inherit_c: float = 1.0
    lambda_reset: str = "reset"
    lambda_scale: float = 1.0
    d_sep_reset: str = "birth"
    d_sep_birth_model: str = "qstar"
    c_d_birth: float = 1.0
    FdS_model: str = "from_split_seed"
    logging_level: str = "minimal"
    save_per_aeon_histories: bool = True
    save_aggregate_history: bool = True

@dataclass
class SimConfig:
    physics: PhysicsConstants
    scenario: ScenarioParams
    leak: LeakParams
    multi_aeon: MultiAeonParams = field(default_factory=MultiAeonParams)
    split_model: SplitModelParams = field(default_factory=SplitModelParams)
    shadow: ShadowParams = field(default_factory=ShadowParams)
    separation: SeparationParams = field(default_factory=SeparationParams)


def enforce_source_hubble(source: SourceParams) -> None:
    """
    Enforce H_src = 1/L4_src. H_src is not treated as an independent parameter.
    """
    if source.L4_src <= 0.0:
        raise ValueError("source.L4_src must be > 0 to derive H_src.")
    source.H_src = 1.0 / source.L4_src


def load_config(config_path: str) -> SimConfig:
    try:
        with open(config_path, 'r') as f:
            config_dict = json.load(f)
    except FileNotFoundError:
        raise FileNotFoundError(f"Config file not found: '{config_path}'")
    except json.JSONDecodeError as e:
        raise json.JSONDecodeError(f"Error decoding JSON: {e.msg}", e.doc, e.pos)

    def _from_dict(data_class, data):
        field_names = {f.name for f in data_class.__dataclass_fields__.values()}
        missing_keys = field_names - data.keys()
        if data_class is SourceParams and "H_src" in missing_keys:
            missing_keys.remove("H_src")
        if missing_keys:
            raise ValueError(f"Missing keys for {data_class.__name__}: {', '.join(missing_keys)}")

        init_data = {}
        for key, f in data_class.__dataclass_fields__.items():
            f_type = f.type
            origin = get_origin(f_type)
            if origin is list:
                item_type = get_args(f_type)[0]
                if hasattr(item_type, '__dataclass_fields__'):
                    init_data[key] = [_from_dict(item_type, item) for item in data.get(key, [])]
                else:
                    init_data[key] = data.get(key, [])
            elif hasattr(f_type, '__dataclass_fields__'):
                init_data[key] = _from_dict(f_type, data[key])
            else:
                if data_class is SourceParams and key == "H_src":
                    init_data[key] = data.get(key, 0.0)
                else:
                    init_data[key] = data[key]
        return data_class(**init_data)

    physics = _from_dict(PhysicsConstants, config_dict['physics'])
    scenario = _from_dict(ScenarioParams, config_dict['scenario'])
    leak = _from_dict(LeakParams, config_dict['leak'])

    multi_aeon = MultiAeonParams()
    if 'multi_aeon' in config_dict:
        multi_aeon = _from_dict(MultiAeonParams, config_dict['multi_aeon'])

    split_model = SplitModelParams()
    if 'split_model' in config_dict:
        split_model = _from_dict(SplitModelParams, config_dict['split_model'])

    shadow = ShadowParams()
    if 'shadow' in config_dict:
        shadow = _from_dict(ShadowParams, config_dict['shadow'])

    separation = SeparationParams()
    if 'separation' in config_dict:
        separation = _from_dict(SeparationParams, config_dict['separation'])

    enforce_source_hubble(scenario.source)
    return SimConfig(physics=physics, scenario=scenario, leak=leak,
                     multi_aeon=multi_aeon, split_model=split_model,
                     shadow=shadow, separation=separation)
