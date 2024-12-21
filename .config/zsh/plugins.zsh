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

# fnm
FNM_PATH="/Users/mtrajano/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/mtrajano/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

eval "$(zoxide init zsh)"
