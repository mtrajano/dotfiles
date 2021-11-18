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
RELOAD('mt.format')

-- TODO: should only load this if in that directory
-- RELOAD('swagger')

-- require 'swagger'
require 'mt.plugins'

require 'mt.mappings'
require 'mt.search'

require 'plugins.fugitive'
require 'plugins.test'
require 'plugins.ultisnips'
