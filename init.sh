#!/bin/bash

set -x

_change_zsh_dir() {
  echo "export ZDOTDIR=\"$HOME/dotfiles/.config/zsh/\"" > "$HOME/.zshenv"
}

_install_mac() {
  echo "Installing dependencies on Mac OS X"

  # core packages
  brew install \
    stow \ # for dotfiles, TODO: look at better solution for dotfile management
    brave-browser \
    kitty \
    rg \
    fd \
    zsh \
    ranger \
    htop \
    git-delta \
    gh \
    # reference packages
    tldr

  # build neovim
  xcode-select --install
  brew install ninja libtool automake cmake pkg-config gettext curl
}

_install_linux() {
  sudo pacman -Syu
  sudo pacman -S yay

  yay -S make brave-browser \
    stow \ # for dotfiles, TODO: look at better solution for dotfile management
    kitty \
    rg \
    fd \
    zsh \
    ranger \
    xclip \
    htop \
    git-delta \
    gh \
    # reference packages
    tldr

  mkdir -p ~/src

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
    sudo make install
  fi
}

[[ -z "$ZDOTDIR" ]] && _change_zsh_dir

_install_deps
_install_neovim

ln -s ~/dotfiles/.config/* ~/.config/
