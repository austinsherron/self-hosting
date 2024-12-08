#!/usr/bin/env bash

set -Eeuo pipefail


ANSIBLE_HOSTS="/etc/ansible/hosts"
SERVER_0="192.168.12.38"

SSH_KEY_PATH="$HOME/.ssh/server_0_id_rsa"
SSH_USER="austin"

function install_ansible() {
    if which ansible &> /dev/null; then
        echo "[INFO] ansible already installed"
    else
        echo "[INFO] installing ansible"
        brew install ansible
    fi
}

function add_default_ssh_config() {
    echo "[INFO] Adding default ssh config"

    cat <<EOF >> ~/.ssh/config
Host *
    ForwardAgent yes
    ServerAliveInterval 60
    ServerAliveCountMax 3
EOF
}

function add_server_ssh_config() {
    echo "[INFO] Adding server ssh config"

    cat <<EOF >> ~/.ssh/config

Host server-0
    HostName $SERVER_0
    User $SSH_USER
    Port 22
    IdentityFile $SSH_KEY_PATH
EOF
}

function update_ssh_config() {
    if [[ -f ~/.ssh/config ]]; then
        echo "[INFO] ~/.ssh/config already exists"
    else
        add_default_ssh_config || return 1
    fi

    if grep -q "Host server-0" ~/.ssh/config; then
        echo "[INFO] host server-0 exists in ~/.ssh/config"
    else
        add_server_ssh_config || return 1
    fi
}

function setup_ssh() {
    if [[ -f "$SSH_KEY_PATH" ]]; then
        echo "[INFO] ssh key at $SSH_KEY_PATH exists"
    else
        echo "[INFO] creating ssh key at $SSH_KEY_PATH"
        ssh-keygen -t rsa -b 4096 -f "$SSH_KEY_PATH"
    fi

    echo "[INFO] copying $SSH_KEY_PATH.pub to $SERVER_0"
    ssh-copy-id -i "$SSH_KEY_PATH.pub" "$SSH_USER@$SERVER_0"

    update_ssh_config || return 1
}

function ansible_hosts_path() {
    echo "$(git rev-parse --show-toplevel)/ansible/hosts"
}

function copy_ansible_hosts() {
    # shellcheck disable=SC2034,SC2155
    local ansible_dir=$(dirname "$ANSIBLE_HOSTS")

    if [[ ! -d "$(dirname ANSIBLE_HOSTS)" ]] ; then
        echo "[INFO] creating $ansible_dir directory"
        sudo mkdir "$ansible_dir"
    else
        echo "[INFO] $ansible_dir directory exists"
    fi

    if ! diff "$(ansible_hosts_path)" "$ANSIBLE_HOSTS"; then
        echo "[INFO] copying $(ansible_hosts_path) to $ANSIBLE_HOSTS"
        sudo cp "$(ansible_hosts_path)" "$ANSIBLE_HOSTS"
    else
        echo "[INFO] $(ansible_hosts_path) == $ANSIBLE_HOSTS"
    fi
}

function playbook_dir() {
    echo "$(git rev-parse --show-toplevel)/bootstrap/playbooks"
}

function run_install_playbooks() {
    echo "[INFO] running installation playbooks"

    for playbook in "$(playbook_dir)/"*.yaml; do
        echo "[INFO] running $(basename "${playbook%%.yaml}")"
        ansible-playbook --ask-become-pass "$playbook"
    done
}

echo "[INFO] bootstrapping darwin"

install_ansible || exit 1
copy_ansible_hosts || exit 1
setup_ssh || exit 1

echo "[INFO] verifying ansible"
ansible all -m ping -i "$ANSIBLE_HOSTS"

run_install_playbooks || exit 1

echo "[INFO] bootstrapping complete"

