augroup fern-custom
  autocmd!
  autocmd FileType fern lua require('plugins.fern').fern_init()
augroup END
