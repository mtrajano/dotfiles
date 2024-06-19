vim.loader.enable()

local should_profile = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.env.DOTFILES = vim.env.HOME .. '/dotfiles/.config/nvim'

-- TODO: remove when plugin config was moved into autoload folders
-- TODO: move any custom plugins to personal dev folder
require('mt.plugins')

function RELOAD(script)
  require('plenary.reload').reload_module(script)
end

function P(...)
  print(vim.inspect(...))
end

-- require with profiling wrapped
function PROFILE(module)
  local loop = vim.loop

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

vim.api.nvim_create_autocmd('TextYankPost', {
  command = 'silent! lua vim.highlight.on_yank()',
  group = vim.api.nvim_create_augroup('highlight_on_yank', {}),
})

require('mt.options')
require('mt.search')
require('mt.lsp')
