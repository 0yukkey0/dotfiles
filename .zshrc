export PATH="/usr/local/sbin:$PATH"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

## cdを超強化
#zinit load "b4b4r07/enhancd", use:"init.sh", lazy:true
zinit light b4b4r07/enhancd
## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1

## コマンド履歴検索
function peco-history-selection() {
  BUFFER=`history -n 1 | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

## gitリポジトリ検索・移動
function peco-src () {
  local selected_dir=$(ghq list -p | peco)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N peco-src
bindkey '^G' peco-src

## 履歴保存管理
# メモリに保存する履歴の件数を指定する
export HISTSIZE=10000

# ファイルに保存する履歴の件数を指定する
export SAVEHIST=1000000


zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# 以下はただのエイリアス設定
if builtin command -v bat > /dev/null; then
  alias cat="bat"
fi

# 色を使用出来るようにする
autoload -Uz colors
colors

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# [TAB] でパス名の補完候補を表示したあと、
# 続けて [TAB] を押すと候補からパス名を選択できるようになる
# 候補を選ぶには [TAB] か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"i
eval "$(pyenv init --path)"
# pyenvさんに自動補完機能を提供してもらう
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

#poetry
export PATH="/Users/yuki-yoshii/.local/bin:$PATH"


# mysql
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# java
export JAVA_HOME=/Users/yuki-yoshii/.sdkman/candidates/java/current/bin/java
export PATH="$JAVA_HOME:$PATH"
#########
# alias #
#########

# General
export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls='ls -G'
alias la='ls -la'
alias ll='ls -lh'

#npmのリストを見る
alias npm_list='npm list --depth=0'

## git
alias g='git'
alias ga='git add'
alias gs='git status'
alias gp='git push'
alias gb-dd='git branch --merged |egrep -v '\''\*|master'\''| xargs git branch -d'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# flutter
export PATH="$PATH":"$HOME/fvm/default/bin"

# rvenv
eval "$(rbenv init - zsh)"

# ADBコマンド
export PATH="$PATH":"/Users/yuki-yoshii/Library/Android/sdk/platform-tools/"

#rust
source "$HOME/.cargo/env"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/yuki-yoshii/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
