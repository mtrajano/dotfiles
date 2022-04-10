local u = require('mt.utils')
local api = vim.api
local cmd = vim.cmd

u.nmap('<leader>gg', ':lua require("plugins.fugitive").toggle_git_pane()<cr>', {silent=true})
u.nmap('<leader>gd', ':DiffviewOpen<cr>')
u.nmap('<leader>gf', ':DiffviewFileHistory<cr>')
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
u.nmap('<leader>go', '<cmd>Telescope git_branches previewer=false<cr>')

u.cnoreabbrev('Gds', 'Gdiffsplit')
u.cnoreabbrev('Gvs', 'Gvsplit')
u.cnoreabbrev('Gvsm', 'Gvsplit master:%')
u.cnoreabbrev('Gco', 'GBranches --locals')
u.cnoreabbrev('Gcor', 'GBranches --remotes')
u.cnoreabbrev('Gre', 'Gread master:%')
u.cnoreabbrev('Glo', 'G log -n 500')
u.cnoreabbrev('Gbr', 'GBrowse')

api.nvim_exec([[
  command! -nargs=1 Browse exec '!open -a "Brave Browser"' fnameescape(<q-args>)
]], false)

local M = {}

local function get_git_pane_winnr()
  local winnrs = api.nvim_tabpage_list_wins(0)

  for _, winnr in ipairs(winnrs) do
    local bufnr = api.nvim_win_get_buf(winnr)
    local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')

    if ft == 'fugitive' then
      return winnr
    end
  end

  return false
end

function M.toggle_git_pane()
  local git_pane_winr = get_git_pane_winnr()

  if git_pane_winr then
    api.nvim_win_close(git_pane_winr, false)
  else
    cmd [[ Git ]]
  end
end

return M
