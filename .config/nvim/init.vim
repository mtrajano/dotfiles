if v:false
  profile start /tmp/startprof
  profile func *
  profile file *

  luafile $HOME/dev/profiler.nvim/lua/profiler.lua
endif

" TODO: figure out where to put this
function s:FixColors() abort
  hi IndentBlanklineIndent guifg=#2d4853 gui=nocombine
endf

augroup fix_color
  autocmd!
  autocmd ColorScheme rigel call s:FixColors()
augroup END

lua require'plenary.reload'.reload_module('init')
lua require('init')

source $XDG_CONFIG_HOME/nvim/basic.vim
source $XDG_CONFIG_HOME/nvim/commands.vim
source $XDG_CONFIG_HOME/nvim/work.vim
