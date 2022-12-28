#!/bin/bash 

repo=${1:?missing repo name}
readonly repo

if [[ -z "$(git rev-parse HEAD)" ]]; then
    exit 1
fi

if [[ -n "$(git remote get-url origin 2>/dev/null)" ]]; then
    1>&2 echo 'error: remote origin already exists'
    exit 2
fi

git remote add origin "${GITADDR:?GITADDR not set}/${repo}"
git push -u origin master
