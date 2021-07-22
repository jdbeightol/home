env::extends work
env::extends macos

# This is Triton.

eval "`docker-machine env default 2>/dev/null`"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="$PATH:~/.emacs.d/bin"
export PYTHONPATH="$HOME/.local/lib/python"

# this seems to break vim's syntax highlighting, so leave this line last
export PS1="`sed -e 's/\\\\h/Triton/g' <<< \"$PS1\"`"

