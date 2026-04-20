# ~/.zshrc — dotfiles / minimal & modern
#
# レイアウト:
#   $DOTFILES/zsh/*.zsh ... リポジトリ管理下のモジュール設定 (options, aliases, ...)
#   $ZSH_HOME           ... ランタイム用ディレクトリ (~/zsh)
#     ├ zinit/          ... プラグインマネージャ本体とプラグイン群
#     ├ p10k.zsh        ... powerlevel10k の設定 (p10k configure で生成)
#     └ history         ... コマンド履歴
#
# シークレット等は $ZSH_HOME/local.zsh か ~/.zshrc.local に書く (どちらも gitignore)

###################################
# Dotfiles root (symlink 解決済み)  #
###################################
DOTFILES="${${(%):-%N}:A:h}"

################
# ZSH runtime  #
################
export ZSH_HOME="$HOME/zsh"
[[ -d $ZSH_HOME ]] || mkdir -p "$ZSH_HOME"

#########
# Brew  #
#########
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

#################################
# Powerlevel10k instant prompt  #
#################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########
# PATH #
########
path=("$HOME/.local/bin" $path)

############
# History  #
############
export HISTFILE="$ZSH_HOME/history"
export HISTSIZE=100000
export SAVEHIST=1000000

#########################
# Completion / options  #
#########################
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
# Cache (起動高速化)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_HOME/zcompcache"

##################
# Zinit (plugins)#
##################
ZINIT_HOME="$ZSH_HOME/zinit"
if [[ ! -d $ZINIT_HOME ]]; then
  command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# prompt
zinit ice depth=1
zinit light romkatv/powerlevel10k
[[ -f "$ZSH_HOME/p10k.zsh" ]] && source "$ZSH_HOME/p10k.zsh"

# deferred plugins
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    Aloxaf/fzf-tab

#########################
# Modular config (repo) #
#########################
for f in "$DOTFILES/zsh/"*.zsh(N); do
  source "$f"
done

#############################
# Modern CLI integrations   #
#############################
# fzf: Ctrl-R 履歴検索 / Ctrl-T ファイル / Alt-C ディレクトリ
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
  export FZF_DEFAULT_OPTS='--height=60% --layout=reverse --border --info=inline'
  command -v fd >/dev/null 2>&1 && export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
fi

# zoxide: cd を賢く (enhancd の置き換え)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# mise: pyenv / nvm / rbenv / sdkman / fvm を一元化
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# direnv: プロジェクト別の環境変数
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# gh completion (compinit より後に評価する必要があるため deferred)
if command -v gh >/dev/null 2>&1; then
  zinit wait lucid id-as'gh-comp' nocd atload'eval "$(gh completion -s zsh)"' \
    for zdharma-continuum/null
fi

# atuin: SQLite 履歴検索 (Ctrl-R を fzf から奪取する — こちらを優先)
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

############
# Keybinds #
############
# Ctrl-G: ghq 管理下のリポジトリへ fzf で移動
if command -v ghq >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
  fzf-ghq() {
    local dir
    dir=$(ghq list -p | fzf --prompt='repo> ' \
      --preview 'command -v eza >/dev/null && eza -T --level=2 --color=always {} || ls {}')
    if [[ -n $dir ]]; then
      BUFFER="cd $dir"
      zle accept-line
    fi
    zle reset-prompt
  }
  zle -N fzf-ghq
  bindkey '^G' fzf-ghq
fi

#####################
# Local overrides   #
#####################
[[ -f "$ZSH_HOME/local.zsh" ]] && source "$ZSH_HOME/local.zsh"
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

