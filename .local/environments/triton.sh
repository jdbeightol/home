env::extends work
env::extends macos

# This is Triton.

eval "`docker-machine env default 2>/dev/null`"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="$PATH:~/.emacs.d/bin"
export PYTHONPATH="$HOME/.local/lib/python"

env::prompt::set_hostname Triton

