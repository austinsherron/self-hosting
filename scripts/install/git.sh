#!/usr/bin/env bash

set -Eeuo pipefail


if which git &> /dev/null; then
    echo "Git is already installed; exiting"
    exit 0
fi

echo "Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing git..."
sudo apt install git

echo "Verifying git installation"
git --version

echo "Git installation completed successfully"

