local should_profile = false

local loop = vim.loop

vim.g.mapleader = " "

vim.cmd [[ colorscheme rigel ]]

function RELOAD(script)
  require'plenary.reload'.reload_module(script)
end

function P(var)
  print(vim.inspect(var))
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
RELOAD('mt.quickfix')
RELOAD('mt.search')
RELOAD('mt.textobjs')
RELOAD('mt.format')

RELOAD('plugins')

REQUIRE'mt.plugins'

REQUIRE'mt.lsp' -- TODO shoudn't reload this again
REQUIRE'mt.mappings'
REQUIRE'mt.quickfix'
REQUIRE'mt.search'
REQUIRE'mt.textobjs'

REQUIRE'plugins.fern'
REQUIRE'plugins.fugitive'
REQUIRE'plugins.test'
REQUIRE'plugins.telescope'
REQUIRE'plugins.treesitter'
REQUIRE'plugins.ultisnips'
