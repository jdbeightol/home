#!/bin/bash

TYPE=$(yabai -m query --spaces --space | jq --raw-output .type)

case "${TYPE}" in
    bsp)
        WIN_IDS=($(yabai -m query --windows --space | jq '.[].id'))
        yabai -m space --layout float
        for ID in "${WIN_IDS[@]}"; do 
            yabai -m window "$ID" --grid 16:4:1:1:2:14
        done
    ;;
    float)
        yabai -m space --layout stack
    ;;
    *)
        yabai -m space --layout bsp
    ;;
esac

