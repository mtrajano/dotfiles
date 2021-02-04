" Navigate autocomplete PUM using j/k
inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <silent><expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <cr> to confirm completion (if pum is open).
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<cr>"
