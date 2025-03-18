#!/usr/bin/env sh

# home configuration initialization script
#
# curl-bash snippet for easy copy & paste:
#
#   curl --silent "https://github.com/jdbeightol/home/blob/master/.local/scripts/init.sh" | bash
#

set -e

REPO="https://github.com/jdbeightol/home.git"
GIT_DIR="${HOME}/.cfg"

# check for required packages, a failure will cause the script to exit when running sh with -e
echo "checking for required packages..."
command -v git 1>&2 2>/dev/null

echo "cloning repository..."
git clone --bare "${REPO}" "${GIT_DIR}"

echo "forcing checkout..."
git --git-dir "${GIT_DIR}" --work-tree "${HOME}" checkout -f

echo "hiding untracked files..."
git --git-dir "${GIT_DIR}" --work-tree "${HOME}" config --local status.showUntrackedFiles no

echo "updating submodules..."
git --git-dir "${GIT_DIR}" --work-tree "${HOME}" submodule update --init

echo "home initialization complete!"
