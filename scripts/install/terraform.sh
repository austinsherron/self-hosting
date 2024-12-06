#!/usr/bin/env bash

set -Eeuo pipefail


if which terraform &> /dev/null; then
    echo "Terraform is already installed; exiting"
    exit 0
fi

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing gpg and software-properties-common..."
sudo apt install -y curl gnupg software-properties-common

echo "Adding hashicorp gpg key..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "Adding hashicorp repo to system package list"
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "Installing terraform..."
sudo apt update && sudo apt install -y terraform

echo "Verifying Terraform installation"
terraform -v

echo "Terraform installed successfully"

