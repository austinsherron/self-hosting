#!/usr/bin/env bash

set -Eeuo pipefail


if sudo systemctl status ssh &> /dev/null; then
    echo "ssh server is already running; exiting"
    exit 0
fi

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing openssh-server..."
sudo apt install openssh-server -y

echo "Enabling ssh service..."
sudo systemctl enable ssh

echo "Starting ssh service..."
sudo systemctl start ssh

echo "Updating firewall to allow ssh..."
sudo ufw allow ssh

echo "Displaying firewall status..."
sudo ufw status

echo "Displaying machine ip..."
ip a

