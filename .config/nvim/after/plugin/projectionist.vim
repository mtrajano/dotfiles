" TODO: this shouldn't be loading in undotree
" import class skeletons
" augroup import_skeleton
"   autocmd!
"   autocmd BufNewFile * lua require('plugins.custom.skeletons').try_import_skeleton()
" augroup END

command! -nargs=0 Cd exec 'cd ' . system('git root ' . expand('%:h'))
command! -nargs=0 Lcd exec 'lcd ' . system('git root ' . expand('%:h'))
command! -nargs=0 Tcd exec 'tcd ' . system('git root ' . expand('%:h'))
