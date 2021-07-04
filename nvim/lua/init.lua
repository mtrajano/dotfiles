function RELOAD(script)
  require'plenary.reload'.reload_module(script)
end

function P(var)
  print(vim.inspect(var))
end

RELOAD('mt')
RELOAD('plugins')

require'mt.mappings'
require'mt.quickfix'
require'mt.search'
require'mt.statusline'
require'mt.textobjs'

require'plugins.ale'
require'plugins.coc'
require'plugins.fern'
require'plugins.fugitive'
require'plugins.test'
require'plugins.treesitter'
require'plugins.ultisnips'
