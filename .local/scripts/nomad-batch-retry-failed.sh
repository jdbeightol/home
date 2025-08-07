#!/usr/bin/env bash

set -e
set -o pipefail

JOB="${1:?missing job}"

JOBS=$(curl --silent $NOMAD_ADDR/v1/jobs |
    jq --raw-output '
       .[] |
       select(.Type == "batch") |
       select(.Status == "dead") |
       select(.ParentID == "'"$JOB"'") |
       select(.JobSummary.Summary.[].Complete == 0 and .JobSummary.Summary.[].Failed > 0) |
       .ID')

for j in $JOBS; do
    nomad-batch-retry-job "$j" 8
    nomad job stop -purge "$j"
done
