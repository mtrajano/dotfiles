local Path = require'mt.utils.path'

vim.g.UltiSnipsExpandTrigger = '<C-j>'
vim.g.UltiSnipsListSnippets = '<C-s>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'

vim.g.UltiSnipsSnippetDirectories = {
  os.getenv('DOTFILES') .. '/nvim/snips'
}

function _G.NormalizeNamespace(path)
  return Path.normalize_php_namespace(path)
end
