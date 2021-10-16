local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

cmd [[
augroup run_linter
  autocmd!
  autocmd BufEnter,BufWritePost * lua require('mt.lint').lint(vim.fn.expand('<amatch>'))
  autocmd DirChanged * lua require('mt.lint').update_linters()
augroup END
]]

local lint = require'lint'

lint.linters_by_ft = {
  markdown = { 'proselint' }
}

local M = {}

function M.update_linters()
  local php_linters = {}
  if fn.executable('./vendor/bin/phpcs') == 1 then
    table.insert(php_linters, 'be_phpcs')
  end
  if fn.executable('./vendor/bin/phpmd') == 1 then
    table.insert(php_linters, 'be_phpmd')
  end
  if fn.executable('./vendor/bin/psalm') == 1 then
    table.insert(php_linters, 'be_psalm')
  end

  lint.linters_by_ft['php'] = php_linters
end

function M.lint(file)
  -- TODO generalize this if it grows
  if not file:match('/vendor/') then
    require'lint'.try_lint()
  end
end

function M.setup()

  -- TODO contribute these upstream
  local function phpcs(args)
    local pattern = [[([^:]+):(%d+):(%d+): (%l+) %- (.+)]]
    local groups = { 'file', 'line', 'start_col', 'severity', 'message' }

    vim.list_extend(args, {'-n', '--report=emacs'})

    return {
      cmd = './vendor/bin/phpcs',
      stdin = false, -- true if program receives content via stdin
      args = args,
      stream = 'stdout', -- ('stdout' | 'stderr')
      ignore_exitcode = true, -- phpcs exits with non 0 exit code
      parser = require'lint.parser'.from_pattern(pattern, groups, nil, { ['source'] = 'phpcs' }) -- file:line:col: messsage
    }
  end

  local function phpmd(args)
    return function()
      local bufname = api.nvim_buf_get_name(0)
      table.insert(args, 1, bufname)

      return {
        cmd = './vendor/bin/phpmd',
        stdin = false, -- true if program receives content via stdin
        append_fname = false, -- true if program receives content via stdin
        args = args,
        stream = 'stdout', -- ('stdout' | 'stderr')
        ignore_exitcode = true, -- phpmd exists with non 0 exit code
        -- TODO need to be able to have nullable col to convert this to a
        -- pattern (it currently requires a start_col)
        parser = require'lint.parser'.from_errorformat('%f:%l%m') -- file:line: messsage
      }
    end
  end

  local function psalm(args)
    vim.list_extend(args, {'-m', '--show-snippet=false', '--no-suggestions'})

    local pattern = [[(%u+): %a+ %- ([^:]+):(%d+):(%d+) %- (.+)]]
    local groups = { 'severity', 'file', 'line', 'start_col', 'message' }

    return {
      cmd = './vendor/bin/psalm',
      stdin = false, -- true if program receives content via stdin
      append_fname = false, -- true if program receives content via stdin
      args = args,
      stream = 'stdout', -- ('stdout' | 'stderr')
      ignore_exitcode = true,
      parser = require'lint.parser'.from_pattern(pattern, groups, nil, { ['source'] = 'psalm' }) -- file:line:col: messsage
    }
  end

  local function proselint()
    local pattern = [[([^:]+):(%d+):(%d+): (.+)]]
    local groups = { 'file', 'line', 'start_col', 'message' }

    return {
      cmd = 'proselint',
      stdin = false, -- true if program receives content via stdin
      stream = 'stdout', -- ('stdout' | 'stderr')
      parser = require'lint.parser'.from_pattern(pattern, groups, nil, { ['source'] = 'psalm' }) -- file:line:col: messsage
    }
  end

  lint.linters.phpcs = phpcs({ '--standard=PSR12' })
  lint.linters.be_phpcs = phpcs({ '--warning-severity=0', '--standard=./vendor/behance/php-sniffs/Behance' })

  lint.linters.phpmd = phpmd({ 'text', 'unusedcode,controversial' })
  lint.linters.be_phpmd = phpmd({ 'text', './vendor/behance/phpmd-rules/phpmd.xml.dist' })

  lint.linters.psalm = psalm({})
  lint.linters.be_psalm = psalm({ '--config=psalm' })

  lint.linters.proselint = proselint()

end

M.update_linters()

return M
