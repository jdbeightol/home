function doevans
    evans -r --tls --cert $MTLS_CLIENT_CERT_FILE_PATH --certkey $MTLS_CLIENT_KEY_FILE_PATH
end

function mine
    jira issue list --plain -a $USER@digitalocean.com -s open -s in\ progress -s todo
end

function todo
    echo my issues; line
    mine
    echo; echo top of backlog; line
    jira issue list --plain --paginate 10 -s open
    echo; echo open epics; line
    jira epic list --table --plain -s open -s in\ progress
end

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
set -gx VAULT_ADDR 'https://vault-api.internal.digitalocean.com:8200'
set -gx MTLS_CLIENT_KEY_FILE_PATH $HOME/.local/ssl/jbeightol.staff.digitalocean.com.key
set -gx MTLS_CLIENT_CERT_FILE_PATH $HOME/.local/ssl/jbeightol.staff.digitalocean.com.crt

fish_add_path -ga $HOME/.cargo/bin

alias python python3.11
alias python3 python3.11
