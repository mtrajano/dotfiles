local u = require'mt.utils'

u.buf_nmap('<C-L>', ':TmuxNavigateRight<cr>')
u.buf_nmap('<C-K>', ':TmuxNavigateUp<cr>')
u.buf_nmap('<C-J>', ':TmuxNavigateDown<cr>')
u.buf_nmap('<C-H>', ':TmuxNavigateLeft<cr>')
