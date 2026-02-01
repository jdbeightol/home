env::extends base

if [ "$(date +%m%d)" == "0401" ]; then
    if [ -n `command -v sl 2>/dev/null` ]; then sl; echo; fi
    clear
    echo 'Microsoft Windows XP [Version 5.1.2600]'
    echo 'Copyright (c) 1985-2001 Microsoft Corp.'
    env::prompt::set_literal 'C:\\\W>'
else
    # Display a fortune if installed.
    command -v fortune &>/dev/null && { echo; fortune && echo; }
fi

export GOPATH="$HOME/.local/go"
export WORKSPACE_DIR="${HOME}/Workspace"

export GIT_ADDR="ssh://git.service.saturn.consul:2222"
export NOMAD_ADDR="http://nomad.service.saturn.consul:4646"
export CONSUL_HTTP_ADDR="http://mimas.saturn.sol:8500"

export VAULT_ADDR="http://vault.uranus.sol/"

alias list="
dig @10.12.13.2 pluto.sol axfr |
    \grep -E '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' |
    \grep -v ';' | sed -e 's/\(^[0-9A-Za-z.\-]*\.pluto\.sol\)\..*$/\1/' |
    sort |
    uniq
"
