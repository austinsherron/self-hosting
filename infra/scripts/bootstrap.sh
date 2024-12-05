#!/usr/bin/env bash

set -Eeuo pipefail


KUBE_DIR="$HOME/.kube"

echo "Creating $KUBE_DIR directory"
mkdir -p "$KUBE_DIR"

echo "Setting permissions on $KUBE_DIR ..."
sudo chown -R "${USER}:${USER}" ~/.kube

echo "Verifying $KUBE directory"
ls -l "$KUBE"

