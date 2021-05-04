vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsListSnippets = '<c-s>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigge = '<s-tab>'

vim.g.UltiSnipsSnippetDirectories = {
  os.getenv('HOME') .. '/.config/nvim/snips'
}

local M = {}

-- TODO move this out of this plugin config
local psr4_map_config = {
  ["pro2-view"] = {
    ["application/actions/"] = "Behance\\Portfolio\\View\\Actions\\",
    ["application/services/"] = "Behance\\Portfolio\\View\\Services\\",
    ["application/commands/"] = "Behance\\Portfolio\\View\\Commands\\",
    ["application/queries/"] = "Behance\\Portfolio\\View\\Queries\\",
    ["application/controllers/v1/admin/"] = "Behance\\Portfolio\\View\\Controllers\\V1\\Admin\\",
    ["application/controllers/v2/admin/"] = "Behance\\Portfolio\\View\\Controllers\\V2\\Admin\\",
    ["application/controllers/v1/"] = "Behance\\Portfolio\\View\\Controllers\\V1\\",
    ["application/controllers/public"] = "Behance\\Portfolio\\View\\Controllers\\Pub\\",
    ["application/controllers/"] = "Behance\\Portfolio\\View\\Controllers\\",
    ["application/routes/slim/"] = "Behance\\Portfolio\\View\\Routes\\Slim\\",
    ["library/"] = "Behance\\Portfolio\\View\\",
    ["test/phpunit/unit/"] = "Behance\\Portfolio\\View\\"
  },
  ["be.net"] = {
    ["application/services/"] = "Behance\\Network\\Services\\",
    ["application/commands/"] = "Behance\\Network\\Commands\\",
    ["application/controllers/"] = "Behance\\Network\\Controllers\\",
    ["application/queries/"] = "Behance\\Network\\Queries\\",
    ["library/Network/"] = "Behance\\Network\\",
    ["test/phpunit/unit/Network/"] = "Behance\\Network\\"
  },
  ["nbd.php-dbal"] = {
    ["src/"] = "Behance\\NBD\\Dbal\\",
  },
  ["image-service"] = {
    ["library/Image/"] = "Behance\\Image\\",
    ["library/Image"] = "Behance\\Image\\",
    ["application/controllers/"] = "Behance\\Image\\Controllers\\",
    ["application/queries/"] = "Behance\\Image\\Queries\\",
    ["application/services/"] = "Behance\\Image\\Services\\",
    ["tests/phpunit/lib/traits/"] = "Behance\\Image\\Test\\Traits\\",
    ["tests/phpunit/"] = "Behance\\Image\\Test\\",
  },
  ["core-http"] = {
    ["src/"] = "Behance\\Core\\Http\\",
    ["tests/unit/"] = "Behance\\Core\\Http\\",
  },
  ["core-logger"] = {
    ["src/Logger/"] = "Behance\\Core\\Logger\\",
    ["tests/unit/"] = "Behance\\Core\\Logger\\",
  }
}

M.update_psr4_map = function(dir)
  local head = string.match(dir, "[^/]+$")

  if psr4_map_config[head] ~= nil then
    vim.g.behance_psr4_map = psr4_map_config[head]
  else
    vim.g.behance_psr4_map = {}
  end
end

-- TODO: remove this from the global scope and out of this plugin config
function _G.NormalizeNamespace(path)
  for prefix, namespace in pairs(vim.g.behance_psr4_map or {}) do
    if string.match(path, prefix) then
      path = path:gsub(prefix, namespace)
      path = path:gsub('/', '\\')

      return path
    end
  end

  -- leave namespace empty if it does not match one of the give
  return ''
end

return M


