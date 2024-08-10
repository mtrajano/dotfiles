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

source "$XDG_CONFIG_HOME/zsh/plugins.zsh"

# extra configuration
source "$XDG_CONFIG_HOME/zsh/options.zsh"
source "$XDG_CONFIG_HOME/zsh/completion.zsh"
source "$XDG_CONFIG_HOME/zsh/keybindings.zsh"
source "$XDG_CONFIG_HOME/zsh/aliases.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mtrajano/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mtrajano/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mtrajano/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mtrajano/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
