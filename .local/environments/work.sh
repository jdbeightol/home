env::extends base

export GOPRIVATE='*.internal.digitalocean.com,github.com/digitalocean'
export VAULT_ADDR="https://vault-api.internal.digitalocean.com:8200"
export MTLS_CLIENT_KEY_FILE_PATH="/Users/jbeightol/.local/ssl/jbeightol.staff.digitalocean.com.key"
export MTLS_CLIENT_CERT_FILE_PATH="/Users/jbeightol/.local/ssl/jbeightol.staff.digitalocean.com.crt"

# This needs to be executed after the CTHLUHU environment setup
export WORKSPACE_DIR="${CTHULHU_DIR}"

alias pb='pinboard'
alias orca2='evans -r --tls --cert ~/jbeightol.staff.digitalocean.com.crt --certkey ~/jbeightol.staff.digitalocean.com.key repl'
alias orca2-metal='orca2 --servername placement-services.internal.digitalocean.com'
alias orca2-stage='orca2 --servername orca2-stage2.internal.digitalocean.com'
alias explain='go run "$HOME/Workspace/cthulhu/docode/src/do/teams/compute/orca2/cmd/explainer/"'
alias mine='jira list -n mine'
alias todo='
echo backlog; line
jira list -l 10 -n todo -p Orca
echo; echo epics; line;
jira list -l 10 -n epics -p Orca
echo; echo in-progress epic stories; line;
jira list -n epics-inprogress -p Orca -t listissueonly | xargs -I{} jira epic ls {} -t list'
alias j='jira'
alias flipperctl='docker run --rm docker.internal.digitalocean.com/compute/flipperctl'
alias pull='git fetch; git gc --prune=now; git pull'

alias dote-clean-stage2='dote list on stage2 | cut -d \  -f 1 | tail -n +2 | xargs -I {} dote destroy {} on stage2'
alias dote-clean-production='dote list on production | cut -d \  -f 1 | tail -n +2 | xargs -I {} dote destroy {} on production'

[ -f ~/.local/scripts/vault-auth.sh ] && source ~/.local/scripts/vault-auth.sh

