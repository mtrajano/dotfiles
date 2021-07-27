local String = require'mt.utils.string'
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

-- TODO look into these autocommands
cmd [[
augroup formatting_fixes
  autocmd!
  autocmd BufWritePre * lua require'mt.format'.trim_space()
  autocmd BufWritePre *.php Format
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

local function trim_trailing_whitespace()
  cmd [[ keeppatterns %s/\s\+$//e ]]
end

-- TODO see if this can be added to the list of formatters below
-- TODO see if this can be run asynchronously in a temp buffer
function M.trim_space()
  local view = fn.winsaveview()

  trim_trailing_whitespace()
  ensure_final_newline()

  fn.winrestview(view)
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

require'formatter'.setup({
  logging = false,
  filetype = {
    php = {
      phpcs,
    }
  }
})

return M
