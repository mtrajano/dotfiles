" import class skeletons
augroup import_skeleton
  autocmd!
  autocmd BufNewFile * lua require('plugins.skeletons').try_import_skeleton()
augroup END

