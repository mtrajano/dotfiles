nnoremap <silent> <leader>gk :SignifyHunkDiff<cr>
nnoremap <silent> <leader>gu :SignifyHunkUndo<cr>
nnoremap <silent> <leader>gz :SignifyFold<cr>

" gj and gk are pretty much the same as j and k but with
" different behavior on line wrap which I never use
nmap <silent> gj <plug>(signify-next-hunk)
nmap <silent> gk <plug>(signify-prev-hunk)

omap ih <plug>(signify-motion-inner-pending)
xmap ih <plug>(signify-motion-inner-visual)
omap ah <plug>(signify-motion-outer-pending)
xmap ah <plug>(signify-motion-outer-visual)

