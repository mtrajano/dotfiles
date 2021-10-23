" TODO: replace these with vim-pencil
setlocal wrap

" wrap on whole words
setlocal linebreak
setlocal nolist

source $XDG_CONFIG_HOME/nvim/utils/spell.vim
let g:markdown_fenced_languages = ['python', 'php', 'bash']

setlocal conceallevel=2

" temporary, TODO: figure out why vim-markdown syntax file isn't loading
augroup load_markdown_syntax
  autocmd VimEnter *.md ++once edit
augroup END
