#!/bin/bash

readonly FOOD_FILE="$HOME/.food.json"

readonly name="${1:?missing name}"

jq '.+=[{"name": "'"$name"'"}]' "${FOOD_FILE}" > "${FOOD_FILE}"
