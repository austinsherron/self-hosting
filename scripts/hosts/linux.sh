#!/usr/bin/env bash

set -Eeuo pipefail


echo "[INFO] bootstrapping linux"

if sudo systemctl status ssh &> /dev/null; then
    echo "[INFO] ssh server is already running; exiting"
    exit 0
fi

echo "[INFO] Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "[INFO] Installing openssh-server..."
sudo apt install openssh-server -y

echo "[INFO] Enabling ssh service..."
sudo systemctl enable ssh

echo "[INFO] Starting ssh service..."
sudo systemctl start ssh

echo "[INFO] Updating firewall to allow ssh..."
sudo ufw allow ssh

echo "[INFO] Displaying firewall status..."
sudo ufw status

echo "[INFO] Displaying machine ip..."
ip a

