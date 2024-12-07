#!/usr/bin/env bash

set -Eeuo pipefail


if which tailscale &> /dev/null; then
    echo "Tailscale is already installed; exiting"
    exit 0
fi

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Adding tailscale gpg key..."
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null

echo "Adding tailscale repo to system package list"
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

echo "Installing tailscale..."
sudo apt install -y tailscale

echo "Initializing tailscale..."
sudo tailscale up

echo "Verifying tailscale installation"
sudo tailscale up

echo "Tailscale installed successfully"

