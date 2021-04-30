local u = require('utils')
local fn = vim.fn
local cmd = vim.cmd

-- use ripgrep for searching
vim.g.ackprg = 'rg --vimgrep --smart-case'

-- use dispatch for non-blocking
vim.g.ack_use_dispatch = 1

-- use word under cursor on empty search
vim.g.ack_use_cword_for_empty_search = 1

u.cnoreabbrev('Ack', 'Ack!')

local M = {}

M.search_with_boundary = function(include_ignored_files)
  local optional_params = (include_ignored_files and "--no-ignore-vcs") or ""
  cmd('Ack! "\\b' .. fn.expand('<cword>') .. '\\b" -t' .. vim.bo.filetype .. " " .. optional_params)
end

u.nmap('<leader>f', ':lua require("plugins.ack").search_with_boundary(false)<cr>')
u.nmap('<leader>F', ':lua require("plugins.ack").search_with_boundary(true)<cr>') -- use with caution

return M
