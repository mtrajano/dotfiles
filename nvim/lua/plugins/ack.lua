local u = require('utils')

-- use ripgrep for searching
vim.g.ackprg = 'rg --vimgrep --smart-case'

-- use dispatch for non-blocking
vim.g.ack_use_dispatch = 1

-- use word under cursor on empty search
vim.g.ack_use_cword_for_empty_search = 1

u.cnoreabbrev('Ack', 'Ack!')
