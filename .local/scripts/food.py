#!/usr/bin/env python3

import json
import os
import argparse
import random


parser = argparse.ArgumentParser(
                    prog='ProgramName',
                    description='What the program does',
                    epilog='Text at the bottom of help')
parser.add_argument('count', type=int, help='count of meals to pick')
parser.add_argument('tags', nargs='*', help='optional tags to require')
args = parser.parse_args()

food_file = os.path.join(os.environ["HOME"], ".food.json")

with open(food_file, "r") as f:
    food = json.load(f)

if len(args.tags) > 0:
    for tag in args.tags:
        food = [f for f in food if 'tags' in f and tag in f['tags']]

pos_set = []
for i in range(args.count):
    if len(pos_set) == len(food):
        break

    pos = random.randint(0, len(food) - 1)
    while pos in pos_set:
        pos = random.randint(0, len(food) - 1)
    pos_set.append(pos)

    print(food[pos]['name'])
