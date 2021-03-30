export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="af-magic"

plugins=(git ruby osx bundler brew rails emoji-clock)

source $ZSH/oh-my-zsh.sh

export EDITOR=vim

# コマンドをtypoしたときに聞きなおしてくれる
setopt correct

# 表示を詰めてくれる
setopt list_packed

# beep音を消す
setopt nolistbeep

# cd 移動時に自動でls
setopt auto_cd
function chpwd() { ls }

#alias
#general
alias l="ls -al"
alias ms="mysql.server start"

#rails
alias be="bundle exec"
alias bi="bundle install -j4 --path vendor/bundle"
alias rc="rails c"
alias rs="rails s"
alias dm="rake db:migrate"
alias rspec="rspec -fd"

# alias pgstart="pg_ctl -l /usr/local/var/postgres/server.log start"
alias pgstart="pg_ctl -D ~/.postgres start"

# git
alias s="git status"
alias gc="git commit"
alias gh="git checkout"
alias gr="git rebase -i"

# other
alias e='ghq list -p | ag -v vendor | p cd'
alias redis-server='redis-server /usr/local/etc/redis.conf'

# pecoで絞り込んだ出力結果に対してコマンドを実行
function p() {
  peco | while read LINE; do $@ $LINE; done
}

# peco
function peco-z-search
{
  which peco z > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install peco and z"
    return 1
  fi
  local res=$(z | sort -rn | cut -c 12- | peco)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    return 1
  fi
}

# C-r peco select history
# http://k0kubun.hatenablog.com/entry/2014/07/06/033336
function peco-select-history() {
    BUFFER=$(fc -l -r -n 1 | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-select-history
bindkey '^r' peco-select-history

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=/usr/local/bin:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

bindkey -e

vscode () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }
alias vim='vscode'
