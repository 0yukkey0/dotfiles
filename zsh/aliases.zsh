#変更完了後zsdpで変更内容をデプロイできる

# ls -> eza
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias la='eza -la --group-directories-first --git'
  alias ll='eza -l --group-directories-first --git'
  alias lt='eza -T --level=2 --group-directories-first'
else
  alias ls='ls -G'
  alias la='ls -la'
  alias ll='ls -l'
fi

# cat -> bat
if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi

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
alias gh-a='git hist --all'
alias gb-dd='git branch --merged |egrep -v '\''\*|master'\''| xargs git branch -d'
# リポジトリのディレクトリへ移動
alias gcd='cd $(ghq root)/$(ghq list | fzf)'
alias clone='ghq get'

