local u = require('utils')

local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

vim.g['fern#keepjumps_on_edit'] = 1
vim.g['fern#keepalt_on_edit'] = 1

local M = {}

M.fern_init = function()
  u.buf_nmap('q', ':Bd<cr>')
  u.buf_nmap('n', 'jn')
  u.buf_nmap('y', '"+:lua require("plugins.fern").relative_yank()<cr>')
  u.buf_nmap('Y', '"+<Plug>(fern-action-yank:path)', {noremap = false})
  u.buf_nmap('K', '<Plug>(fern-action-new-path)', {noremap = false})
  u.buf_nmap('<BS>', '<Plug>(fern-action-leave)', {noremap = false})

  -- fix navigation keys so they work with vim-tmux-navigator
  -- as some of them get overriden by the plugin
  u.buf_nmap('<C-L>', ':TmuxNavigateRight<cr>')
  u.buf_nmap('<C-K>', ':TmuxNavigateUp<cr>')
  u.buf_nmap('<C-J>', ':TmuxNavigateDown<cr>')
  u.buf_nmap('<C-H>', ':TmuxNavigateLeft<cr>')
end

M.relative_yank = function()
  fn['fern#mapping#call'](function(helper)
    local fern = helper.fern
    local winid = helper.winid
    local index = api.nvim_win_get_cursor(winid)[1] - 1

    local node = fn.get(fern.visible_nodes, index, nil)
    local path = fn.get(node, 'bufname', '')

    local pwd = api.nvim_exec('pwd', true)

    local relative_path = path:gsub(pwd .. '/', '')

    fn.setreg(api.nvim_eval('v:register'), relative_path)

    cmd('redraw')
    print("The node 'path' has yanked.")
  end)
end

u.nmap('<leader>h', ':keepalt Fern . -reveal=%<cr>')

return M
