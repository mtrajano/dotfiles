local Path = require'mt.utils.path'
local Logger = require'plenary.log'

vim.g.UltiSnipsExpandTrigger = '<C-j>'
vim.g.UltiSnipsListSnippets = '<C-s>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'

if os.getenv('XDG_CONFIG_HOME') then
  vim.g.UltiSnipsSnippetDirectories = {
    os.getenv('XDG_CONFIG_HOME') .. '/nvim/snips'
  }
else
  Logger.warn('Need to set XDG_CONFIG_HOME')
end

function _G.NormalizeNamespace(path)
  return Path.normalize_php_namespace(path)
end
