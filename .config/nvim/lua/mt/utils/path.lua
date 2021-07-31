local M = {}

-- TODO maybe this should be in a php file
function M.normalize_php_namespace(path)
  for prefix, namespace in pairs(vim.g.namespace_map or {}) do
    if string.match(path, prefix) then
      path = path:gsub(prefix, namespace)
      path = path:gsub('/', '\\')

      return path
    end
  end

  -- leave namespace empty if it does not match one of the give
  return ''
end


-- TODO have this be done automatically by reading composer.json
local psr4_map_config = {
  ['laravel-swagger'] = {
    ['src/'] = 'Mtrajano\\LaravelSwagger\\', 
    ['tests/unit/'] = 'Mtrajano\\LaravelSwagger\\', 
  }
}

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
