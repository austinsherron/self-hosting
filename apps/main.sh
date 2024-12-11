#!/usr/bin/env bash

set -Eeuo pipefail


SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLAY=""

function validate_play() {
    [[ -z "$PLAY" ]] && return 0

    for play in "$SCRIPT_DIR/playbooks/"*.yaml; do
        play_name="$(basename "${play%%.yaml}")"
        [[ "$play_name" != "main" ]] && [[ "$play_name" == "$PLAY" ]] && return 0
    done

    echo "[ERROR] PLAY=$PLAY is invalid"
    return 1
}

export ANSIBLE_STDOUT_CALLBACK="debug"

export ANSIBLE_BECOME_PASS
ANSIBLE_BECOME_PASS="$(op item get pduhcnytpl5sw2odxgwi7ptc4m --fields lg7gz3zgxxx5lie4prmu2b52wq)"

export POSTGRES_PASSWORD
POSTGRES_PASSWORD="$(op item get pgny73g4eufx7pifryeapy6sfe --fields password)"

[[ $# -gt 0 ]] && export PLAY="$1"
validate_play || exit 1

ansible-playbook "$SCRIPT_DIR/playbooks/main.yaml"

