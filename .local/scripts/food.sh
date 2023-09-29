#!/bin/bash

readonly num="${1:?missing number of meals}"

shuf -n $num ~/.food
