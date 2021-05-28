setl wrap

" wrap on whole words
setl linebreak
setl nolist

vmap <buffer> <leader>b S*gvS*
nmap <buffer> crb viw<leader>bE

source $XDG_CONFIG_HOME/nvim/utils/spell.vim
