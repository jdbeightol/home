
# Basic Configuration
alias ll='ls -lh'
alias la='ll -a'

# Set custom shell prompt for bash.
export PS1="\[\e[1;31m\][\t]\[\e[0m\] \[\e[1;30m\]\h:\w\[\e[0m\]\n\[\e[0;34m\]\u->\[\e[0m\] "

case "$-" in
    *i*)
        if [ "${BASH}" == "/bin/bash" ] || [ "${BASH}" == "/usr/bin/bash" ]; then
            # Load any files from a user's profile.d directory.
            if [[ -d "${HOME}/.local/profile.d" ]]; then
                for PROFILE_FILE in "${HOME}/.local/profile.d/"*; do
                    if [[ "${PROFILE_FILE}" != "${HOME}/.local/profile.d/*" ]]; then
                        source "${PROFILE_FILE}"
                    fi
                done
            fi

            # Attempt to load environment-based configuration if supported.
            declare -F env::load &>/dev/null && env::load
        fi
    ;;
esac
if [ -e /Users/jbeightol/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jbeightol/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
