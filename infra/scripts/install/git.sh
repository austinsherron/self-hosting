#!/usr/bin/env bash

set -Eeuo pipefail


echo "Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing git..."
sudo snap install git

echo "Verifying git installation"
git --version

echo "Git installation completed successfully"

