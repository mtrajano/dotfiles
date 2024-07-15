# TODO: set up zsh plugins: completion 

# install/initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# zinit plugins
# TODO: see what depth=1 is for and if it's needed
zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice depth=1; zinit light romkatv/powerlevel10k

###############
# CONFIGURATION
###############

# things to initialize post zsh-vi-mode
function zvm_after_init() {
  # aneable fzf keybindings 
  # Docs: https://github.com/junegunn/fzf?tab=readme-ov-file#fuzzy-completion-for-bash-and-zsh
  source <(fzf --zsh) # enable after zsh-vi-mode as it clashes with the ctrl-r (history search) key binding
}

# add homebrew libs to the library path and configure env variables
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
