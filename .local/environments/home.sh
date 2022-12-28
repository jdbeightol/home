env::extends base

if [ "$(date +%m%d)" == "0401" ]; then
    if [ -n `command -v sl 2>/dev/null` ]; then sl; echo; fi
    clear
    echo 'Microsoft Windows XP [Version 5.1.2600]'
    echo 'Copyright (c) 1985-2001 Microsoft Corp.'
    PS1='C:\\\\\W\>'
else
    # Display a fortune if installed.
    command -v fortune &>/dev/null && { echo; fortune && echo; }
fi

export GITADDR="ssh://git.service.saturn.consul:2222"
export GOPATH="$HOME/.local/go"
export WORKSPACE_DIR="${HOME}/Workspace"

export NOMAD_ADDR="http://mimas.saturn.sol:4646"
export CONSUL_HTTP_ADDR="http://mimas.saturn.sol:8500"
