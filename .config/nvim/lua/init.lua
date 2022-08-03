local should_profile = false

local loop = vim.loop

vim.g.mapleader = " "

-- TODO: remove when plugin config was moved into autoload folders
-- TODO: move any custom plugins to personal dev folder
require 'mt.plugins'

vim.g.tokyonight_style = 'night'
vim.cmd [[ colorscheme tokyonight ]]

function RELOAD(script)
  require'plenary.reload'.reload_module(script)
end

function P(...)
  print(vim.inspect(...))
end

-- require with profiling wrapped
function REQUIRE(module)
  local start
  if should_profile then start = loop.hrtime() end
  require(module)
  if should_profile then
    local time = (loop.hrtime() - start) / 1000000
    P(string.format('Loading %s took %s msec', module, time))
  end
end

require 'mt.options'
require 'mt.search'
