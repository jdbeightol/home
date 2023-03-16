# Configuration specific to Mac OS X.

# Environment variables used for OSX.
export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH="/usr/local/sbin:$PATH:~/.local/cargo/bin"
export JAVA_HOME="`/usr/libexec/java_home 2>/dev/null`"

# Aliases specific to OSX.
alias ll='ls -lhG'
alias la='ls -alhG'
alias du='du -d 1 -c -h -x'

alias yoink="open -a Yoink"

# Aliases of linux equivalent commands.
alias lsblk='diskutil list'

alias dnsflush='sudo killall -HUP mDNSResponder'

if [[ -f /opt/local/bin/port ]]; then
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi

if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
