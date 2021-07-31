local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

local M = {}

local function get_skeleton_path()
  local skeleton_path = nil
  for _, value in pairs(fn['projectionist#query_scalar']('skeleton')) do
    skeleton_path = value
    break
  end

  return skeleton_path
end

local function escape_slashes(string)
  return fn.substitute(string, '\\', [[\\\\]], 'ge')
end

local function normalize_namespace(path)
  local normalized_path = require'mt.utils.path'.normalize_php_namespace(path)

  return escape_slashes(normalized_path)
end

local function perform_substitutions()
  local subs_table = {
    ['{{year}}'] = function() return os.date('%Y') end,
    ['{{namespace}}'] = function() return normalize_namespace(fn.expand('%:h')) end,
    ['{{parent_namespace}}'] = function() return normalize_namespace(fn.expand('%:h:h')) end,
    ['{{class_name}}'] = function() return fn.expand('%:t:r') end
  }

  for sub, action in pairs(subs_table) do
    cmd('%s/' .. sub .. '/' .. action() .. '/ge')
  end
end

M.try_import_skeleton = function()
  local skeleton_path = get_skeleton_path()

  if skeleton_path ~= nil then
    cmd(string.format('keepalt 0read %s', skeleton_path))
  end

  perform_substitutions()

  -- remove last empty line
  api.nvim_buf_set_lines(api.nvim_get_current_buf(), -2, -1, true, {})

  -- move to insert position
  fn.search('$0')
  fn.feedkeys('cc')
end

-- manually import skeleton
cmd [[ command! -nargs=0 SI lua require('plugins.skeletons').try_import_skeleton() ]]

return M
