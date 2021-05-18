" TODO status lines functions, move these somewhere else
function! TruncateRelativePath() abort
  return luaeval('require("statusline").truncated_relativepath()')
endfunction

function! ALEWarningCounts() abort
  return luaeval('require("statusline").ale_warnings()')
endfunction

function! ALEErrorCounts() abort
  return luaeval('require("statusline").ale_errors()')
endfunction

function! LightlineModified() abort
  return luaeval('require("statusline").lightline_modified()')
endfunction

function! s:ProfileStart(filename) abort
  let s:profile_filename = a:filename

  exec "profile start " . s:profile_filename
  profile func *
  profile file *
endfunction

function! s:ProfileStop() abort
  profile stop
  exec "edit " . s:profile_filename
endfunction

function! s:HexifyFile(on) abort
  if a:on
    syntax off
    exec '%!xxd'
  else
    syntax enable
    exec '%!xxd -r'
    edit!
  endif
endfunction

command! -nargs=0 -bang Hex call s:HexifyFile(<bang>1)

" closes out every other buffer but this one
command! -nargs=0 On :%bd|e#|bd#

command! -nargs=1 -complete=file Profile call s:ProfileStart(<f-args>)
command! -nargs=0 -complete=file ProfileStop call s:ProfileStop()

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
  autocmd BufEnter */git/config setlocal ft=gitconfig
augroup END

