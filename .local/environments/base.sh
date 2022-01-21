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

command -v vim &>/dev/null && alias vi='vim'

# Draw a line across the terminal
command -v tput &>/dev/null && alias line='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'

# Alias dotfile config management
alias .f='git --git-dir $HOME/.cfg/ --work-tree $HOME'

# Source the git prompt function and add it into the PS1 if it exists.
if command -v __git_ps1 &>/dev/null; then
    env::ps1::set_custom '$(__git_ps1)'
fi

