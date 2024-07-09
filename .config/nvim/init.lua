vim.loader.enable()

-- If having perf issues on larger files set this to false to disable plugins I found which have a perf issue
-- False disables tree sitter highlighting, todo-comments, etc
-- TODO: can we automaitcally disable these plugins when a "large file" is detected?
ENABLE_SLOW_PLUGINS = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- TODO: move any custom plugins to personal dev folder
require('mt.globals')
require('mt.options') -- load options before loading plugins
require('mt.plugins')

require('mt.lsp')
