let test#strategy = 'vimux'
let test#preserve_screen = 0

let test#php#phpunit#file_pattern = 'test/phpunit'
let test#php#codeception#file_pattern = 'test/codeception'

nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>ta :TestSuite<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>tv :TestVisit<cr>

