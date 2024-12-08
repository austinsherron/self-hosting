.PHONY: bootstrap infra tailscale

BOOTSTRAP_PATH := bootstrap/main.sh
INFRA_PATH := infra/main.sh
TAILSCALE_PB := infra/playbooks/tailscale.yaml

# stages

bootstrap:
	bash $(BOOTSTRAP_PATH)

infra:
	bash $(INFRA_PATH)

# steps

tailscale:
	@ansible-playbook $(TAILSCALE_PB)
