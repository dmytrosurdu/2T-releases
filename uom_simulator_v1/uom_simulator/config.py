# uom_simulator/config.py

import json
from dataclasses import dataclass

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
    cost_x_factor: float; cL_map_src: float; deltaL_soft_src: float

@dataclass
class ReceiverParams:
    L4_init: float; a_cft_rec: float; m_bullet: float
    v_geom: float; alpha_t: float; alpha_x: float; eta_wall_work: float
    lambda_by: float; lambda_conf: float; lambda_wall: float; cL_map: float
    deltaL_soft: float; deltaL_taper: float;

@dataclass
class AeonRunParams:
    initial_R0_abs: float; initial_Lambda: float; initial_d_sep: float
    Lambda_star: float; max_ticks: int; tick_duration: float
    d_sep_expansion_factor: float; initial_F_dS_factor: float
    beta_factor: float;

@dataclass
class ScenarioParams:
    source: SourceParams
    receiver: ReceiverParams
    aeon: AeonRunParams

@dataclass
class SimConfig:
    physics: PhysicsConstants
    scenario: ScenarioParams


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
        if missing_keys:
            raise ValueError(f"Missing keys for {data_class.__name__}: {', '.join(missing_keys)}")

        init_data = {}
        for key, f in data_class.__dataclass_fields__.items():
            if hasattr(f.type, '__dataclass_fields__'):
                init_data[key] = _from_dict(f.type, data[key])
            else:
                init_data[key] = data[key]
        return data_class(**init_data)

    physics = _from_dict(PhysicsConstants, config_dict['physics'])
    scenario = _from_dict(ScenarioParams, config_dict['scenario'])
    return SimConfig(physics=physics, scenario=scenario)