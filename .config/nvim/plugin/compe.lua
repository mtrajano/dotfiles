local u = require'mt.utils'

require'compe'.setup {
  source = {
    path = true,
    nvim_lsp = true,
    ultisnips = true,
    buffer = true,
  },
}

vim.o.completeopt = "menuone,noselect"
u.imap('<CR>', 'compe#confirm("<CR>")', {expr=true})

-- TODO: see if these should be moved to a more general file
vim.o.completeopt = "menuone,noselect"
vim.o.pumheight = 20
