env::extends base

export GOPRIVATE='*.internal.digitalocean.com,github.com/digitalocean'
export VAULT_ADDR="https://vault-api.internal.digitalocean.com:8200"
export MTLS_CLIENT_KEY_FILE_PATH="/Users/jbeightol/.local/ssl/jbeightol.staff.digitalocean.com.key"
export MTLS_CLIENT_CERT_FILE_PATH="/Users/jbeightol/.local/ssl/jbeightol.staff.digitalocean.com.crt"

# This needs to be executed after the CTHLUHU environment setup
export WORKSPACE_DIR="${CTHULHU_DIR}"

export PATH="${PATH}:${HOME}/.cargo/bin"

alias j='jira'

alias dote-clean-stage2='dote list on stage2 | cut -d \  -f 1 | tail -n +2 | xargs -I {} dote destroy {} on stage2'
alias dote-clean-production='dote list on production | cut -d \  -f 1 | tail -n +2 | xargs -I {} dote destroy {} on production'

[ -f ~/.local/scripts/vault-auth.sh ] && source ~/.local/scripts/vault-auth.sh

