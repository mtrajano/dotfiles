function! s:goyo_enter()
  lua require('cmp').setup.buffer { sources = {} }
endfunction

function! s:goyo_leave()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
