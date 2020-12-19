" use ripgrep for searching
let g:ackprg = 'rg --vimgrep --smart-case'

" use word under cursor on empty search
let g:ack_use_cword_for_empty_search = 1

cnoreabbrev Ack Ack!

nnoremap <silent> <leader>f :Ack!<space>
