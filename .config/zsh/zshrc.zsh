# TODO: set up zsh plugins: vi-mode, completion, highighting, prompt using zinit

# TODO: move these to .zshenv
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export TERM="xterm-kitty"

export EDITOR=nvim
export VISUAL=nvim

# export PATHS
path=(
# local builds
"$HOME/bin"
"$HOME/.local/bin"

$path
  )

# add homebrew to the path and configure env variables
eval "$(/opt/homebrew/bin/brew shellenv)"
export DYLD_LIBRARY_PATH="/opt/homebrew/lib/:$DYLD_LIBRARY_PATH"

# set up rbenv
eval "$(rbenv init - zsh)"

# nvm for node version management
export NVM_DIR="$XDG_DATA_HOME/nvm"
# PERF: this is causing slow start up stimes (https://github.com/nvm-sh/nvm/issues/1277)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(zoxide init zsh)"

# aneable fzf keybindings 
# Docs: https://github.com/junegunn/fzf?tab=readme-ov-file#fuzzy-completion-for-bash-and-zsh
source <(fzf --zsh)

# extra configuration
source "$XDG_CONFIG_HOME/zsh/completion.zsh"
source "$XDG_CONFIG_HOME/zsh/keybindings.zsh"
source "$XDG_CONFIG_HOME/zsh/aliases.zsh"
