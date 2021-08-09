# Configuration specific to Mac OS X.

# Environment variables used for OSX.
export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH="/usr/local/sbin:$PATH"
export JAVA_HOME="`/usr/libexec/java_home 2>/dev/null`"

# Aliases specific to OSX.
alias ll='ls -lhG'
alias la='ls -alhG'
alias du='du -d 1 -c -h -x'
alias find='find .'

# Aliases of linux equivalent commands.
alias lsblk='diskutil list'

alias dnsflush='sudo killall -HUP mDNSResponder'

# Source the git prompt function and add it into the PS1 if it exists.
if [ -f "/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh" ]; then
    source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh

    export PS1="\[\e[1;31m\][\t]\[\e[0m\] \[\e[1;30m\]\h:\w\$(__git_ps1)\[\e[0m\]\n\[\e[0;34m\]\u->\[\e[0m\] "
fi

if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

