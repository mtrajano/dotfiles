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

if exists('g:namespace_map') == 0
  lua require('mt.utils.path').update_psr4_map(vim.fn.getcwd())
endif

augroup update_namespace_map
  au!
  au DirChanged * lua require('mt.utils.path').update_psr4_map(vim.fn.getcwd())
augroup END
augroup END
