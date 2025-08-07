#!/usr/bin/env bash
#shellcheck disable=SC2046

JOB="${1:?missing job}"

JOBS=$(curl --silent $NOMAD_ADDR/v1/jobs |
    jq --raw-output '
       .[] |
       select(.Type == "batch") |
       select(.Status == "running") |
       select(.ParentID == "'"$JOB"'") |
       .ID')

if [ -z "$JOBS" ]; then
    1>&2 echo 'no jobs found'
    exit 0
fi

# avoid subshells here, so we don't fuck with job control; pipes are subshells
for j in $JOBS; do
    nomad alloc logs -f -job "$j" &
done

wait $(jobs -p)
