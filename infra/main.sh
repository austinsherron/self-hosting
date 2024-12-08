#!/usr/bin/env bash

set -Eeuo pipefail


function playbook_path() {
    echo "$(git rev-parse --show-toplevel)/infra/playbooks/infra.yaml"
}

function run_infra_playbooks() {
    echo "[INFO] running infra playbook"
    ansible-playbook --ask-become-pass "$(playbook_path)"
}

echo "[INFO] provisioning infra"
run_infra_playbooks || exit 1
echo "[INFO] infra provisioning complete"


