" trim trailing space on save
fun! <SID>TrimTrailingSpace()
  let l:save = winsaveview()

  " remove all spaces ending with EOL
  keeppatterns %s/\s\+$//e

  call winrestview(l:save)
endfun

augroup formatting_fixes
  autocmd!
  autocmd BufWritePre * :call <SID>TrimTrailingSpace()
augroup END

augroup fix_filetypes
  autocmd!
  autocmd BufEnter composer.lock setlocal ft=json
augroup END

