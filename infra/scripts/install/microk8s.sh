#!/usr/bin/env bash

set -Eeuo pipefail


echo "Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

if ! command -v snap >/dev/null; then
  echo "Installing snapd..."
  sudo apt install -y snapd
fi

echo "Installing microk8s..."
sudo snap install microk8s --classic

echo "Adding user to the 'microk8s' group..."
sudo usermod -aG microk8s "${USER}"

echo "Switching to 'microk8s' group..."
newgrp microk8s

echo "Setting up kubeconfig permissions..."
sudo chown -R "${USER}:${USER}" ~/.kube || mkdir -p ~/.kube

echo "Enabling essential microk8s addons..."
microk8s enable dns storage

echo "Verifying microk8s installation"
microk8s status --wait-ready

echo "MicroK8s installation completed successfully"
echo "You may need to log out and log back in for the group changes to take effect"

