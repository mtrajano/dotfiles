################
# GLOBAL ALIASES
################
alias -g G="| grep"
alias -g L="| less"
alias -g H="| head -n"

#############
# APP ALIASES
#############
alias code="open -a Visual\ Studio\ Code"
alias subl="open -a Sublime\ Text"

###############
# GNU OVERRIDES
###############
alias sed=gsed

######
# MISC
######
function cheat {
  curl cheat.sh/$1
}
alias ssh="kitty +kitten ssh -q"
alias stow="stow --dotfiles"
alias h=man
alias hf=hyperfine
alias wl="wc -l"
alias ..="cd .."
alias finder="open -a Finder"
cloc() {
  echo "$@"
  if is-git-repo; then
    command cloc --vcs=git $*
  else
    command cloc $*
  fi
}

browse() {
  browser="open -a Firefox"

  if [[ -f $1 ]]; then
    eval $browser "$1"
  else
    eval $browser "https://$1"
  fi
}

ranger() {
  if [ -z "$RANGER_LEVEL" ]; then
    command ranger "$@"
  else
    exit
  fi
}
alias r=ranger

############
# LS ALIASES
############
alias ls="ls -G"
alias ll="ls -l"
alias la="ls -la"
alias lh="ls -lh"

#############
# GIT ALIASES
#############
function g {
  if [[ $# == 0 ]]; then
    git status -sb
  else
    git $@
  fi
}

function gwt {
  command=$1
  shift
  case $command in
    list)
      git worktree list;;
    add)
      dir=$(git root | xargs basename)
      branch=$1
      git worktree add ../$dir-$branch $branch;;
      # echo "git worktree add -b ../$dir-$branch $branch";;
    co)
      dir=$(git root | xargs basename)
      branch=$1
      cd ../$dir-$branch;;
    rm)
      dir=$(git root | xargs basename)
      branch=$1
      git worktree remove ../$dir-$branch;;
  esac
}
alias lg=lazygit

is-git-repo() {
  git rev-parse --git-dir > /dev/null 2>&1
}

######
# NVIM
######
alias nvims="nvim -S Session.vim" # open nvim in a session

##############
# TMUX ALIASES
##############
alias vpane="tmux capture-pane -p -S - | v -"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias t=tmux

# helper to kill multiple sessions at once
# kills tmux server if empty
tks() {

  [[ $# -eq 0 ]] && tmux kill-server && return

  for session in $*
  do
    tmux kill-session -t $session
  done
}

# if no arguments attaches to the selected session using fzf
# if there is an argument creates/attatches to the given tmux session
ta() {
  if [[ $# == 0 ]]; then
    if [[ -z $TMUX ]]; then
      tmux attach-session -t $(tmux list-sessions -F '#{session_name}' | fzf)
    else
      tmux switch -t $(tmux list-sessions -F '#{session_name}' | fzf)
    fi
  else
    tmux new-session -As $1
  fi
}

##################
# COMPOSER ALIASES
##################
alias c=composer

################
# CONFIG ALIASES
################
alias ez="nvim $XDG_CONFIG_HOME/zsh/.zshrc"
alias sz="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias ed="z dotfiles .config && nvim"
alias eg="nvim $XDG_CONFIG_HOME/git/config"
alias er="nvim $XDG_CONFIG_HOME/ranger/rc.conf"
alias et="nvim $XDG_CONFIG_HOME/tmux/tmux.conf"

################
# DOCKER ALIASES
################
alias d=docker
alias dc=docker-compose
alias dm=docker-machine
alias dl="dc logs -f --tail=100"
alias k=kubectl

#############
# PHP ALIASES
#############
alias psalm="./vendor/bin/psalm"
pu() {
  if [[ -f "./vendor/bin/paratest" ]]
  then
    ./vendor/bin/paratest "$@"
  else
    ./vendor/bin/phpunit "$@"
  fi
}
# in case still want to use phpunit
alias phpunit="./vendor/bin/phpunit"

#############
# LUA ALIASES
#############
alias luamake=/Users/trajano/.cache/nvim/nlua/sumneko_lua/lua-language-server/3rd/luamake/luamake

################
# PYTHON ALIASES
################
alias pyenv="virtualenv -p python3"

alias nvim_install="make distclean && make CMAKE_BUILD_TYPE=Release && make CMAKE_INSTALL_PREFIX=$HOME/local/nvim install"
