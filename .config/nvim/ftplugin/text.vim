" TODO maybe this stuff should live in the spell script as well (name it something else)
setl wrap
setl linebreak
setl nolist

" COMBAK
" maybe make these into functions?
" or make firefox a command abbrev so I can open it for other things?
nnoremap <silent> <leader>D :!open -a Firefox https://www.dictionary.com/browse/<C-r>=expand('<cword>')<cr> &<cr>
nnoremap <silent> <leader>T :!open -a Firefox https://www.thesaurus.com/browse/<C-r>=expand('<cword>')<cr> &<cr>

" TODO try to install this https://github.com/languagetool-language-server/languagetool-languageserver
