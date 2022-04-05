echo "" >> ~/.bashrc
echo export XDG_CONFIG_HOME='"$HOME/.config"' >> ~/.bashrc
echo export XDG_CACHE_HOME='"$HOME/.cache"' >> ~/.bashrc
echo export XDG_DATA_HOME='"$HOME/.local/share"' >> ~/.bashrc
source ~/.bashrc

sudo pacman -Syu
sudo pacman -S yay

yay -S make git brave-browser kitty rg fd zsh ranger xclip

mkdir -p ~/src

# build neovim
yay -S base-devel cmake unzip ninja tree-sitter curl
git clone git@github.com:neovim/neovim.git ~/src/neovim
cd ~/src/neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

ln -s ~/dotfiles/.config/* ~/.config/

sudo usermod --shell /bin/local/zsh $(whoami)
