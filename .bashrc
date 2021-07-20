# shellcheck shell=bash

#
# aliases
#
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ll='ls -lhF'
alias la='ll -a'

#
# bash-completion
#
if [[ -d /usr/share/bash-completion/bash_completion ]]; then
  # shellcheck source=/dev/null
  . /usr/share/bash-completion/bash_completion
elif [[ -d /usr/local/etc/bash_completion.d ]]; then
  # shellcheck source=/dev/null
  source /usr/local/etc/bash_completion.d/git-prompt.sh
  # shellcheck source=/dev/null
  source /usr/local/etc/bash_completion.d/git-completion.bash
fi

#
# git
#
# option
GIT_PS1_SHOWDIRTYSTATE=true
# git ps1
export PS1='\[\033[37m\][\t \[\033[36m\]\u\[\033[37m\]@\h \[\033[32m\]\W\[\033[37m\]]\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

#
# share history
#
function __share_history__() {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND='__share_history__'
shopt -u histappend

#
# nvm
#
export NVM_DIR="${HOME}/.nvm"

if [[ -f "${NVM_DIR}/nvm.sh" ]]; then
  # shellcheck source=/dev/null
  . "${NVM_DIR}/nvm.sh"
fi

if [[ -f "${NVM_DIR}/bash_completion" ]]; then
  # shellcheck source=/dev/null
  . "${NVM_DIR}/bash_completion"
fi

#
# go
#
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"

#
# python
#
export PYENV_ROOT=/usr/local/var/pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
# pyenvさんに自動補完機能を提供してもらう
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
