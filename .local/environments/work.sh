env::extends base


export GOPRIVATE='*.internal.digitalocean.com,github.com/digitalocean'
export VAULT_ADDR="https://vault-api.internal.digitalocean.com:8200"
export MTLS_CLIENT_KEY_FILE_PATH="/Users/jbeightol/jbeightol.staff.digitalocean.com.key"
export MTLS_CLIENT_CERT_FILE_PATH="/Users/jbeightol/jbeightol.staff.digitalocean.com.crt"

[[ -f "${HOME}/.vauth" ]] && source "${HOME}/.vauth"

alias pb='pinboard'
alias orca2='evans -r --tls --cert ~/jbeightol.staff.digitalocean.com.crt --certkey ~/jbeightol.staff.digitalocean.com.key repl'
alias orca2-metal='orca2 --servername placement-services.internal.digitalocean.com'
alias orca2-stage='orca2 --servername orca2-stage2.internal.digitalocean.com'
alias explain='go run "$HOME/Workspace/cthulhu/docode/src/do/teams/compute/orca2/cmd/explainer/"'
alias mine='jira list -n mine'
alias todo='jira list -l 10 -n todo -p Orca'
alias j='jira'
alias flipperctl='docker run --rm docker.internal.digitalocean.com/compute/flipperctl'

alias dote-clean-stage2='dote list on stage2 | cut -d \  -f 1 | tail -n +2 | xargs -I {} dote destroy {} on stage2'
alias dote-clean-production='dote list on production | cut -d \  -f 1 | tail -n +2 | xargs -I {} dote destroy {} on production'

function vauth() {
    local date=$(date +%s)
    local expire=72000

    if [[ -z "${VAULT_EXPIRE}" ]] || [[ ${date} -ge ${VAULT_EXPIRE} ]]; then
        export VAULT_TOKEN="$(vault login -method=okta -token-only username=$USER)"
        export VAULT_EXPIRE="$((date + expire))"

    cat > "${HOME}/.vauth" << EOF
export VAULT_TOKEN=${VAULT_TOKEN}
export VAULT_EXPIRE=${VAULT_EXPIRE}
EOF
    else
        1>&2 echo "using cached credentials..."
    fi
}

