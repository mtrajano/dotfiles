local Path = require'mt.utils.path'

vim.g.UltiSnipsExpandTrigger = '<C-j>'
vim.g.UltiSnipsListSnippets = '<c-s>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
vim.g.UltiSnipsJumpBackwardTrigge = '<C-k>'

vim.g.UltiSnipsSnippetDirectories = {
  os.getenv('DOTFILES') .. '/nvim/snips'
}

function _G.NormalizeNamespace(path)
  return Path.normalize_php_namespace(path)
end
