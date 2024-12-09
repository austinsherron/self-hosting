.PHONY: bootstrap infra apps nextcloud tailscale

BOOTSTRAP_PATH := bootstrap/main.sh

INFRA_PB := infra/main.yaml
APPS_PB := apps/main.yaml

NEXTCLOUD_PB := apps/playbooks/nextcloud.yaml
TAILSCALE_PB := infra/playbooks/tailscale.yaml

# stages

bootstrap:
	bash $(BOOTSTRAP_PATH)

infra:
	@ansible-playbook --ask-become-pass $(INFRA_PB)

apps:
	@ansible-playbook $(APPS_PB)

# components

nextcloud:
	@ansible-playbook $(NEXTCLOUD_PB)

tailscale:
	@ansible-playbook --ask-become-pass $(TAILSCALE_PB)
