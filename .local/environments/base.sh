### Global Configuration

export PATH="$PATH:$HOME/.local/bin"
export EDITOR="vi"
export ANSIBLE_NOCOWS=1
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Set common aliases
alias df='df -h'
alias du='du --max-depth=1 -c -h -x' 
alias curlj='curl -H "Content-type: application/json"'
alias grep='grep --color=auto -n'
alias letters='sed "s/\(.\)./\1/g" <<< '
alias emacs='emacs -nw'

which vim &>/dev/null && alias vi='vim'

alias line='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'

# Source the git prompt function and add it into the PS1 if it exists.
if [ -f "/etc/bash_completion.d/git" ]; then
    source /etc/bash_completion.d/git

    export PS1="\[\e[1;31m\][\t]\[\e[0m\] \[\e[1;30m\]\H:\w\$(__git_ps1)\[\e[0m\]\n\[\e[0;34m\]\u->\[\e[0m\] "
fi

