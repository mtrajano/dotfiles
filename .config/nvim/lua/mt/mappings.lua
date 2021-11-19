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

-- Fugitive remaps
u.nmap('<leader>gg', ':lua require("plugins.fugitive").toggle_git_pane()<cr>', {silent=true})
u.nmap('<leader>gd', ':G diff<cr>')
u.nmap('<leader>gb', ':G blame<cr>')
u.nmap('<leader>gl', ':G log -n 500<cr>')
u.nmap('<leader>ga', ':Gw<cr>')
-- Merge conflict remaps
-- TODO only map these when inside of a merge conflict
-- u.nmap('<leader>gh', ':diffget //2')
-- u.nmap('<leader>gl', ':diffget //3')
-- Signify remaps
u.nmap('<leader>gk', ':SignifyHunkDiff<cr>')
u.nmap('<leader>gu', ':SignifyHunkUndo<cr>')
u.nmap('<leader>gz', ':SignifyFold<cr>')

-- splitjoin mappings
u.nmap('<leader>sj', ':SplitjoinSplit<cr>')
u.nmap('<leader>sk', ':SplitjoinJoin<cr>')
