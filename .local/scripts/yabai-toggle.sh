#!/bin/bash

WIN_WIDTH=4
WIN_HEIGHT=7

function window_spread() {
    local win_ids=("$@")
    local i=2
    local j=1
    for ID in "${WIN_IDS[@]}"; do
        yabai -m window "$ID" --grid 16:16:$i:$j:$WIN_WIDTH:$WIN_HEIGHT
        i=$((i+WIN_WIDTH))
        if [[ $i -gt $((16 - WIN_WIDTH)) ]]; then
            i=0
            j=$((j + WIN_HEIGHT))
        fi
        if [[ $j -gt $((16 - WIN_HEIGHT - 1)) ]]; then
            i=2
            j=1
        fi
    done
}

TYPE=$(yabai -m query --spaces --space | jq --raw-output .type)

case "${TYPE}" in
    bsp)
        yabai -m space --layout stack
    ;;
    *)
        yabai -m space --layout bsp
    ;;
esac

