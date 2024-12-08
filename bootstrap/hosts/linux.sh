#!/usr/bin/env bash

set -Eeuo pipefail


function install_ssh() {
    echo "[INFO] Updating system packages..."
    sudo apt update && sudo apt upgrade -y

    echo "[INFO] Installing openssh-server..."
    sudo apt install openssh-server -y
}

function init_ssh() {
    echo "[INFO] Enabling ssh service..."
    sudo systemctl enable ssh

    echo "[INFO] Starting ssh service..."
    sudo systemctl start ssh

    echo "[INFO] Updating firewall to allow ssh..."
    sudo ufw allow ssh

    echo "[INFO] Displaying firewall status..."
    sudo ufw status
}

echo "[INFO] bootstrapping linux"

if sudo systemctl status ssh &> /dev/null; then
    echo "[INFO] ssh server is already running; exiting"
    exit 0
fi

install_ssh || exit 1
init_ssh || exit 1

echo "[INFO] Displaying machine ip..."
ip a

