local should_profile = false

vim.env.DOTFILES = vim.env.HOME .. '/dotfiles/.config/nvim'

function RELOAD(script)
  require('plenary.reload').reload_module(script)
end

function P(...)
  print(vim.inspect(...))
end

-- require with profiling wrapped
function PROFILE_REQUIRE(module)
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
