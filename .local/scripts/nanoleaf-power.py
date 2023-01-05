#!/usr/bin/env python3

import yaml
from nanoleafapi import Nanoleaf

config_file = "/Users/jbeightol/.nanoleaf.yml"

with open(config_file) as f:
    cfg = yaml.safe_load(f)

nl=Nanoleaf(ip=cfg['ip'], auth_token=cfg['token'] if 'token' in cfg else None)
nl.toggle_power()
