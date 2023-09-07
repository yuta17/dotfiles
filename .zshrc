
ZSH_THEME="af-magic"

plugins=(git ruby bundler brew rails emoji-clock)

# コマンドをtypoしたときに聞きなおしてくれる
setopt correct

# 表示を詰めてくれる
setopt list_packed

# beep音を消す
setopt nolistbeep

# cd 移動時に自動でls
setopt auto_cd
function chpwd() { ls }

# alias

## rails
alias be="bundle exec"
alias bi="bundle install -j4 --path vendor/bundle"
alias rspec="rspec -fd"

## git
alias s="git status"

## others
alias l="ls -al"
alias e='ghq list -p | ag -v vendor | p cd'
alias vim='vscode'
alias pgstart="pg_ctl -D /usr/local/var/postgres start"
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

vscode () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }


# exports
export EDITOR=vim
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.rbenv/shims:/usr/local/bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# evals
eval "$(direnv hook zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)" 
eval "$(rbenv init -)"
eval "$(nodenv init -)"

# bindkeys
bindkey '^r' peco-select-history
