setl includeexpr=substitute(v:fname,'\\.','/','g')

nnoremap <buffer> <leader>r :luafile %<cr>
