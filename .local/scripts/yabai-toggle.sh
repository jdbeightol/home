#!/bin/bash

TYPE=$(yabai -m query --spaces --space | jq --raw-output .type)

case "${TYPE}" in
    bsp)
        TYPE=float
    ;;
    float)
        TYPE=stack
    ;;
    *)
        TYPE=bsp
    ;;
esac

yabai -m space --layout "${TYPE}"
