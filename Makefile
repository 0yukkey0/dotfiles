DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY: init
init: 
	./etc/init.sh

.PHONY: update
update:
	./etc/update.sh

.PHONY: deploy
deploy:
	./etc/deploy.sh
