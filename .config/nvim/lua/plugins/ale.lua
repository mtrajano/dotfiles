local fn = vim.fn

vim.g.ale_history_enabled = 0
vim.g.ale_history_log_output = 0
vim.g.ale_disable_lsp = 1
vim.g.ale_linters_explicit = 1

vim.g.ale_lint_on_enter = 0

vim.g.ale_fixers = {
  php = {"phpcbf"}
}

vim.g.ale_linters = {
  php = {
    'phpcs',
    'phpmd',
    -- 'psalm'
  },
  lua = { 'luacheck' }
}

-- PHP
vim.g.ale_php_phpcs_standard = fn.getcwd() .. '/vendor/behance/php-sniffs/Behance/ruleset.xml'
vim.g.ale_php_phpcbf_standard = fn.getcwd() .. '/vendor/behance/php-sniffs/Behance/ruleset.xml'
vim.g.ale_php_phpmd_ruleset = fn.getcwd() .. '/vendor/behance/phpmd-rules/phpmd.xml.dist'

vim.g.ale_php_psalm_options = '--config=psalm.xml'

vim.g.ale_lua_luacheck_options = '--config=' .. os.getenv('XDG_CONFIG_HOME') .. '/luacheck/.luacheckrc'
