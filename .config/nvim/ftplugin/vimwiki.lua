local u = require('mt.utils')

-- consistent with bullets.vim and previous <C-space> is taken by tmux
u.buf_nmap('<leader>x', '<Plug>VimwikiToggleListItem', { noremap = false, })

