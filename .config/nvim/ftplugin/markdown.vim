" TODO: replace these with vim-pencil
setlocal conceallevel=2
setlocal wrap

" wrap on whole words
setlocal linebreak
setlocal nolist

source $XDG_CONFIG_HOME/nvim/utils/spell.vim
let g:markdown_fenced_languages = ['python', 'php', 'bash']

" TODO: this needs to be added to the new surround.nvim, along with other surrounds
let b:surround_{char2nr("b")} = "**\r**"
