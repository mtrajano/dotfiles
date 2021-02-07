local fn = vim.fn

vim.g.ale_fixers = {
  php = {"phpcbf"}
}

vim.g.ale_linters = {
  php = {
    'intelephense',
    'phpcs',
    'phpmd',
    'psalm'
  }
}

vim.g.ale_php_phpcs_standard = fn.getcwd() .. '/vendor/behance/php-sniffs/Behance/ruleset.xml'
vim.g.ale_php_phpcbf_standard = fn.getcwd() .. '/vendor/behance/php-sniffs/Behance/ruleset.xml'
vim.g.ale_php_phpmd_ruleset = fn.getcwd() .. '/vendor/behance/phpmd-rules/phpmd.xml.dist'

vim.g.ale_php_psalm_options = fn.getcwd() .. '--config=psalm.xml'
