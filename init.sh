#!/bin/bash

set -x

_change_zsh_dir() {
  [[ -z "$ZDOTDIR" ]] && echo "export ZDOTDIR=\"$HOME/dotfiles/.config/zsh/\"" > "$HOME/.zshenv"
}

_install_mac() {

  echo "Intalling Homebrew"
  command -v brew > /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "Installing dependencies on Mac OS X"
  # TODO: look into moving these to a packages file
  brew install \
    stow \
    brave-browser \
    kitty \
    tmux \
    rg \
    fd \
    fzf \
    zsh \
    htop \
    git-delta \
    git \
    gh \
    tldr \
    zoxide

  # for spotify
  brew install spotify spotifyd
  brew service start spotifyd

  # for neovim
  brew install ninja libtool automake cmake pkg-config gettext curl

  case "$(uname -m)" in

     arm64) # m1 chip
       # install rosetta
       /usr/sbin/softwareupdate --install-rosetta --agree-to-license
       ;;

     x86_64) # intel based mac chip
       ;;

  esac
}

_config_mac() {
  defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
}

_install_linux() {
  sudo pacman -Syu
  sudo pacman -S yay

  # TODO: need to update these packages, see how to keep a list with same named packages
  yay -S make brave-browser \
    stow \
    kitty \
    rg \
    fd \
    zsh \
    xclip \
    htop \
    tmux \
    git-delta \
    git \
    gh \
    tldr

  # build neovim
  yay -S base-devel cmake unzip ninja tree-sitter curl
}

_change_default_shell() {
  sudo usermod --shell /bin/local/zsh "$(whoami)"
}

_install_deps() {
  case "$(uname -s)" in

     Darwin)
       _install_mac
       _config_mac
       ;;

     Linux)
       _install_linux
       _change_default_shell
       ;;

     *)
       echo 'Not supported'
       exit 1
       ;;
  esac
}

_install_neovim() {
  if [[ ! -f "$HOME/src/neovim" ]]
  then
    git clone git@github.com:neovim/neovim.git ~/src/neovim
    cd ~/src/neovim || exit
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install # todo: this should probably have ~/bin as the install dir
  fi
}


mkdir -p ~/src ~/bin

_install_deps
_change_zsh_dir
_install_neovim

# TODO: LOOK INTO THIS AS IT'S CURRENTLY DELETING .CONFIG
# rm "$HOME/.config"
# TODO: this should be done with stow or another dotfile manager
# ln -s ~/dotfiles/.config/* ~/.config/
