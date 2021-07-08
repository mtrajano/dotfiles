local u = require('mt.utils')

require'lspconfig'.intelephense.setup{
  init_options = {
    licenceKey = os.getenv('INTELEPHENSE_KEY')
  }
}

-- mappings
u.nmap('gd', ':lua vim.lsp.buf.definition()<cr>')
u.nmap('gD', ':lua vim.lsp.buf.declaration()<cr>')
u.nmap('gr', ':lua vim.lsp.buf.rename()<cr>')
u.nmap('gR', ':lua vim.lsp.buf.references()<cr>')
u.nmap('K', ':lua vim.lsp.buf.hover()<cr>')

-- coming from other plugins
u.nmap('<leader>k', ':lua require"telescope.builtin".lsp_document_symbols()<cr>')
