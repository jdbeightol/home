#!/bin/bash

find . -name .git | (
    while read repo; do
        (cd "${repo}/.." && pwd && git "$@" && echo)
    done
)
