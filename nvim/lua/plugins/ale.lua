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
