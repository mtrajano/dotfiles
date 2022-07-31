export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export TERM="xterm-kitty"

export EDITOR="nvim"
bindkey -e #NOTE: needed since the editor variable above sets zle's keymap to viins

# n node manager
export N_PREFIX="$HOME/bin/n"

eval "$(zoxide init zsh)"

# export PATHS
path=(
  # node package manager
"$N_PREFIX/bin"
# local builds
"$HOME/bin"

$path

# TODO: figure out what I'm using RVM for and remove it if not needed
# RVM (rubdy version manager)
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# "$HOME/.rvm/bin"
  )

# extra configuration
source "$XDG_CONFIG_HOME/zsh/completion.zsh"
source "$XDG_CONFIG_HOME/zsh/aliases.zsh"


# TODO: see what this is needed for
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
