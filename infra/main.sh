#!/usr/bin/env bash

set -Eeuo pipefail


function playbook_dir() {
    echo "$(git rev-parse --show-toplevel)/infra/playbooks"
}

function run_infra_playbooks() {
    echo "[INFO] running infra playbooks"

    for playbook in "$(playbook_dir)/"*.yaml; do
        echo "[INFO] running $(basename "${playbook%%.yaml}")"
        ansible-playbook --ask-become-pass "$playbook"
    done
}

echo "[INFO] provisioning infra"
run_infra_playbooks || exit 1
echo "[INFO] infra provisioning complete"


