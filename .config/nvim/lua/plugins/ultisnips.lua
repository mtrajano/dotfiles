local Path = require'mt.utils.path'

vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsListSnippets = '<c-s>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigge = '<s-tab>'

vim.g.UltiSnipsSnippetDirectories = {
  os.getenv('DOTFILES') .. '/nvim/snips'
}

function _G.NormalizeNamespace(path)
  return Path.normalize_php_namespace(path)
end
