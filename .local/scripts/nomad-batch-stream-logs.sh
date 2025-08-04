#!/usr/bin/env bash
#shellcheck disable=SC2046

JOB="${1:?missing job}"

MY_DIR="$(mktemp -d)"

cleanup() {
    kill $(jobs -p)
    rm -rf "$MY_DIR"
}

trap cleanup EXIT

nomad job status "$JOB" 2>/dev/null | grep -e '/\(periodic\|dispatch\)-' > "$MY_DIR/jobs"

if [ ! -s "$MY_DIR/jobs" ]; then
    1>&2 echo 'no jobs found'
    exit 0
fi

# avoid subshells here, so we don't fuck with job control; pipes are subshells
while read -r a b; do
    nomad alloc logs -f -job "$a" &
done < "$MY_DIR/jobs"

wait $(jobs -p)
