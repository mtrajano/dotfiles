" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

function! s:FixTestFormat()
  let l:save = winsaveview()

  " append :void return type to any test methods missing it
  keeppatterns %s/\(public function test.\+(.*)\)\(\s\?: void\)\@!/\1 : void/e

  call winrestview(l:save)
endfunction

command! -nargs=0 FixTest :call s:FixTestFormat()

" TODO maybe move to a separate function/script/command so that can be shared with
" other languages that use semicolon for statements
inoremap ;; <c-o>:norm! mmA;<cr><c-o>`m
