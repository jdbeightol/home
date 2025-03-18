### Global Configuration

export PATH="$PATH:$HOME/.local/bin"
export EDITOR="vi"
export ANSIBLE_NOCOWS=1
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Set common aliases
alias df='df -h'
alias du='du --max-depth=1 -c -h -x' 
alias grep='grep --color=auto -n'
alias emacs='emacs -nw'

alias icat="kitty +kitten icat"

# Always override vi with vim
command -v vim &>/dev/null && alias vi='vim'

# Draw a line across the terminal
command -v tput &>/dev/null && alias line='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'

# Alias dotfile config management
alias .f='git --git-dir $HOME/.cfg/ --work-tree $HOME'

# Source the git prompt function and add it into the PS1 if it exists.
if command -v __git_ps1 &>/dev/null; then
    env::prompt::set_git_prompt '$(__git_ps1)'
fi

export GPG_TTY=$(tty)

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi
