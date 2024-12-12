.PHONY: bootstrap infra apps

BOOTSTRAP_PATH := bootstrap/main.sh
INFRA_PATH := infra/main.sh
APPS_PATH := apps/main.sh

# stages

bootstrap:
	@bash $(BOOTSTRAP_PATH)

infra:
	@bash $(INFRA_PATH) $(PLAY)

apps:
	@bash $(APPS_PATH) $(PLAY)
