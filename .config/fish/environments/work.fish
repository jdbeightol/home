function doevans
    evans -r --tls --cert $MTLS_CLIENT_CERT_FILE_PATH --certkey $MTLS_CLIENT_KEY_FILE_PATH
end

function mine
    jira list -n mine
end

function todo
    echo mine; line
    mine
    echo; echo backlog; line
    jira list -l 10 -n todo
    echo; echo epics; line
    jira list -l 10 -n epics
    echo; echo in-progress epic stories; line
    jira list -n epics-inprogress -t listissueonly | xargs -I{} jira epic ls {} -t list
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
