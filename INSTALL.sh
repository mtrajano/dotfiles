# alacritty
ln -is alacritty $XDG_CONFIG_HOME/

ln -is kitty $XDG_CONFIG_HOME/

# nvim
ln -is nvim/{ftplugin,snips,after,lua} $XDG_CONFIG_HOME/nvim

# create projections
for dir in nvim/projections/*
do
  file="$dir/projections.json"
  repo=${dir##*/}

  ln -i $file "$HOME/dev/behance/$repo/.projections.json"
done

