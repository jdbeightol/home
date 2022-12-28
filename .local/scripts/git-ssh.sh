#!/bin/bash 

if ! [[ "${GIT_ADDR:?GIT_ADDR not set}" =~ ([^:]+://)?([^:/]+)(:([0-9]+))?$ ]]; then
    1>&2 echo "error: failed to extract host and port from GIT_ADDR"
    exit 99
fi

GIT_HOST="${BASH_REMATCH[2]}"

GIT_PORT=22
if [[ -n "${BASH_REMATCH[4]}" ]]; then
    GIT_PORT="${BASH_REMATCH[4]}"
fi

ssh -p "${GIT_PORT}" "${GIT_HOST}"
