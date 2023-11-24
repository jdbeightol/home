#!/usr/bin/env python3

#import json
import yaml
import os
import argparse
import random


parser = argparse.ArgumentParser(description='random meal picker')
parser.add_argument('count', type=int, help='count of meals to pick')
parser.add_argument('tags', nargs='*', help='optional tags to require; negate a tag by prefixing it with !')
args = parser.parse_args()

food_file = os.path.join(os.environ["HOME"], ".food.yaml")
if not os.path.exists(food_file):
    food_file = os.path.join(os.environ["HOME"], ".food.yml")
if not os.path.exists(food_file):
    food_file = os.path.join(os.environ["HOME"], ".food.json")

food = []
with open(food_file, "r") as f:
    food = yaml.safe_load(f)

if len(args.tags) > 0:
    for tag in args.tags:
        food = [
            f
            for f in food
            if 'tags' not in f or tag[1:] not in f['tags']
        ] if tag.startswith('!') else [
            f
            for f in food
            if 'tags' in f and tag in f['tags']
        ]

pos_set = []
for i in range(args.count):
    if len(pos_set) == len(food):
        break

    pos = random.randint(0, len(food) - 1)
    while pos in pos_set:
        pos = random.randint(0, len(food) - 1)
    pos_set.append(pos)

    print(food[pos]['name'])
