local u = require('mt.utils')

local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

vim.g['fern#keepjumps_on_edit'] = 1
vim.g['fern#keepalt_on_edit'] = 1

local M = {}

M.fern_init = function()
  u.buf_nmap('q', ':Bd<cr>') -- quit
  u.buf_nmap('n', ':keepjumps normal! n<cr>') -- fix next match
  u.buf_nmap('N', ':keepjumps normal! N<cr>') -- fix prev match

  u.buf_nmap('r', '"+<Plug>(fern-action-reload:all)', {noremap = false})
  u.buf_nmap('y', '"+:lua require("plugins.fern").relative_yank()<cr>') -- relative yank to clipboard
  u.buf_nmap('Y', '"+<Plug>(fern-action-yank:path)', {noremap = false}) -- absolute yank to clipboard
  u.buf_nmap('K', '<Plug>(fern-action-new-path)', {noremap = false}) -- new path
  u.buf_nmap('<BS>', '<Plug>(fern-action-leave)', {noremap = false}) -- go to parent root
  u.buf_nmap('<tab>', '-', {noremap = false}) -- tab for mark
  u.buf_vmap('<tab>', '-', {noremap = false}) -- tab for mark

  -- fix navigation keys so they work with vim-tmux-navigator
  -- as some of them get overriden by the plugin
  u.buf_nmap('<C-L>', ':TmuxNavigateRight<cr>')
  u.buf_nmap('<C-K>', ':TmuxNavigateUp<cr>')
  u.buf_nmap('<C-J>', ':TmuxNavigateDown<cr>')
  u.buf_nmap('<C-H>', ':TmuxNavigateLeft<cr>')

  u.buf_nmap('L', '<Plug>(fern-action-lcd:cursor)', {noremap = false})
  u.buf_nmap('T', '<Plug>(fern-action-tcd:cursor)', {noremap = false})
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
