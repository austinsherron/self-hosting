#!/usr/bin/env bash

set -Eeuo pipefail


SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLAY=""

export ANSIBLE_BECOME_PASS
ANSIBLE_BECOME_PASS="$(op item get pduhcnytpl5sw2odxgwi7ptc4m --fields lg7gz3zgxxx5lie4prmu2b52wq)"

export TAILSCALE_OAUTH_CLIENT_ID
TAILSCALE_OAUTH_CLIENT_ID="$(op item get oa5ggk7crqwb6qbxcnoazz2oau --fields username)"

export TAILSCALE_OAUTH_CLIENT_SECRET
TAILSCALE_OAUTH_CLIENT_SECRET="$(op item get oa5ggk7crqwb6qbxcnoazz2oau --fields credential)"

[[ $# -gt 0 ]] && export PLAY="$1"

ansible-playbook "$SCRIPT_DIR/playbooks/main.yaml"

