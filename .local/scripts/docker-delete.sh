#!/bin/bash

FILES=(
    "/Applications/Docker.app"
    "/Library/PrivilegedHelperTools/com.docker.vmnetd"
    "/Library/LaunchDaemons/com.docker.vmnetd.plist"
    "/usr/local/lib/docker"
    "$HOME/.docker"
    "$HOME/Library/Application Support/Docker Desktop"
    "$HOME/Library/Preferences/com.docker.docker.plist"
    "$HOME/Library/Saved Application State/com.electron.docker-frontend.savedState"
    "$HOME/Library/Group Containers/group.com.docker"
    "$HOME/Library/Logs/Docker Desktop"
    "$HOME/Library/Preferences/com.electron.docker-frontend.plist"
    "$HOME/Library/Cookies/com.docker.docker.binarycookies"
)

stat "${FILES[@]}" 2>/dev/null

echo -n "Are you sure that you want to remove the above files? [yes/no] "

read answer

if [[ "$answer" != "yes" ]]; then
    echo 'Aborted.  Only "yes" will be accepted.'
    exit 0
fi

sudo rm -rvf "${FILES[@]}"

echo "It has been done..."

