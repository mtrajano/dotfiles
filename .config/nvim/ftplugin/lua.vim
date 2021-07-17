setl includeexpr=substitute(v:fname,'\\.','/','g')

nnoremap <buffer> <leader>sd :luafile %<cr>
