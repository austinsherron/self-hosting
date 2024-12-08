#!/usr/bin/env bash

set -Eeuo pipefail


BOOTSTRAP_DIR="$(cd "$(dirname "$0")" && pwd)"

function os_type() {
    uname | tr '[:upper:]' '[:lower:]'
}

if [[ "$(os_type)" == "darwin" ]]; then
    # shellcheck source=/Users/austin/Workspace/workspace/self-hosting/bootstrap/hosts/darwin.sh
    . "$BOOTSTRAP_DIR/hosts/darwin.sh"
elif [[ "$(os_type)" == "linux" ]]; then
    # shellcheck source=/Users/austin/Workspace/workspace/self-hosting/bootstrap/hosts/linux.sh
    . "$BOOTSTRAP_DIR/hosts/linux.sh"
else
    echo "[ERROR] unrecognized os type=$(os_type)"
    exit 1
fi

