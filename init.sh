#!/bin/sh

set -x

_add_xdg_vars() {
  echo "" >> ~/.bashrc
  echo export XDG_CONFIG_HOME='"$HOME/.config"' >> ~/.bashrc
  echo export XDG_CACHE_HOME='"$HOME/.cache"' >> ~/.bashrc
  echo export XDG_DATA_HOME='"$HOME/.local/share"' >> ~/.bashrc
  source ~/.bashrc
}

_install_mac() {
  echo "Installing dependencies on Mac OS X"

  brew install brave-browser kitty rg fd zsh ranger

  # build neovim
  xcode-select --install
  brew install ninja libtool automake cmake pkg-config gettext curl
}

_install_linux() {
  sudo pacman -Syu
  sudo pacman -S yay
  
  yay -S make brave-browser kitty rg fd zsh ranger xclip
  
  mkdir -p ~/src
  
  # build neovim
  yay -S base-devel cmake unzip ninja tree-sitter curl
}

_change_default_shell() {
  sudo usermod --shell /bin/local/zsh $(whoami)
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
  if [[ ! -f "~/src/neovim" ]]
  then
    git clone git@github.com:neovim/neovim.git ~/src/neovim
    cd ~/src/neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
  fi
}

_install_deps
_install_neovim

ln -s ~/dotfiles/.config/* ~/.config/
