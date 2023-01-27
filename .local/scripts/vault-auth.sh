#!/bin/bash

VAULT_CACHE_FILE="${HOME}/.vault-auth"

[[ -f "${VAULT_CACHE_FILE}" ]] && source "${VAULT_CACHE_FILE}"

function vault::auth() {
    local date=$(date +%s)
    local expire=72000

    # Check if the expiration is either empty or if we are after the expiration period
    if [[ -n "${VAULT_EXPIRE}" ]] && [[ ${date} -lt ${VAULT_EXPIRE} ]]; then
        1>&2 echo "using cached credentials..."
        return
    fi

    local token="$(vault login -method=oidc -path=oidc-okta -token-only username=$USER)"

    if [[ -z "${token}" ]]; then
        1>&2 echo "returning: no token available"
        # We don't want to set or write anything if there was an error
        return
    fi

    1>&2 echo "success: setting token and updating cache"

    export VAULT_TOKEN="${token}"
    export VAULT_EXPIRE="$((date + expire))"

    # Cache our new vault token and expiration date as a environment variables
    vault::cache
}

function vault::cache() {
    cat > "${VAULT_CACHE_FILE}" << EOF
export VAULT_TOKEN=${VAULT_TOKEN}
export VAULT_EXPIRE=${VAULT_EXPIRE}
EOF
    chmod 600 "${VAULT_CACHE_FILE}"
}

alias vault-auth="vault::auth"
alias vauth="vault::auth"
