#!/usr/bin/env bash
# 新規端末の初回セットアップ (再実行しても安全 / idempotent)
set -euo pipefail

DOTPATH="${DOTPATH:-$(cd "$(dirname "$0")/.." && pwd)}"

# --- 1. Xcode Command Line Tools ---
if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Xcode Command Line Tools を入れます"
  xcode-select --install || true
  echo "CLT のインストール後、もう一度 make install を実行してください"
  exit 0
fi

# --- 2. Homebrew ---
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Homebrew をインストール"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 当コマンドで brew を参照できるように PATH を通す
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# --- 3. Brewfile を適用 ---
echo "==> brew bundle (Brewfile)"
brew bundle --file="$DOTPATH/Brewfile"

# --- 4. symlink 配置 ---
echo "==> deploy"
"$DOTPATH/etc/deploy.sh"

cat <<'EOF'

==> セットアップ完了

次にやること:
  1. ターミナルを再起動 (zinit が初回に plugin を DL)
  2. atuin に既存シェル履歴を取り込む:  atuin import auto
  3. mise で言語ランタイムを入れる:      mise use -g node@lts python@3 ...
  4. 必要なら p10k を再設定:              p10k configure
EOF
