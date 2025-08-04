#!/usr/bin/env bash

set -e
set -o pipefail

JOB="${1:?missing job}"

nomad job status "$JOB" 2>/dev/null |
    grep 'dead' |
    cut -d \  -f 1 |
    xargs -n 1 nomad job status -json |
    jq --raw-output '.[]|select(.Summary.Summary[].Complete > 0)|.Summary.JobID' |
    xargs -n 32 nomad job stop -purge
