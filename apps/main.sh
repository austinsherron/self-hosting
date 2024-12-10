#!/usr/bin/env bash

set -Eeuo pipefail


SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLAY=""

export ANSIBLE_BECOME_PASS
ANSIBLE_BECOME_PASS="$(op item get pduhcnytpl5sw2odxgwi7ptc4m --fields lg7gz3zgxxx5lie4prmu2b52wq)"

[[ $# -gt 0 ]] && export PLAY="$1"

ansible-playbook "$SCRIPT_DIR/playbooks/main.yaml"

