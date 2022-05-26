#!/bin/bash

TYPE=$(yabai -m query --spaces --space | jq --raw-output .type)

case "${TYPE}" in
    bsp)
        WINS=($(yabai -m query --windows --space | jq '.[].id'))
        yabai -m space --layout float
        for x in "${WINS[@]}"; do 
            yabai -m window $x --grid 16:4:1:1:2:14
        done
    ;;
    float)
        yabai -m space --layout stack
    ;;
    *)
        yabai -m space --layout bsp
    ;;
esac

