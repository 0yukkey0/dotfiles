# Created by newuser for 5.7.1

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

# 略語を展開する
zplugin light momo-lab/zsh-abbrev-alias

# 補完
zplugin load zsh-users/zsh-completions 

# cd超強化
zplugin light b4b4r07/enhancd

# サジェスト
zplugin light zsh-users/zsh-autosuggestions

# 実行可能なコマンドに色付け↲
zplugin light zdharma/fast-syntax-highlighting

# Plugin history-search-multi-word loaded with tracking.
zplugin load zdharma/history-search-multi-word

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure
zplugin ice from"gh-r" as"program"
zplugin load junegunn/fzf-bin
zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"
zplugin load docker/compose
zplugin ice as"program" atclone"rm -f src/auto/config.cache; ./configure" \
    atpull"%atclone" make pick"src/vim"
zplugin light vim/vim

autoload -U compinit
compinit

#
#
# export関連
#
# コマンド履歴を保存するファイルを指定する
export HISTFILE=~/dotfiles/zsh/.zhistory

# メモリに保存する履歴の件数を指定する
export HISTSIZE=10000

# ファイルに保存する履歴の件数を指定する
export SAVEHIST=1000000

#色設定
#export LSCOLORS=cxfxcxdxbxegedabagacad #緑
export LS_COLORS=gxfxcxdxbxegexabagacad #青



#補完リストもls -Gと同じカラースキームを利用
autoload -U colors
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

#補完後カーソルで選択できる
zstyle ':completion:*:default' menu select=1
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
#大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'





#########
# alias #
#########

# General
alias ls='ls -G'
alias la='ls -la'
alias ll='ls -l'

#npmのリストを見る
alias npm_list='npm list --depth=0'

## git
alias gs='git status'
alias gaa='git add'
alias gc='git checkout'
alias gc-b='git checkout -b'
alias gc-m='git commit -m'
alias gp='git push'
alias gh='git hist'
alias gh-a='git hist --all'
alias gb-dd='git branch --merged |egrep -v '\''\*|master'\''| xargs git branch -d'

## zsh
alias sz='source ~/.zshrc'
alias vz='vim ~/.zshrc'

#SSH
alias vsc='vim ~/.ssh/config'


##########
# option #
##########

# 補完候補を一覧で表示する
setopt auto_list

# 補完キー連打で候補順に自動で補完する
setopt auto_menu

# cd 時に自動でディレクトリスタックに追加する
setopt auto_pushd

#前のコマンドと同じならヒストリに入れない
setopt HIST_IGNORE_DUPS
#重複するヒストリを持たない
setopt HIST_IGNORE_ALL_DUPS

# コマンド中の余分なスペースは削除して履歴に記録する
setopt hist_reduce_blanks

# 履歴と重複するコマンドを記録しない
setopt hist_save_no_dups

# 履歴をすぐに追加する（通常はシェル終了時）
setopt inc_append_history

# # 以降をコメントとして扱う
setopt interactive_comments

# ビープを無効にする
setopt no_beep
setopt no_hist_beep
setopt no_list_beep

# = 以降も補完する（例：--option=value）
setopt magic_equal_subst

# 終了ステータスが0以外の場合にステータスを表示する
setopt print_exit_value

# ディレクトリスタックと重複したディレクトリをスタックに追加しない
setopt pushd_ignore_dups

# rm * の前に確認をとる
setopt rm_star_wait

# Zsh間で履歴を共有する
# setopt share_history

# コマンド実行後は右プロンプトを消す
setopt transient_rprompt

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# URLをコピペしたときに自動でエスケープ
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

## シェルを横断して.zshhistoryに記録
setopt inc_append_history
## ヒストリを共有
setopt share_history
