local fn = vim.fn
local api = vim.api

vim.g.rigel_lightline = 1

vim.g.lightline = {
  colorscheme = 'rigel',
  active = {
    left = {
      { 'mode' },
      { 'gitbranch' },
      { 'truncated_relativepath', 'modified' },
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
  },
  component_type = {
    ale_warnings = 'warning',
    ale_errors = 'error',
  },
  component_function = {
    gitbranch = 'FugitiveHead',
    truncated_relativepath = 'TruncateRelativePath',
  }
}

local M = {}

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

  return 'W' .. ale_stats.warning
end

M.ale_errors = function()
  local ale_stats = fn['ale#statusline#Count'](api.nvim_get_current_buf())

  return 'E' .. ale_stats.error
end

M.lightline_modified = function()
  return (vim.bo.modified and '[+]') or (vim.bo.modifiable and '') or '[-]'
end

return M
