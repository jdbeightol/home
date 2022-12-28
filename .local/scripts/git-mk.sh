#!/bin/bash 

repo=${1:?missing repo name}
readonly repo

if ! git rev-parse HEAD &>/dev/null; then
    1>&2 echo 'error: not an established git repository'
    exit 1
fi

if [[ -n "$(git remote get-url origin 2>/dev/null)" ]]; then
    1>&2 echo 'error: remote origin already exists'
    exit 2
fi

git remote add origin "${GIT_ADDR:?GIT_ADDR not set}/${repo}"
git push -u origin master
