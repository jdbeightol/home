env::require home
env::require darwin

# Configuration specific to Europa
set -x WORKSPACE $HOME/Workspace

# some ansible config unique to europa
set -x ANSIBLE_CONFIG $WORKSPACE/ansible/ansible.cfg
set -x ANSIBLE_INVENTORY $WORKSPACE/ansible/home
set -x ANSIBLE_VAULT_PASSWORD_FILE $HOME/.local/scripts/ansible-password-file.sh
