#!/usr/bin/env sh

# home configuration initialization script
#
# curl-sh snippet for easy copy & paste:
#
#   curl --silent "https://raw.githubusercontent.com/jdbeightol/home/refs/heads/master/.local/scripts/init.sh" | sh
#

set -e

REPO="https://github.com/jdbeightol/home.git"
GIT_DIR="${HOME}/.cfg"

# check for required packages, a failure will cause the script to exit when running sh with -e
echo "checking for required packages..."
command -v git

echo "cloning repository..."
git clone --bare "${REPO}" "${GIT_DIR}"

echo "forcing checkout..."
git --git-dir "${GIT_DIR}" --work-tree "${HOME}" checkout -f

echo "hiding untracked files..."
git --git-dir "${GIT_DIR}" --work-tree "${HOME}" config --local status.showUntrackedFiles no

echo "updating submodules..."
git --git-dir "${GIT_DIR}" --work-tree "${HOME}" submodule update --init

echo "home initialization complete!"
