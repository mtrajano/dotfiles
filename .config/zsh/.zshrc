export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export TERM="xterm-kitty"

export EDITOR="nvim"
bindkey "^N" down-line-or-history
bindkey "^P" up-line-or-history

# TODO: create a widget and create a mapping to surround like behavior, map to s like nvim

export DYLD_LIBRARY_PATH="/opt/homebrew/lib/:$DYLD_LIBRARY_PATH"

# export PATHS
path=(
# local builds
"$HOME/bin" # TODO: decide between this and .local/bin
"$HOME/.local/bin"

"/opt/homebrew/bin"
"/opt/homebrew/sbin"

# ruby installed by homebrew
"/usr/local/opt/ruby/bin"

# TODO: find a better location for pip installs
"$HOME/Library/Python/3.8/bin"

$path

# TODO: figure out what I'm using RVM for and remove it if not needed
# RVM (rubdy version manager)
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# "$HOME/.rvm/bin"
  )

export NVM_DIR="$XDG_DATA_HOME/nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(zoxide init zsh)"

# extra configuration
source "$XDG_CONFIG_HOME/zsh/completion.zsh"
source "$XDG_CONFIG_HOME/zsh/aliases.zsh"

# TODO: see what this is needed for
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
