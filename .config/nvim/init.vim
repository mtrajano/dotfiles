if v:false
  profile start /tmp/startprof
  profile func *
  profile file *

  luafile $HOME/dev/profiler.nvim/lua/profiler.lua
endif

" TODO: figure out where to put this
function s:FixColors() abort
  hi IndentBlanklineIndent guifg=#393d4e gui=nocombine
  hi GitSignsAdd guifg=#73daca " TODO: look into using tokyonight named colors
  hi GitSignsChange guifg=#2ac3de " TODO: look into using tokyonight named colors
  hi GitSignsDelete guifg=#f7768e " TODO: look into using tokyonight named colors
endf

augroup fix_color
  autocmd!
  autocmd ColorScheme tokyonight call s:FixColors()
augroup END

lua require('init')

source $XDG_CONFIG_HOME/nvim/basic.vim
source $XDG_CONFIG_HOME/nvim/commands.vim
