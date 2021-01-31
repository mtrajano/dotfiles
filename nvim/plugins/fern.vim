" fix navigation keys so they work with vim-tmux-navigator
function! s:init_fern() abort
  " fix navigating results
  nnoremap n jn
  " unmap <buffer> N " this breaks a bunch of things

  nmap <buffer> y "+<Plug>(fern-action-yank:path)
  nmap <buffer> K <Plug>(fern-action-new-path)
  nnoremap <silent> <buffer> <C-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <buffer> <C-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <buffer> <C-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <buffer> <C-h> :TmuxNavigateLeft<cr>
  nmap <buffer> <BS> <Plug>(fern-action-leave)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

nnoremap <silent> <leader>h :Fern . -reveal=%<cr>
