let g:coc_global_extensions = [
  \  'coc-tsserver',
  \  'coc-json',
  \  'coc-html',
  \  'coc-css',
  \  'coc-phpls',
  \  'coc-pyright'
  \ ]

command! -nargs=0 Do call CocAction('codeAction')
command! -nargs=? Fold call CocAction('fold')
command! -nargs=? Foldc call CocAction('fold', 'comment')
command! -nargs=? Foldi call CocAction('fold', 'imports')

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :call CocAction('jumpDefinition', v:false)<cr>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Navigate autocomplete PUM using j/k
inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <silent><expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <C-space> to confirm completion (if pum is open).
inoremap <silent><expr> <C-space> pumvisible() ? coc#_select_confirm() : "\<C-space>"

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" easier navigation through diagnostics in file
nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>dd :CocList diagnostics<cr>

" Find symbol of current document.
nnoremap <silent><nowait> <leader>k :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>K :<C-u>CocList -I symbols<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

