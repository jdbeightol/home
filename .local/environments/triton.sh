env::extends work
env::extends macos

# This is Triton.

eval "`docker-machine env default 2>/dev/null`"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="$PATH:~/.emacs.d/bin"
export PYTHONPATH="$HOME/.local/lib/python"
#export PS1="\[\e[1;31m\][\t]\[\e[0m\] \[\e[1;30m\]Triton:\w\$(__git_ps1)\[\e[0m\]\n\[\e[0;34m\]\u->\[\e[0m\] "
export PS1="`sed -e 's/\\\\h/Triton/g' <<< "$PS1"`"

