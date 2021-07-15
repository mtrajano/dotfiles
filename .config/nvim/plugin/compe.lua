local u = require'mt.utils'

require'compe'.setup {
  source = {
    path = true;
    nvim_lsp = true;
    ultisnips = true;
  },
}

vim.o.completeopt = "menuone,noselect"
u.imap('<CR>', 'compe#confirm("<CR>")', {expr=true})
