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
    exec '%!xxd'
    let s:last_ft = &ft
    setlocal ft=xxd
  else
    exec '%!xxd -r'
    exec 'setlocal ft=' . s:last_ft
    edit!
  endif
endfunction

command! -nargs=0 GetSynName echo synIDattr(synID(line('.'), col('.'), v:true), 'name')

" TODO: see which one I use more often
command! -nargs=0 -bang Hex call s:HexifyFile(<bang>1)
command! -nargs=0 -bang Xxd call s:HexifyFile(<bang>1)

command! -nargs=1 -complete=file Profile call s:ProfileStart(<f-args>)
command! -nargs=0 ProfileStop call s:ProfileStop()

function! s:FixMultipleNewline()
  let l:save = winsaveview()
  keeppatterns %s/\n\n$/\r/e
  call winrestview(l:save)
endfunction
command! -nargs=0 FixMultipleNewline call s:FixMultipleNewline()

" netrw open url patch
function! g:OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')

  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = substitute(s:uri, '&', '\\&', 'g')
  let s:uri = shellescape(s:uri, 1)

  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call g:OpenURLUnderCursor()<CR>

" trim trailing space on save
function! s:TrimTrailingSpace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

augroup formatting_fixes
  autocmd!
  autocmd BufWritePre * call s:TrimTrailingSpace()
augroup END
