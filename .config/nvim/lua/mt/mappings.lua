local u = require('mt.utils')

-- map escape in terminal
u.tmap('<esc>', '<C-\\><C-n>', {noremap=false})

-- TEST: keep this mapping to make more usage of undo tree but remove when used to it if not using it all that much
u.nmap('<leader>u', ':UndotreeToggle<CR>')

-- TODO move this to the skeleton plugin file when I make it into a plugin
-- Alternate file remaps
u.nmap('<leader>ec', ':Ecommand<CR>')
u.nmap('<leader>eh', ':Ehandler<CR>')
u.nmap('<leader>eq', ':Equery<CR>')
u.nmap('<leader>es', ':Esource<CR>')
u.nmap('<leader>et', ':Etest<CR>')

-- splitjoin mappings
u.nmap('<leader>sj', ':SplitjoinSplit<cr>')
u.nmap('<leader>sk', ':SplitjoinJoin<cr>')
