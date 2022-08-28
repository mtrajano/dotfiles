local api = vim.api
local cmd = vim.cmd

local function get_git_pane_winnr()
  local winnrs = vim.api.nvim_tabpage_list_wins(0)

  for _, winnr in ipairs(winnrs) do
    local bufnr = api.nvim_win_get_buf(winnr)
    local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')

    if ft == 'fugitive' then
      return winnr
    end
  end

  return false
end

local function toggle_git_pane()
  local git_pane_winr = get_git_pane_winnr()

  if git_pane_winr then
    api.nvim_win_close(git_pane_winr, false)
  else
    cmd.Git()
  end
end

vim.keymap.set('n', '<leader>gg', toggle_git_pane, {silent=true})
vim.keymap.set('n', '<leader>gd', cmd.DiffviewOpen)
vim.keymap.set('n', '<leader>gf', cmd.DiffviewFileHistory)
vim.keymap.set('n', '<leader>gb', function() cmd.Git('blame') end)
vim.keymap.set('n', '<leader>gl', function() cmd.Git('log -n 500') end)
vim.keymap.set('n', '<leader>gr', function() cmd.Gread('master:%') end)
vim.keymap.set('n', '<leader>gs', cmd.Gw)

-- Merge conflict remaps
-- TODO only map these when inside of a merge conflict
-- nmap('<leader>gh', ':diffget //2')
-- nmap('<leader>gl', ':diffget //3')

cmd.cnoreabbrev('Gvsm', 'Gvsplit master:%')
cmd.cnoreabbrev('Gco', 'GBranches --locals')
cmd.cnoreabbrev('Gcor', 'GBranches --remotes')

-- TODO: convert to lua
api.nvim_exec([[
  command! -nargs=1 Browse exec '!open -a "Brave Browser"' fnameescape(<q-args>)
]], false)
