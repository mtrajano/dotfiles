let g:coc_global_extensions = [
  \  'coc-tsserver',
  \  'coc-json',
  \  'coc-html',
  \  'coc-css',
  \  'coc-phpls',
  \  'coc-pyright',
  \  'coc-lua'
  \ ]

command! -nargs=0 Do call CocAction('codeAction')
command! -nargs=? Fold call CocAction('fold')
command! -nargs=? Foldc call CocAction('fold', 'comment')
command! -nargs=? Foldi call CocAction('fold', 'imports')

" Navigate autocomplete PUM using j/k
inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <silent><expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <cr> to confirm completion (if pum is open).
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<cr>"

" Find symbol of current document.
nnoremap <silent><nowait> <leader>k :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>K :<C-u>CocList -I symbols<cr>
