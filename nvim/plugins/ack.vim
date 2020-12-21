" use ripgrep for searching
let g:ackprg = 'rg --vimgrep --smart-case -F'

" use dispatch for non-blocking
let g:ack_use_dispatch = 1

" use word under cursor on empty search
let g:ack_use_cword_for_empty_search = 1

cnoreabbrev Ack Ack!

nnoremap <leader>f :Ack!<space>
