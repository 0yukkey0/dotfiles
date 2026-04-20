#!/usr/bin/env bash
# 日常メンテ: Homebrew / mise / zinit をまとめて最新化
set -euo pipefail

DOTPATH="${DOTPATH:-$(cd "$(dirname "$0")/.." && pwd)}"

echo "==> brew update"
brew update

echo "==> brew upgrade"
brew upgrade

# Brewfile に追加された新しい formula/cask を取り込む
# (dump はしない。リポジトリの Brewfile を正とする)
echo "==> brew bundle (apply $DOTPATH/Brewfile)"
brew bundle --file="$DOTPATH/Brewfile"

echo "==> brew cleanup"
brew cleanup

echo "==> brew autoremove"
brew autoremove

if command -v mise >/dev/null 2>&1; then
  echo "==> mise upgrade"
  mise upgrade || true
fi

# zinit とプラグインの更新 (サブシェル経由で非対話実行)
if [[ -d "$HOME/zsh/zinit" ]]; then
  echo "==> zinit self-update / plugin update"
  zsh -i -c 'zinit self-update && zinit update --all' || true
fi

echo "==> brew doctor"
brew doctor || true

echo "Finish."
echo "(Brewfile のドリフト確認は 'make doctor' で)"
