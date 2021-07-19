local u = require('mt.utils')
local api = vim.api
local cmd = vim.cmd

vim.g.github_enterprise_urls = {
  "https://git.corp.adobe.com"
}

u.cnoreabbrev('Gds', 'Gdiffsplit')
u.cnoreabbrev('Gvs', 'Gvsplit')
u.cnoreabbrev('Gvsm', 'Gvsplit master:%')
u.cnoreabbrev('Gco', 'GBranches --locals')
u.cnoreabbrev('Gcor', 'GBranches --remotes')
u.cnoreabbrev('Gre', 'Gread master:%')
u.cnoreabbrev('Glo', 'G log -n 500')
u.cnoreabbrev('Glink', 'GBrowse')

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
