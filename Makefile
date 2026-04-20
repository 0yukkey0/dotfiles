DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
export DOTPATH

.DEFAULT_GOAL := help

.PHONY: help install deploy bundle update doctor

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "  install   新規端末セットアップ (Homebrew + Brewfile + deploy)"
	@echo "  deploy    リポジトリ内ファイルを \$$HOME に symlink"
	@echo "  bundle    Brewfile を適用 (差分のみ install)"
	@echo "  update    Homebrew / mise / zinit をまとめて最新化"
	@echo "  doctor    Brewfile とシステムのドリフトを報告 (変更はしない)"

install:
	@$(DOTPATH)/etc/install.sh

deploy:
	@$(DOTPATH)/etc/deploy.sh

bundle:
	@brew bundle --file=$(DOTPATH)/Brewfile

update:
	@$(DOTPATH)/etc/update.sh

doctor:
	@echo "==> Brewfile に書いてあるが未インストール"
	@brew bundle check --verbose --file=$(DOTPATH)/Brewfile || true
	@echo ""
	@echo "==> インストール済みだが Brewfile に無い (cleanup 候補 / 実削除はしない)"
	@brew bundle cleanup --file=$(DOTPATH)/Brewfile || true
