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

command! -nargs=0 GetSynName echo synIDattr(synID(line('.'), col('.'), v:true), 'name')

command! -nargs=0 -bang Hex call s:HexifyFile(<bang>1)

" closes out every other buffer but this one
command! -nargs=0 On :%bd|e#|bd#

command! -nargs=1 -complete=file Profile call s:ProfileStart(<f-args>)
command! -nargs=0 -complete=file ProfileStop call s:ProfileStop()

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
