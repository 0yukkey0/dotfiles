# Brewfile — 最小構成
# 適用: `brew bundle --file=Brewfile` (既にインストール済みのものはスキップされる)
# 言語ランタイム (python/node/ruby/java/flutter 等) は mise で管理するため brew には入れない

############
# Formulae #
############

# Shell & core
brew "git"
brew "gh"
brew "ghq"
brew "jq"

# Modern CLI (.zshrc が統合する前提)
brew "fzf"         # Ctrl-R / Ctrl-T / ghq ランチャ
brew "fd"          # find の代替。fzf の FZF_DEFAULT_COMMAND
brew "ripgrep"     # grep の代替
brew "bat"         # cat の代替
brew "eza"         # ls の代替
brew "zoxide"      # cd の代替 (enhancd 置換)
brew "atuin"       # 履歴管理 (Ctrl-R を fuzzy 検索 UI に置換)

# Runtime manager
brew "mise"
brew "usage"       # mise の補完バックエンド

#########
# Casks #
#########

# Terminal & editor
cask "warp"
cask "cmux"
cask "visual-studio-code"
cask "claude"

# Font (Powerlevel10k 用の Nerd Font)
cask "font-hackgen-nerd"

# Browser / IME
cask "google-chrome"
cask "google-japanese-ime"

# Productivity
cask "raycast"
cask "1password"
cask "notion"
