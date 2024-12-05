#!/usr/bin/env bash

set -Eeuo pipefail


if ! which microk8s &> /dev/null; then
  echo "MicroK8s is not installed..."
  exit 1
fi

echo "Starting microk8s service..."
sudo microk8s start

echo "Waiting for MicroK8s to be ready..."
sudo microk8s status --wait-ready

if [[ ! -f ~/.kube/config ]]; then
    echo "Adding microk8s cluster config to ~/.kube/config"
    microk8s config > ~/.kube/config
else
    # shellcheck disable=SC2088
    echo "~/.kube/config already exists"
fi

echo "Verifying microk8s cluster..."
sudo microk8s kubectl get nodes

echo "MicroK8s cluster is up and running"

