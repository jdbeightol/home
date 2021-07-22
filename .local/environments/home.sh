env::extends base

if [ "$(date +%m%d)" == "0401" ]; then
    if [ -n `which sl 2>/dev/null` ]; then sl; echo; fi
    clear
    echo 'Microsoft Windows XP [Version 5.1.2600]'
    echo 'Copyright (c) 1985-2001 Microsoft Corp.'
    PS1='C:\\\\\W\>'
else
    # Display a fortune if installed.
    which fortune &>/dev/null && { echo; fortune && echo; }
fi

export GOPATH="$HOME/.local/go"
export WORKSPACE_DIR="${HOME}/Workspace"

