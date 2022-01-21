#!/bin/bash -e

REPO="https://github.com/jdbeightol/home.git"
GIT_DIR="${HOME}/.cfg"

# Check for required packages, failures will cause the script to exit when running bash with -e
echo "Checking for required packages..."
command -v git

echo "Cloning repository..."

git clone --bare "${REPO}" "${GIT_DIR}"

echo "Forcing checkout..."

git --git-dir "${GIT_DIR}" --work-tree "${HOME}" checkout -f

echo "Hiding untracked files..."

git --git-dir "${GIT_DIR}" --work-tree "${HOME}" config --local status.showUntrackedFiles no

echo "Updating submodules..."

git --git-dir "${GIT_DIR}" --work-tree "${HOME}" submodule update --init

echo "Complete.  See aliases below for help."

alias .f

