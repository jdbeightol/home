#!/usr/bin/env bash

function cleanup() {
    rm -rf "$WORK_DIR"
}

function dispatch() {
    for f in "$@"; do
        if [ ! -s "$f" ]; then
            # skip empty payloads
            continue
        fi

        echo "dispatching $f..."
        nomad job dispatch "$PARENT" "$f"

        if [ "$?" -eq "1" ]; then
            exit 1
        fi
    done
}

function partition() {
    local source_file=${1:?missing source file}
    local count=${2:?missing split count}
    if [ "$(wc -l "$source_file" | awk '{print $1}')" -le 1 ]; then
        # confirm zero or one-line retries
        echo "file for $JOB has one line or fewer"
        echo
        echo 'contents:'
        echo '---'
        cat "$source_file"
        echo '---'
        echo

        while true; do
            read -n 1 -p "continue? [y/n]: " -r reply
            echo

            case $reply in
            y|Y)
                break
                ;;
            n|N)
                echo 'skipping'
                return 0
                ;;
            *)
                echo 'unrecognized input'
                continue
                ;;
            esac
        done
    fi

    if command -v gsplit &>/dev/null; then
        gsplit --additional-suffix .dat -d -n "l/$count" "$source_file" "$WORK_DIR/part"
        return 0
    fi
    split --additional-suffix .dat -d -n "l/$count" "$source_file" "$WORK_DIR/part"
}

JOB=${1:?missing job}
PARENT="${JOB%%/*}"
SPLIT="${2:-1}"

trap cleanup EXIT

WORK_DIR="$(mktemp -d)"
nomad job inspect "$JOB" | jq --raw-output .Job.Payload | base64 -d | sed -e '/^$/d' > "$WORK_DIR/payload.dat"

if [ "$SPLIT" -eq 1 ]; then
    dispatch "$WORK_DIR/payload.dat"
else
    partition "$WORK_DIR/payload.dat" "$SPLIT"
    dispatch "$WORK_DIR/"part*.dat
fi
