vim.opt_local.conceallevel = 2

-- NOTE: this can be applied to other filetypes as well, ex. markdown, etc..
require('nvim-surround').buffer_setup({
  aliases = {
    ['c'] = '`',
    ['b'] = '*',
    ['u'] = '_',
    ['i'] = '/',
    ['s'] = '-',
  },
})
