local cmd = vim.cmd

local function get_git_pane_winnr()
  local winnrs = vim.api.nvim_tabpage_list_wins(0)

  for _, winnr in ipairs(winnrs) do
    local bufnr = vim.api.nvim_win_get_buf(winnr)

    if vim.bo[bufnr].filetype == 'fugitive' then
      return winnr
    end
  end

  return false
end

local function toggle_git_pane()
  local git_pane_winr = get_git_pane_winnr()

  if git_pane_winr then
    vim.api.nvim_win_close(git_pane_winr, false)
  else
    cmd.Git()
  end
end

vim.keymap.set('n', '<leader>gg', toggle_git_pane, { silent = true, desc = 'Toggle git pane' })
vim.keymap.set('n', '<leader>gd', cmd.DiffviewOpen, { desc = 'Diffview Open'})
vim.keymap.set('n', '<leader>gf', cmd.DiffviewFileHistory, { desc = 'Diffview file history'})
vim.keymap.set('n', '<leader>gb', function() cmd.Git('blame') end, { desc = 'Git blame'})
vim.keymap.set('n', '<leader>gl', function() cmd.Git('log -n 500') end, { desc = 'Git log'})
vim.keymap.set('n', '<leader>gr', function() cmd.Gread('master:%') end, { desc = 'Gread master:%'})
vim.keymap.set('n', '<leader>gs', cmd.Gw, { desc = 'Gwrite'})
vim.keymap.set('n', '<leader>ge', cmd.Gedit, { desc = 'Gedit'})

vim.keymap.set('n', '<leader>gco', function()
  cmd.Telescope('git_branches')
end, { desc = 'Git checkout branch'})

-- Merge conflict remaps
-- TODO only map these when inside of a merge conflict
vim.keymap.set('n', '<leader>g<', ':diffget //2', { desc = 'Diffget take left (mergeconflict)'})
vim.keymap.set('n', '<leader>g>', ':diffget //3', { desc = 'Diffget take right (mergeconflict)'})

cmd.cnoreabbrev('Gvsm', 'Gvsplit master:%')
cmd.cnoreabbrev('Gco', 'GBranches --locals')
cmd.cnoreabbrev('Gcor', 'GBranches --remotes')

vim.api.nvim_create_user_command('Browse', function(args)
  vim.ui.open(args.args)
end, {
  desc = 'Enables using GBrowse without netrw',
  force = true,
  nargs = 1,
})
