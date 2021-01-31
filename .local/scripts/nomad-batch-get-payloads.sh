#!/usr/bin/env bash

set -e
set -o pipefail

JOB="${1:?missing job}"

curl --silent $NOMAD_ADDR/v1/jobs |
    jq --raw-output '.[] |
       select(.Type == "batch") |
       select(.ParentID == "'"$JOB"'") |
       .ID' |
    xargs -I{} curl --silent $NOMAD_ADDR/v1/job/{} |
    jq --raw-output '.Payload' |
    base64 -d |
    sed -e '/^$/d' |
    sort |
    uniq
