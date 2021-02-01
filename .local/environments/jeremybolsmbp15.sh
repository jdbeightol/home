env::extends macos

eval "`docker-machine env default 2>/dev/null`"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PYTHONPATH="$HOME/.local/python/lib

