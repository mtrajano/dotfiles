# alacritty
ln -is $PWD/alacritty $XDG_CONFIG_HOME/
ln -is $PWD/kitty $XDG_CONFIG_HOME/

ln -is $PWD/git/gitignore $HOME/.gitignore
ln -is $PWD/git/gitconfig $HOME/.gitconfig
ln -is $PWD/git/gitattributes $HOME/.gitattributes

# nvim
ln -is $PWD/nvim/{ftplugin,snips,after,lua} $XDG_CONFIG_HOME/nvim

# create projections
for dir in nvim/projections/*
do
  file="$dir/projections.json"
  repo=${dir##*/}

  ln -i $file "$HOME/dev/behance/$repo/.projections.json"
done

