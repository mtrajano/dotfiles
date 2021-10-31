local should_profile = false

local loop = vim.loop

vim.g.mapleader = " "

vim.cmd [[ colorscheme rigel ]]

function RELOAD(script)
  require'plenary.reload'.reload_module(script)
end

function P(...)
  print(vim.inspect(...))
end

-- TODO see if this can be integrated with vimscript's profiling
function REQUIRE(module)
  local start
  if should_profile then start = loop.hrtime() end
  require(module)
  if should_profile then
    local time = (loop.hrtime() - start) / 1000000
    P(string.format('Loading %s took %s msec', module, time))
  end
end

RELOAD('mt.mappings')
RELOAD('mt.search')
RELOAD('mt.textobjs')
RELOAD('mt.lint')
RELOAD('mt.format')
RELOAD('mt.telescope')

RELOAD('plugins')
RELOAD('swagger')

require 'swagger'
require 'mt.plugins'

require 'mt.lsp' -- TODO shoudn't reload this again
require 'mt.mappings'
require 'mt.search'
require 'mt.textobjs'
require 'mt.telescope'

require 'plugins.fugitive'
require 'plugins.lir'
require 'plugins.test'
require 'plugins.treesitter'
require 'plugins.ultisnips'
