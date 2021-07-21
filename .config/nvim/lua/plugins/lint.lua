local api = vim.api
local cmd = vim.cmd

cmd [[
augroup run_linter
  autocmd!
  autocmd BufEnter,BufWritePost <buffer> lua require('lint').try_lint()
augroup END
]]

local lint = require'lint'

lint.linters_by_ft = {
  php = { 'phpcs', 'phpmd', 'psalm' }
}

local M = {}

function M.setup()

  -- TODO contribute these upstream

  lint.linters.phpcs = {
    cmd = './vendor/bin/phpcs',
    stdin = false, -- true if program receives content via stdin
    args = { '--report=emacs', '--warning-severity=0', '--standard=./vendor/behance/php-sniffs/Behance' },
    stream = 'stdout', -- ('stdout' | 'stderr')
    ignore_exitcode = true, -- phpcs exits with non 0 exit code
    parser = require'lint.parser'.from_errorformat('%f:%l:%c:%m') -- file:line:col: messsage
  }

  lint.linters.phpmd = function()
    local bufname = api.nvim_buf_get_name(0)

    return {
      cmd = './vendor/bin/phpmd',
      stdin = false, -- true if program receives content via stdin
      append_fname = false, -- true if program receives content via stdin
      args = { bufname, 'text', './vendor/behance/phpmd-rules/phpmd.xml.dist' },
      stream = 'stdout', -- ('stdout' | 'stderr')
      ignore_exitcode = true, -- phpmd exists with non 0 exit code
      -- TODO look into excluding whitespace before message
      parser = require'lint.parser'.from_errorformat('%f:%l%m') -- file:line: messsage
    }
  end

  lint.linters.psalm = {
      cmd = './vendor/bin/psalm',
      stdin = false, -- true if program receives content via stdin
      append_fname = false, -- true if program receives content via stdin
      args = { '--config=psalm' },
      stream = 'stdout', -- ('stdout' | 'stderr')
      ignore_exitcode = true,
      -- TODO look into excluding whitespace before message
      parser = require'lint.parser'.from_errorformat('%f:%l:%c:%t\\ -\\ %m') -- file:line:col:type - message

  }

end

return M
