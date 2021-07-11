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

######
# MISC
######
alias h=man
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
g() {
  if [[ $# == 0 ]]; then
    git status -sb
  else
    git $@
  fi
}
alias lg=lazygit

is-git-repo() {
  git rev-parse --git-dir > /dev/null 2>&1
}

alias mnvim="nvim -u ~/stow/dotfiles/nvim/minimal.vim"
alias v=nvim

##############
# TMUX ALIASES
##############
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias t=tmux

# helper to kill multiple sessions at once
tks() {
  for session in $*
  do
    tmux kill-session -t $session
  done
}

# if no arguments attaches to the selected session
# if argument loads tmuxp config if it exists, else creates/attatches
# to a tmux session
ta() {
  if [[ $# == 0 ]]; then
    if [[ -z $TMUX ]]; then
      tmux attach-session -t $(tmux list-sessions -F '#{session_name}' | fzf)
    else
      tmux switch -t $(tmux list-sessions -F '#{session_name}' | fzf)
    fi
  else
    if [[ $(tmuxp ls | grep -w $1) ]]; then
      tmuxp load -y $1
    else
      tmux new-session -As $1
    fi
  fi
}

##################
# COMPOSER ALIASES
##################
alias c=composer

################
# CONFIG ALIASES
################
alias ez="nvim ~/.zshrc"
alias eza="nvim $XDG_CONFIG_HOME/zsh/aliases.zsh"
alias sz="source ~/.zshrc"
alias ed="z dotfiles .config && nvim"
alias eg="nvim $XDG_CONFIG_HOME/git/config"

################
# DOCKER ALIASES
################
alias d=docker
alias dc=docker-compose
alias dm=docker-machine
alias dl="dc logs -f --tail=100"
alias devenv='eval $(docker-machine env dev)'

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
