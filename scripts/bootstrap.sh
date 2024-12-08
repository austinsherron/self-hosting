#!/usr/bin/env bash

set -Eeuo pipefail


ANSIBLE_HOSTS="/etc/ansible/hosts"
SSH_KEY_PATH="$HOME/.ssh/server_0_id_rsa"
SERVER_0="192.168.12.38"

function os_type() {
    uname | tr '[:upper:]' '[:lower:]'
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

function setup_ssh() {
    if [[ -f "$SSH_KEY_PATH" ]]; then
        echo "[INFO] ssh key at $SSH_KEY_PATH exists"
    else
        echo "[INFO] creating ssh key at $SSH_KEY_PATH"
        ssh-keygen -t rsa -b 4096 -f "$SSH_KEY_PATH"
    fi

    echo "[INFO] copying $SSH_KEY_PATH.pub to $SERVER_0"
    ssh-copy-id -i "$SSH_KEY_PATH.pub" "austin@$SERVER_0"
}

function bootstrap_darwin() {
    echo "[INFO] bootstrapping darwin"
    brew install ansible

    copy_ansible_hosts
    setup_ssh

    echo "[INFO] verifying ansible"
    ansible all -m ping -i "$ANSIBLE_HOSTS"
}

function bootstrap_linux() {
    echo "[INFO] bootstrapping linux"
    sudo apt update && sudo apt install ansible -y
}

if [[ "$(os_type)" == "darwin" ]]; then
    bootstrap_darwin
elif [[ "$(os_type)" == "linux" ]]; then
    bootstrap_linux
else
    echo "[ERROR] unrecognized os type=$(os_type)"
    exit 1
fi

