vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsListSnippets = '<c-s>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigge = '<s-tab>'

vim.g.UltiSnipsSnippetDirectories = {
  os.getenv('HOME') .. '/.config/nvim/snips'
}

local behance_psr4_map = {
  ["application/services/"] = "Behance\\Network\\Services\\",
  ["application/commands/"] = "Behance\\Network\\Commands\\",
  ["application/controllers/"] = "Behance\\Network\\Controllers\\",
  ["application/queries"] = "Behance\\Network\\Queries\\",
  ["library/Network/"] = "Behance\\Network\\"
}

-- TODO: remove this from the global scope
function _G.NormalizeNamespace(path)
  for prefix, namespace in pairs(behance_psr4_map) do
    if string.match(path, prefix) then
      path = path:gsub(prefix, namespace)
      path = path:gsub('/', '\\')

      return path
    end
  end

  -- leave namespace empty if it does not match one of the give
  return ''
end
