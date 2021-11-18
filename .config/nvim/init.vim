if v:false
  profile start /tmp/startprof
  profile func *
  profile file *

  luafile $HOME/dev/profiler.nvim/lua/profiler.lua
endif

lua require'plenary.reload'.reload_module('init')
lua require('init')

source $XDG_CONFIG_HOME/nvim/basic.vim
source $XDG_CONFIG_HOME/nvim/commands.vim
source $XDG_CONFIG_HOME/nvim/work.vim

" TODO: figure out where to put these
hi IndentBlanklineIndent guifg=#2d4853 gui=nocombine
hi link TroubleSignError LspDiagnosticsSignError
hi link TroubleTextError LspDiagnosticsDefaultError
hi link TroubleTextWarning LspDiagnosticsSignWarning
hi link TroubleTextWarning LspDiagnosticsDefaultWarning
