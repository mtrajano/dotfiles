" use ripgrep for searching
let g:ackprg = 'rg --vimgrep --smart-case'

" autoclose quickfix on select
let g:ack_autoclose = 1

" use word under cursor on empty search
let g:ack_use_cword_for_empty_search = 1

" don't jump to first search
cnoreabbrev Ack Ack!

nnoremap <silent> <leader>f :Ack<space>
