let test#enabled_runners = ["php#phpunit"]
let test#strategy = 'vimux'
let test#preserve_screen = 0

nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>ta :TestSuite<cr>
nnoremap <leader>tl :TestLast<cr>
nnoremap <leader>tv :TestVisit<cr>

