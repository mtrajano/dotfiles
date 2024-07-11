# cycle through history with <c-p> and <c-n>
bindkey "^N" down-line-or-history
bindkey "^P" up-line-or-history

# bash like delete word
# Source: (https://unix.stackexchange.com/questions/250690/how-to-configure-ctrlw-as-delete-word-in-zsh)
my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
