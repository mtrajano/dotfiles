" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

fun! <SID>FixTestFormat()
  let l:save = winsaveview()

  " append :void return type to any test methods missing it
  keeppatterns %s/\(public function test.\+(.*)\)\(\s\?: void\)\@!/\1 : void

  call winrestview(l:save)
endfun

command! -nargs=0 FixTest :call <SID>FixTestFormat()

