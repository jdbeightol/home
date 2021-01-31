#!/usr/bin/env bash

set -e
set -o pipefail

JOB="${1:?missing job}"

curl --silent $NOMAD_ADDR/v1/jobs |
    jq --raw-output '
       .[] |
       select(.Type == "batch") |
       select(.Status == "dead") |
       select(.ParentID == "'"$JOB"'") |
       select(.JobSummary.Summary.[].Complete > 0) |
       .ID' |
    xargs -n 32 nomad job stop -purge
