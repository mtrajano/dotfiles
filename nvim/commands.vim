" TODO status lines functions, move these somewhere else
function! TruncateRelativePath() abort
  return luaeval('require("mt.statusline").truncated_relativepath()')
endfunction

function! ALEWarningCounts() abort
  return luaeval('require("mt.statusline").ale_warnings()')
endfunction

function! ALEErrorCounts() abort
  return luaeval('require("mt.statusline").ale_errors()')
endfunction

function! GitAdditions() abort
  let l:additions = sy#repo#get_stats()
  if l:additions[0] <= 0
    return ''
  endif
  return '+' . l:additions[0]
endfunction

function! GitModitifications() abort
  let l:modifications = sy#repo#get_stats()
  if l:modifications[1] <= 0
    return ''
  endif
  return '!' . l:modifications[1]
endfunction

function! GitRemovals() abort
  let l:removals = sy#repo#get_stats()
  if l:removals[2] <= 0
    return ''
  endif
  let l:removals = sy#repo#get_stats()
  return '-' . l:removals[2]
endfunction

function! LightlineModified() abort
  return luaeval('require("mt.statusline").lightline_modified()')
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

command! -nargs=0 GetSynName echo synIDattr(synID(line('.'), col('.'), v:true), 'name')

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

function! s:GoToResult()
  " normal '<cr>'
  echom "done"
endfunction

" TEST
" TODO move this to a file specific for work scripts
function! s:FindService()
  " hack
  au QuickFixCmdPost ++once echom "done"

  normal "-yi'
  let s:service = @-
  " let s:service = escape(s:service, '.')

  " echo "Ack \"\\$container['" . s:service . "'] = \" -Fs -g '*Services\\.php'"
  execute "Ack \"\\$container['" . s:service . "'] = \" -Fs -g '*Services\\.php'"
  " normal zz
endfunction
command! -nargs=0 FindService call s:FindService()

augroup autopair_edit
  autocmd!
  autocmd FileType php let b:AutoPairs = AutoPairsDefine({}, ['<?', '<?php'])
augroup END

augroup source_commands
  autocmd!
  " default
  au BufEnter * nnoremap <silent> <leader>sd :source $MYVIMRC <bar> echo "reloaded"<cr>

  au BufEnter *.lua nnoremap <leader>sd :luafile %<cr>
  au BufEnter *.vim nnoremap <leader>sd :source %<cr>
augroup END
