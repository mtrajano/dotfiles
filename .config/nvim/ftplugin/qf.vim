nnoremap <buffer> <leader>r :Reject<space>
nnoremap <buffer> <leader>k :Keep<space>
vnoremap <buffer> <leader>r :Reject<cr>
vnoremap <buffer> <leader>k :Keep<cr>

" close quickfix on enter
nmap <buffer> <cr> O

" easy quickfix navigation
nnoremap <silent> <buffer> <C-o> :cold<cr>
nnoremap <silent> <buffer> <C-i> :cnew<cr>
