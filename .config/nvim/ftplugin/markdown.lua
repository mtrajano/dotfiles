-- wrap on whole words
vim.opt_local.linebreak = true
vim.opt_local.list = false

vim.opt_local.textwidth = 0

vim.opt_local.spell = true

require('nvim-surround').buffer_setup({
  aliases = {
    ['c'] = '`', -- code
    ['b'] = '**', -- bold
    ['i'] = '_', -- italics
  },
})
