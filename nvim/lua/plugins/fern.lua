local u = require('utils')

local api = vim.api

vim.g['fern#keepjumps_on_edit'] = 1

-- TODO: see if this needs to be global
function _G.Init_fern()
  -- fix navigation keys so they work with vim-tmux-navigator
  u.buf_nmap('n', 'jn')

  u.buf_nmap('y', '"+<Plug>(fern-action-yank:path)', {noremap = false})
  u.buf_nmap('K', '<Plug>(fern-action-new-path)', {noremap = false})
  u.buf_nmap('<BS>', '<Plug>(fern-action-leave)', {noremap = false})

  -- some of these get overriden by the plugin
  u.buf_nmap('<C-L>', ':TmuxNavigateRight<cr>')
  u.buf_nmap('<C-K>', ':TmuxNavigateUp<cr>')
  u.buf_nmap('<C-J>', ':TmuxNavigateDown<cr>')
  u.buf_nmap('<C-H>', ':TmuxNavigateLeft<cr>')
end

api.nvim_exec([[
augroup fern-custom
  autocmd!
  autocmd FileType fern call v:lua.Init_fern()
augroup END
]], false)

u.nmap('<leader>h', ':Fern . -reveal=%<cr>')
