local fn = vim.fn
local api = vim.api

vim.g.rigel_lightline = 1

vim.g.lightline = {
  colorscheme = 'rigel',
  active = {
    left = {
      { 'mode' },
      { 'gitbranch' },
      { 'git_additions', 'git_moditifications', 'git_removals' },
      { 'relativepath', 'modified' },
    },
    right = {
      { 'lineinfo' },
      { 'percent' },
      { 'ale_warnings', 'ale_errors' },
      { 'filetype' },
    },
  },
  component = {
    modified = '%#ModifiedColor#%{LightlineModified()}',
  },
  component_expand = {
    ale_warnings = 'ALEWarningCounts',
    ale_errors = 'ALEErrorCounts',
    git_additions = 'GitAdditions',
    git_moditifications = 'GitModitifications',
    git_removals = 'GitRemovals',
  },
  component_type = {
    ale_warnings = 'warning',
    ale_errors = 'error',
    git_additions = 'additions',
    git_moditifications = 'modifications',
    git_removals = 'removals',
  },
  component_function = {
    gitbranch = 'FugitiveHead',
    truncated_relativepath = 'TruncateRelativePath',
  }
}

api.nvim_exec([[
augroup update_statusline_linters
  autocmd!
  autocmd User ALELintPost call lightline#update()
augroup END
]], false)

local M = {}

-- TODO use this when less space (need to detect screen width)
M.truncated_relativepath = function()
  local resolved_path = ''
  local buf_name = fn.expand('%:t')
  local buf_dir = fn.expand('%:h')

  for match in buf_dir:gmatch('[^/]+') do
    resolved_path = resolved_path .. match:sub(1,1) .. '/'
  end

  return resolved_path .. buf_name
end

M.ale_warnings = function()
  local ale_stats = fn['ale#statusline#Count'](api.nvim_get_current_buf())

  return 'W' .. (ale_stats.warning + ale_stats.style_warning)
end

M.ale_errors = function()
  local ale_stats = fn['ale#statusline#Count'](api.nvim_get_current_buf())

  return 'E' .. (ale_stats.error + ale_stats.style_error)
end

M.lightline_modified = function()
  return (vim.bo.modified and '[+]') or (vim.bo.modifiable and '') or '[-]'
end

return M
