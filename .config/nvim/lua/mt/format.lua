local String = require'mt.utils.string'
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

cmd [[
augroup formatting_fixes
  autocmd!
  autocmd BufWritePost *.py silent FormatWrite
augroup END
]]

local M = {}

local function ensure_final_newline()
  local line

  repeat
    line = api.nvim_buf_get_lines(0, -2, -1, false)[1]
    line = String.trim(line)

    if line == "" then
      api.nvim_buf_set_lines(0, -2, -1, false, {})
    end
  until line ~= ""
end

local function phpcs()
  local pwd = fn.getcwd()
  local bufname = fn.bufname()

  local standard = './vendor/behance/php-sniffs/Behance/ruleset.xml'
  if pwd:find('/dev/laravel%-swagger') ~= nil then
    standard = 'PSR12'
  end

  return {
    exe = './vendor/bin/phpcbf',
    args = { '--standard=' .. standard, bufname },
    stdin = false,
    ignore_exitcode = true,
  }
end

local function black()
  return {
    exe = 'black',
    stdin = false,
  }
end

require'formatter'.setup({
  filetype = {
    python = {
      black
    }
  }
})

return M
