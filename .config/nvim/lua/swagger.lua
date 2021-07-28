local bo = vim.o
local cmd = vim.cmd
local lint = require'lint'

cmd [[
augroup swagger_config
  au!
  au BufEnter $HOME/dev/laravel-swagger/* lua require('swagger').swagger_config()
augroup END
]]

local M = {}

function M.swagger_config()
  bo.tabstop=4
  bo.softtabstop=4
  bo.shiftwidth=4

  -- set linters
  lint.linters_by_ft = {
    php = { 'phpcs', 'phpmd', 'psalm' }
  }
end

return M
