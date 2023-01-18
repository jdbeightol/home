#!/usr/bin/env python3

import argparse
import json
import sys
import yaml

from nanoleafapi import Nanoleaf

parser = argparse.ArgumentParser(description='nanoleaf effect changer')
parser.add_argument('--config', '-c', default='/Users/jbeightol/.nanoleaf.yml', help='configuration file location')
args = parser.parse_args()


with open(args.config) as f:
    cfg = yaml.safe_load(f)

nl=Nanoleaf(ip=cfg['ip'])
auth = nl.get_auth_token()

if cfg['token'] == auth:
    sys.exit(0)

cfg['token'] = auth

with open(config_file, 'w') as f:
    yaml.dump(cfg, f)
