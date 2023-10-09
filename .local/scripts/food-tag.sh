#!/bin/bash

readonly FOOD_FILE="$HOME/.food.json"

readonly name="${1:?missing name}"
shift
readonly tags=($@)

for tag in "${tags[@]}"; do
    jq 'map((select(.name == "'"$name"'") | .tags) += ["'"$tag"'"])' "${FOOD_FILE}" > "${FOOD_FILE}"
done
