" TODO: convert this file to lua and add surrounds
setlocal conceallevel=2
setlocal wrap

" wrap on whole words
setlocal linebreak
setlocal nolist

setlocal spell

let g:markdown_fenced_languages = ['python', 'php', 'bash']

" TODO: this needs to be added to the new surround.nvim, along with other surrounds
let b:surround_{char2nr("b")} = "**\r**"
