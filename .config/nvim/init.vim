if v:false
  profile start /tmp/startprof
  profile func *
  profile file *
endif

lua require'plenary.reload'.reload_module('init')
lua require('init')

source $XDG_CONFIG_HOME/nvim/basic.vim
source $XDG_CONFIG_HOME/nvim/commands.vim
source $XDG_CONFIG_HOME/nvim/work.vim