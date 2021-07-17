function RELOAD(script)
  require'plenary.reload'.reload_module(script)
end

function P(var)
  print(vim.inspect(var))
end

RELOAD('mt')
RELOAD('plugins')

require'mt.lsp'
require'mt.mappings'
require'mt.quickfix'
require'mt.search'
require'mt.statusline'
require'mt.textobjs'

require'plugins'
require'plugins.ale'
require'plugins.fern'
require'plugins.fugitive'
require'plugins.test'
require'plugins.telescope'
require'plugins.treesitter'
require'plugins.ultisnips'
