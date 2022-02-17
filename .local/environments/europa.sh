env::extends home
env::extends macos

# Configuration specific to Europa
export WORKSPACE="$HOME/Workspace"
export PATH="$PATH:~/.emacs.d/bin"

# some ansible config unique to europa
export ANSIBLE_CONFIG="${WORKSPACE}/ansible/ansible.cfg"
export ANSIBLE_INVENTORY="${WORKSPACE}/ansible/home"
export ANSIBLE_VAULT_PASSWORD_FILE="${HOME}/.local/scripts/ansible-password-file.sh"

#eval "$(starship init bash)"

