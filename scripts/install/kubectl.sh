#!/usr/bin/env bash

set -Eeuo pipefail


VERSION="v1.31.0"

if which kubectl &> /dev/null; then
    echo "kubectl is already installed; exiting"
    exit 0
fi

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

if ! command -v curl &> /dev/null; then
  echo "curl not found, installing..."
  sudo apt install -y curl
else
  echo "curl is already installed."
fi

echo "Downloading kubectl $VERSION..."
curl -LO "https://dl.k8s.io/release/$VERSION/bin/linux/amd64/kubectl"

echo "Making kubectl executable..."
chmod +x ./kubectl

echo "Moving kubectl to /usr/local/bin..."
sudo mv ./kubectl /usr/local/bin/kubectl

echo "Verifying kubectl installation..."
kubectl version --client

echo "kubectl installation completed successfully."

