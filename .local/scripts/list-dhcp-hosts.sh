#!/bin/bash

COLS=80
which tput 1>/dev/null 2>&1 && COLS=$(tput cols)
[[ $COLS -lt 55 ]] && COLS=55

printf "%-$((COLS-20))s%20s\n" "Hostname" "IP Address"

echo $(printf "%$((COLS))s" "" | tr ' ' '-')

dig axfr @10.12.13.2 pluto.sol \
    | grep 'IN[^A-Z]*A' \
    | awk "{ printf "'"'"%-$((COLS-20))s%20s\n"'"'', substr($1, 0, length($1) - 1), $5 }' \
    | sort
