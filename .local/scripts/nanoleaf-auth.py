#!/usr/bin/env python3

import argparse
import json
import os
import sys
import yaml

from nanoleafapi import Nanoleaf

home = os.path.expanduser('~')
parser = argparse.ArgumentParser(description='nanoleaf auth token generator')
parser.add_argument('--config', '-c', default=os.path.join(home, '.nanoleaf.yml'), help='configuration file location')
args = parser.parse_args()


with open(args.config) as f:
    cfg = yaml.safe_load(f)

nl=Nanoleaf(ip=cfg['ip'])
auth = nl.get_auth_token()

if 'token' in cfg and cfg['token'] == auth:
    sys.exit(0)

cfg['token'] = auth

with open(args.config, 'w') as f:
    yaml.dump(cfg, f)
