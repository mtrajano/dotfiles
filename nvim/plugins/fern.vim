" fix navigation keys so they work with vim-tmux-navigator
function! s:init_fern() abort
  nmap <buffer> N <Plug>(fern-action-new-path)
  nnoremap <buffer> <C-l> :TmuxNavigateRight<cr>
  nnoremap <buffer> <C-k> :TmuxNavigateUp<cr>
  nnoremap <buffer> <C-j> :TmuxNavigateDown<cr>
  nnoremap <buffer> <C-h> :TmuxNavigateLeft<cr>
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

" file/find remaps
nnoremap <silent> <leader>k :Fern . -drawer -toggle -reveal=%<cr>

