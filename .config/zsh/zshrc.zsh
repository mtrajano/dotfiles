# TODO: set up zsh plugins: completion 

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# install zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# TODO: see what depth=1 is for and if it's needed
zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice depth=1; zinit light romkatv/powerlevel10k

# add homebrew to the path and configure env variables
eval "$(/opt/homebrew/bin/brew shellenv)"
export DYLD_LIBRARY_PATH="/opt/homebrew/lib/:$DYLD_LIBRARY_PATH"

# set up rbenv
eval "$(rbenv init - zsh)"

# nvm for node version management
export NVM_DIR="$XDG_DATA_HOME/nvm"
# PERF: this is causing slow start up stimes (https://github.com/nvm-sh/nvm/issues/1277)
# For some options on lazy loading this:
#   - https://github.com/nvm-sh/nvm/issues/1277#issuecomment-693390529
#   - https://gist.github.com/danielzen/be2dcd7381d763f7dbe72b342466dbff
#   - https://github.com/nvm-sh/nvm/issues/1277#issuecomment-318915266
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
