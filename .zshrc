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
alias tmuxkill="tmux kill-server"
alias ms="mysql.server start"
alias ctags='ctags --langmap=RUBY:.rb --exclude="*.js"  --exclude=".git*" -R .'

#rails
alias be="bundle exec"
alias bi="bundle install -j4 --path vendor/bundle"
alias rc="rails c"
alias rs="rails s"
alias dm="rake db:migrate"
alias rspec="rspec -fd"
alias erd="erd --attributes=foreign_keys,primary_keys,content,timestamp --filename=erd_sample --filetype=png"
alias prettyjson="python -m json.tool"
# alias pgstart="pg_ctl -l /usr/local/var/postgres/server.log start"
alias pgstart="pg_ctl -D ~/.postgres start"

# git
alias gs="git status"
alias gc="git commit -v"
alias gch="git checkout"
alias gr="git rebase -i"

# other
alias mux="tmuxinator"
alias e='ghq list -p | ag -v vendor | p cd'
alias redis-server='redis-server /usr/local/etc/redis.conf'
alias es='elasticsearch'

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

# wip
function git() {
  hub "$@"
}

function current_branch() {
  git rev-parse --abbrev-ref HEAD
}

function gw() {
  git commit --allow-empty -m "$1"
  git push origin $(current_branch)
  git pull-request -m "[WIP] $1" --browse -F ~/.pullrequest_template.txt
}

# tmux
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

vscode () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }
alias vim='vscode'

export PATH=/usr/local/bin:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
