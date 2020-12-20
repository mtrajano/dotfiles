" alias for toggling relative number
command! Nu set relativenumber!

" trim trailing space on save
function! <SID>TrimTrailingSpace()
  let l:save = winsaveview()

  " remove all spaces ending with EOL
  keeppatterns %s/\s\+$//e

  call winrestview(l:save)
endfunction

augroup formatting_fixes
  autocmd!
  autocmd BufWritePre * :call <SID>TrimTrailingSpace()
augroup END

augroup fix_filetypes
  autocmd!
  autocmd BufEnter composer.lock setlocal ft=json
  autocmd BufEnter .vim.custom setlocal ft=vim
augroup END

