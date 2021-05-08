require'plenary.reload'.reload_module('mappings')
require'plenary.reload'.reload_module('statusline')
require'plenary.reload'.reload_module('utils')
require'plenary.reload'.reload_module('plugins')

require'mappings'
require'statusline'
require'textobjs'

require'plugins.ale'
require'plugins.coc'
require'plugins.fern'
require'plugins.fugitive'
require'plugins.search'
require'plugins.test'
require'plugins.treesitter'
require'plugins.ultisnips'
