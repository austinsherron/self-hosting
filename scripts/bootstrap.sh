#!/usr/bin/env bash

set -Eeuo pipefail


SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"

function os_type() {
    uname | tr '[:upper:]' '[:lower:]'
}

if [[ "$(os_type)" == "darwin" ]]; then
    # shellcheck source=/Users/austin/Workspace/workspace/self-hosting/scripts/hosts/darwin.sh
    . "$SCRIPTS_DIR/hosts/darwin.sh"
elif [[ "$(os_type)" == "linux" ]]; then
    # shellcheck source=/Users/austin/Workspace/workspace/self-hosting/scripts/hosts/linux.sh
    . "$SCRIPTS_DIR/hosts/linux.sh"
else
    echo "[ERROR] unrecognized os type=$(os_type)"
    exit 1
fi

