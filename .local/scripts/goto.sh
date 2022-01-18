#!/bin/bash

# goto depends on fzf, so don't load if it's not present
command -v fzf 2>&1 1>/dev/null || ( echo 'the goto alias requires fzf to run'; return 1 )

GOTO_CACHE_FILE="${HOME}/.goto"

function goto::cache() {
    \grep "${@}$" "${GOTO_CACHE_FILE}" 1>/dev/null 2>&1 ||
        (
            1>&2 echo -n 'discovered' &&
            echo "${@}" >> "${GOTO_CACHE_FILE}"
        )
}

function goto::cd() {
    goto::cache "${@}"
    1>&2 echo " -> ${@}"
    cd "${@}"
}

function goto::dump() {
    rm -v "r${GOTO_CACHE_FILE}"
}

function goto::find() {
    (
        \grep "${@}\$" "${GOTO_CACHE_FILE}" 2>/dev/null &&
            1>&2 echo -n 'cached'
    ) ||
        (
            1>&2 echo -n 'searching... ' 
            \find "${WORKSPACE_DIR}" -type d -name "$@" -not -path '*/.git/*' 
        )
}

function goto::which() {
    DIRS=("${@}")
    1>&2 echo -n "which? "
    for d in "${DIRS[@]}"; do
        echo "$d"
    done | fzf
}

function goto::command::gc() {
    \cat "${GOTO_CACHE_FILE}" | 
        while read line; do
            [[ -d "$line" ]] || (
                1>&2 echo "pruning ${line}"
                \sed -i '' -e "\|${line}/|d" "${GOTO_CACHE_FILE}" || echo 'oops' 
            )
        done
}

function goto::command::purge() {
    \rm "${GOTO_CACHE_FILE}"
}

function goto {
    declare -F "goto::command::$1" >/dev/null && (
        CMD="$1"
        shift 1
        echo "executing ${CMD}..."
        "goto::command::${CMD}" "$@"
        return 0
    ) && return

    DIRS=($(goto::find "$@"))

    if [[ "${#DIRS[@]}" -eq 0 ]]; then
        1>&2 echo "not found"
        return
    fi

    DIR="${DIRS}"
    if [[ "${#DIRS[@]}" -gt 1 ]]; then
        DIR=$(goto::which "${DIRS[@]}")
    fi
    
    if [[ "${DIR}" == "" ]]; then
        1>&2 echo "canceled"
        return
    fi

    goto::cd "${DIR}"
}

alias g2='goto'

