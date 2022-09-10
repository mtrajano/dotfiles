require('impatient')

local should_profile = false

local loop = vim.loop

vim.g.mapleader = ' '

vim.env.PACKER_PATH = vim.env.XDG_DATA_HOME .. '/nvim/site/pack/packer'
vim.env.DOTFILES = vim.env.HOME .. '/dotfiles/.config/nvim'

-- TODO: remove when plugin config was moved into autoload folders
-- TODO: move any custom plugins to personal dev folder
require('mt.plugins')

vim.g.tokyonight_style = 'night'
vim.cmd.colorscheme('tokyonight')

function RELOAD(script)
  require('plenary.reload').reload_module(script)
end

function P(...)
  print(vim.inspect(...))
end

-- require with profiling wrapped
function PROFILE(module)
  local start
  if should_profile then
    start = loop.hrtime()
  end
  require(module)
  if should_profile then
    local time = (loop.hrtime() - start) / 1000000
    P(string.format('Loading %s took %s msec', module, time))
  end
end

require('mt.options')
require('mt.search')
