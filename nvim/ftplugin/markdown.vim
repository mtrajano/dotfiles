setl wrap

" wrap on whole words
setl linebreak
setl nolist

vmap <buffer> <leader>b S*gvS*
nmap <buffer> crb viw<leader>bE

" TODO eventually move this to a spell script/function that captures all of this functionality
setl spell
" TODO see wether it's better to map s/S to autofix spelling see `:h spell-quickstar` for the distinction
nnoremap <buffer> [S [s1z=
nnoremap <buffer> ]S ]s1z=
