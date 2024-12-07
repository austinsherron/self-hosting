#!/usr/bin/env bash

set -Eeuo pipefail


echo "Running installation scripts..."

for file in "$HOME/Workspace/workspace/self-hosting/scripts/install"/*.sh; do
    echo "  Installing $(basename "${file%%.sh}")"
    bash "$file"
done

echo "Finished installations."

