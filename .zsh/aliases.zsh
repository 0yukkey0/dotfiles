#変更完了後zsdpで変更内容をデプロイできる

alias ls='ls -G'
alias la='ls -la'
alias ll='ls -l'
alias tree='tree -C'
alias cl='clear'
alias chrome='open /Applications/Google\ Chrome.app'
alias google='(){google-chrome https://www.google.com/search\?q=$1}'

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
# リポジトリのディレクトリへ移動
alias gcd='cd $(ghq root)/$(ghq list | fzf)'
alias clone='ghq get'

