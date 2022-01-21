# Check if bash_profile has already been sourced.

[ -n "${BASH_PROFILE_SOURCED}" ] && return 0
export BASH_PROFILE_SOURCED=1

# Basic Configuration
alias ll='ls -lh'
alias la='ll -a'

# Set an initial shell prompt for bash. This should get overwritten later, but we want to make sure it is set in all cases.
export PS1="\[\e[1;31m\][\t]\[\e[0m\] \[\e[1;30m\]\h:\w\[\e[0m\]\n\[\e[0;34m\]\u->\[\e[0m\] "

case "$-" in
    *i*)
        if [ -n "${BASH}" ]; then
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

