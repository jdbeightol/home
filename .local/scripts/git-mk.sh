#!/bin/bash

repo=${1:?missing repo name}
readonly repo

if [[ -n "$(git remote get-url origin)" ]]; then
    1>&2 echo 'error: remote origin already exists'
    exit 1
fi

git remote add origin "${GITADDR:?GITADDR not set}/${repo}"
git push -u origin master
