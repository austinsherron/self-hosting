.PHONY: bootstrap infra nextcloud tailscale

BOOTSTRAP_PATH := bootstrap/main.sh
INFRA_PATH := infra/main.sh

NEXTCLOUD_PB := apps/nextcloud/terraform.yaml
TAILSCALE_PB := infra/playbooks/install/tailscale.yaml

# stages

bootstrap:
	bash $(BOOTSTRAP_PATH)

infra:
	bash $(INFRA_PATH)

# components

nextcloud:
	@ansible-playbook $(NEXTCLOUD_PB)

tailscale:
	@ansible-playbook $(TAILSCALE_PB)
