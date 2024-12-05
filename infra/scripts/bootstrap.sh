#!/usr/bin/env bash

set -Eeuo pipefail


echo "Creating ~/.kube directory"
mkdir ~/.kube

echo "Verifying ~/.kube directory"
ls -l ~/.kube

