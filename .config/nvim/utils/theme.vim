colorscheme rigel

" TODO move these to colors dir
highlight MatchParen guifg=#00ffff guibg=#002635
highlight CursorLineNr guifg=#f08e48
highlight ModifiedColor ctermfg=196 ctermbg=23 guifg=#c43060 guibg=#00384d term=Bold cterm=Bold gui=Bold

let s:lightline_colorscheme = g:lightline#colorscheme#rigel#palette
let s:lightline_colorscheme.normal.additions = [['#9cf087', '#00384d', 209, 235]]
let s:lightline_colorscheme.normal.modifications = [['#b7cff9', '#00384d', 209, 235]]
let s:lightline_colorscheme.normal.removals = [['#c43060', '#00384d', 209, 235]]
let g:lightline#colorscheme#rigel#palette = s:lightline_colorscheme

" fzf preview window match theme
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
