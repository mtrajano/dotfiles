" lua version
" local u = require('mt.utils')

" -- consistent with bullets.vim and previous <C-space> is taken by tmux
" u.buf_nmap('<leader>x', '<Plug>VimwikiToggleListItem', { noremap = false, })

" consistent with bullets.vim and previous <C-space> is taken by tmux
nmap <leader>x <Plug>VimwikiToggleListItem

" TODO: if want to convert this file to lua need to use util term codes for
" <C-a> and <C-m>
nnoremap <leader>n :norm yyP$3b28F]b28<C-A>0
