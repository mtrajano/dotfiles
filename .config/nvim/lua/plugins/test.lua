local u = require('mt.utils')

vim.g['test#strategy'] = 'floaterm'
vim.g['test#preserve_screen'] = 0

vim.g['test#php#phpunit#file_pattern'] = 'Test.php'
vim.g['test#php#codeception#file_pattern'] = 'test/codeception'

u.nmap('<leader>tn', ':TestNearest<CR>')
u.nmap('<leader>tf', ':TestFile<CR>')
u.nmap('<leader>ta', ':TestSuite<CR>')
u.nmap('<leader>tl', ':TestLast<CR>')
u.nmap('<leader>tv', ':TestVisit<CR>')

-- floatterm
vim.g.floaterm_keymap_toggle = '<leader>tt'
vim.g.floaterm_keymap_kill = '<leader>tk'
vim.g.floaterm_height = 0.9
vim.g.floaterm_width = 0.9

