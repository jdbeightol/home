#!/usr/bin/env bash

set -e
set -o pipefail

JOB="${1:?missing job}"

nomad job status "$JOB" 2>/dev/null |
    grep 'dispatch-' |
    cut -d \  -f 1 |
    while read a; do
        nomad job inspect "$a" | jq --raw-output .Job.Payload | base64 -d | sed -e '/^$/d'
    done | sort | uniq
