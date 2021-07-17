let g:mapleader = "\<Space>"

if v:false
  profile start /tmp/startprof
  profile func *
  profile file *

  map <leader>D :<C-u>profile stop <bar> edit /tmp/startprof<cr>
endif

lua require'plenary.reload'.reload_module('init')
lua require('init')

source $XDG_CONFIG_HOME/nvim/basic.vim
source $XDG_CONFIG_HOME/nvim/commands.vim
source $XDG_CONFIG_HOME/nvim/utils/theme.vim
source $XDG_CONFIG_HOME/nvim/work.vim
