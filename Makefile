.PHONY: bootstrap infra

BOOTSTRAP_PATH := bootstrap/main.sh
INFRA_PATH := infra/main.sh

bootstrap:
	bash $(BOOTSTRAP_PATH)

infra:
	bash $(INFRA_PATH)
