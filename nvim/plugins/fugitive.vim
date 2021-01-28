nnoremap <silent> <leader>gs :G<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gb :Gblame<cr>

cnoreabbrev Gdown G pull --rebase upstream master
cnoreabbrev Gup G push --force origin
cnoreabbrev Gds Gdiffsplit
cnoreabbrev Gco G checkout

