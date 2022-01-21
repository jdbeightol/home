function env::init() {
    env::init::echo
    env::init::style
    env::init::ps1
}

function env::init::style() {
    ENV_STYLE="\033[1m\033[3m"
    ENV_COLOR_PRIMARY="\033[36m"
    ENV_COLOR_ACCENT="\033[33m"
    ENV_RESET="\033[0m"
}

function env::init::ps1() {
    ENV_PS1="\[\e[1;31m\][\t]\[\e[0m\] \[\e[1;30m\]\h:\w\[\e[0m\]\n\[\e[0;34m\]\u->\[\e[0m\] "
    ENV_PS1_HOSTNAME='\\h'
    ENV_PS1_CUSTOM=''
}

function env::init::echo() {
    if [ -z "${ENV_ECHO_FILE}" ]; then
        ENV_ECHO_FILE="/tmp/env-echo.$RANDOM"
        trap "rm -f \"${ENV_ECHO_FILE}\"; exit" EXIT
        touch "${ENV_ECHO_FILE}" &>/dev/null
    fi
}

function env::echo::flush() {
    if [ -f "${ENV_ECHO_FILE}" ]; then
        cat "${ENV_ECHO_FILE}"
        rm -f "${ENV_ECHO_FILE}"
        unset ENV_ECHO_FILE &>/dev/null
    fi
}

function env::echo::extends() {
    env::echo -ne " ${ENV_COLOR_ACCENT}>${ENV_COLOR_PRIMARY} $1"
}

function env::echo() {
    if [ -n "${ENV_ECHO_FILE}" ] && [ -f "${ENV_ECHO_FILE}" ]; then
        echo "$@" >> "${ENV_ECHO_FILE}"
    else
        echo "$@"
    fi
}

function env::extends() {
    local parent="$1"
    local parent_file="${HOME}/.local/environments/${parent}.sh"
    if [ -e "${parent_file}" ]; then
        source "${parent_file}"
        env::echo::extends "${parent}"
    fi
}

function env::ps1() {
    echo "${ENV_PS1}" |
        sed -e "s/\\\\h/${ENV_PS1_HOSTNAME}/g" |
        sed -e "s/\\\\w/\\\\w${ENV_PS1_CUSTOM}/g"
}

function env::ps1::set_hostname() {
    ENV_PS1_HOSTNAME="$1"
}

function env::ps1::set_custom() {
    ENV_PS1_CUSTOM="$1"
}

function env::load() {
    env::init
    env::echo -ne "${ENV_STYLE}Configuration hierarchy: ${ENV_COLOR_PRIMARY}profile"

    export ENVIRONMENT=`awk '{split($0,a,"."); print tolower(a[1])}' <<< "$HOSTNAME"`
    if [ -e "${HOME}/.environment" ]; then
        source "${HOME}/.environment"
    fi
    
    if [ ! -e "${HOME}/.local/environments/${ENVIRONMENT}.sh" ]; then
        export ENVIRONMENT="base"
    fi

    env::extends "${ENVIRONMENT}"
    env::echo -e "${ENV_RESET}"
    env::echo::flush
    export PS1="$(env::ps1)"
}

