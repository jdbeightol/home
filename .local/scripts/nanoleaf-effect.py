#!/usr/bin/env python3


import argparse
import json
import os
import sys
import yaml

from nanoleafapi import Nanoleaf

home = os.path.expanduser('~')
parser = argparse.ArgumentParser(description='nanoleaf effect changer')
parser.add_argument('effect', nargs='?', help='name of the effect to use')
parser.add_argument('--config', '-c', default=os.path.join(home, '.nanoleaf.yml'), help='configuration file location')
args = parser.parse_args()


with open(args.config) as f:
    cfg = yaml.safe_load(f)

nl=Nanoleaf(ip=cfg['ip'], auth_token=cfg['token'] if 'token' in cfg else None)

if args.effect == None:
    print(json.dumps({
        "items": [{
            "title": i,
            "arg": i,
            "match": i.lower(),
            "autocomplete": i.lower(),
            "subtitle": "Set {} effect on {}".format(i, nl.get_name()),
        } for i in nl.list_effects()],
    }))
    sys.exit(0)

nl.set_effect(args.effect)
