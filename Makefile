.PHONY: bootstrap infra apps nextcloud tailscale

BOOTSTRAP_PATH := bootstrap/main.sh
INFRA_PATH := infra/main.sh
APPS_PATH := apps/main.sh

# stages

bootstrap:
	@bash $(BOOTSTRAP_PATH)

infra:
	@bash $(INFRA_PATH)

apps:
	@bash $(APPS_PATH)

# components

nextcloud:
	@bash $(APPS_PATH) nextcloud

nginx:
	@bash $(INFRA_PATH) nginx

tailscale:
	@bash $(INFRA_PATH) tailscale
