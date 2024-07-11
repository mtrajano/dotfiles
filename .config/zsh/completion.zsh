# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' file-sort access
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/trajano/.config/zsh/completion.zsh'

autoload -Uz compinit
compinit -C

autoload zmv

compdef _git g=git

zmodload -i zsh/complist
