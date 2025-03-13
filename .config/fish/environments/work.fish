function j
    jira $argv
end

function dote-clean-stage2
    dote list on stage2 | cut -d \  -f 1 | tail -n +2 | xargs -I {} dote destroy {} on stage2
end

function dote-clean-production
    dote list on production | cut -d \  -f 1 | tail -n +2 | xargs -I {} dote destroy {} on production
end

set -gx GOPRIVATE \*.internal.digitalocean.com,github.com/digitalocean
set -gx GOPATH $HOME/.go
set -gx CTHULHU_DIR $HOME/Workspace/cthulhu/
set -gx VAULT_ADDR 'https://vault-api.internal.digitalocean.com:8200'
set -gx MTLS_CLIENT_KEY_FILE_PATH $HOME/.local/ssl/jbeightol.staff.digitalocean.com.key
set -gx MTLS_CLIENT_CERT_FILE_PATH $HOME/.local/ssl/jbeightol.staff.digitalocean.com.crt
set -gx DOCKER_DEFAULT_PLATFORM linux/amd64
set -gx ANSIBLE_PYTHON_INTERPRETER auto_silent

fish_add_path -ga $HOME/.cargo/bin
