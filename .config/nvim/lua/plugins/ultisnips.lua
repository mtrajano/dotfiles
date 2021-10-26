local Path = require'mt.utils.path'

vim.g.UltiSnipsExpandTrigger = '<C-n>'
vim.g.UltiSnipsListSnippets = '<c-s>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-n>'
vim.g.UltiSnipsJumpBackwardTrigge = '<C-p>'

vim.g.UltiSnipsSnippetDirectories = {
  os.getenv('DOTFILES') .. '/nvim/snips'
}

function _G.NormalizeNamespace(path)
  return Path.normalize_php_namespace(path)
end
