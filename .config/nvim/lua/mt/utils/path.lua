local M = {}

-- TODO maybe this should be in a php file
function M.normalize_php_namespace(path)
  for prefix, namespace in pairs(vim.g.namespace_map or {}) do
    if string.match(path, prefix) then
      local pwd = vim.fn.getcwd()
      pwd = pwd:gsub("%p", "%%%1") -- remove special characters

      -- TODO: replace this woth plenary.path
      path = path:gsub(pwd, '') -- remove pwd from file
      path = path:gsub('^/*(.-)/*$', '%1')-- trim any /
      path = path:gsub(prefix, namespace) -- sub with composer namespace
      path = path:gsub('/', '\\') -- replace / with \

      return path
    end
  end

  -- leave namespace empty if it does not match one of the give
  return ''
end

-- TODO have this be done automatically by reading composer.json
local psr4_map_config = {}

function M.update_psr4_map(path)
  local project = path:match('/dev/(.+)')

  if not project then
    return
  end

  if psr4_map_config[project] ~= nil then
    vim.g.namespace_map = psr4_map_config[project]
  else
    vim.g.namespace_map = {}
  end
end

return M
