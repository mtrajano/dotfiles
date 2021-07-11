require'compe'.setup {
  source = {
    path = true;
    nvim_lsp = true;
    ultisnips = true;
  },
}

vim.o.completeopt = "menuone,noselect"
