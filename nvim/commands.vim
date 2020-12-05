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

  " TODO: move this to the after directory, figure out why files in the after
  " directory are not loading (after/ is in the rtp)
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

augroup fix_filetypes
  autocmd!
  autocmd BufEnter composer.lock setlocal ft=json
augroup END

