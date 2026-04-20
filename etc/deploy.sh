#!/usr/bin/env bash
# リポジトリ内ファイルを $HOME へ symlink する
set -euo pipefail

DOTPATH="${DOTPATH:-$(cd "$(dirname "$0")/.." && pwd)}"

# "<repo 相対 src>:<$HOME 相対 dst>"
LINKS=(
  ".zshrc:.zshrc"
  "vim/.vimrc:.vimrc"
)

for pair in "${LINKS[@]}"; do
  src="$DOTPATH/${pair%%:*}"
  dst="$HOME/${pair##*:}"
  if [[ ! -e $src ]]; then
    echo "skip: $src (not found)" >&2
    continue
  fi
  ln -snfv "$src" "$dst"
done

# zsh ランタイム用ディレクトリ (plugin / history / p10k 設定置き場)
mkdir -p "$HOME/zsh"

# 旧構成からの移行: ~/.p10k.zsh → ~/zsh/p10k.zsh
if [[ -f "$HOME/.p10k.zsh" && ! -e "$HOME/zsh/p10k.zsh" ]]; then
  mv "$HOME/.p10k.zsh" "$HOME/zsh/p10k.zsh"
  echo "migrated ~/.p10k.zsh -> ~/zsh/p10k.zsh"
fi

# 旧構成からの移行: ~/.zsh_history → ~/zsh/history
if [[ -f "$HOME/.zsh_history" && ! -e "$HOME/zsh/history" ]]; then
  mv "$HOME/.zsh_history" "$HOME/zsh/history"
  echo "migrated ~/.zsh_history -> ~/zsh/history"
fi

echo "Deploy complete."
