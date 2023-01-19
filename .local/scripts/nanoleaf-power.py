#!/usr/bin/env python3

import argparse
import json
import os
import sys
import yaml

from nanoleafapi import Nanoleaf

home = os.path.expanduser('~')
parser = argparse.ArgumentParser(description='nanoleaf power toggle')
parser.add_argument('--config', '-c', default=os.path.join(home, '.nanoleaf.yml'), help='configuration file location')
args = parser.parse_args()

with open(args.config) as f:
    cfg = yaml.safe_load(f)

nl=Nanoleaf(ip=cfg['ip'], auth_token=cfg['token'] if 'token' in cfg else None)
nl.toggle_power()
