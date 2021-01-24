" helpful seettings when in 'pair' mode, having someone remote viewing my
" screen
function! <SID>TogglePairMode(on)
  if a:on
    set norelativenumber
    set mouse=a
  else
    set relativenumber
    set mouse=
  endif
endfunction

command! -nargs=0 -bang Pair call <SID>TogglePairMode(<bang>1)

" closes out every other buffer but this one
command! -nargs=0 On :%bd|e#|bd#

" trim trailing space on save
function! <SID>TrimTrailingSpace()
  let l:save = winsaveview()
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

