local u = require('mt.utils')
local o = vim.o
local fn = vim.fn

require'lspconfig'.intelephense.setup{
  init_options = {
    licenceKey = os.getenv('INTELEPHENSE_KEY')
  }
}

local M = {}

M.hover_or_get_docs = function()
  if u.contains({'vim', 'help'}, o.filetype) then
    fn.execute('h ' .. fn.expand('<cword>'))
  else
    vim.lsp.buf.hover()
  end
end

-- mappings
u.nmap('gd', ':lua vim.lsp.buf.definition()<cr>')
u.nmap('gD', ':lua vim.lsp.buf.declaration()<cr>')
u.nmap('gr', ':lua vim.lsp.buf.rename()<cr>')
u.nmap('gR', ':lua vim.lsp.buf.references()<cr>')
u.nmap('K', ':lua require("mt.lsp").hover_or_get_docs()<cr>')

-- coming from other plugins
u.nmap('<leader>k', ':lua require"telescope.builtin".lsp_document_symbols()<cr>')

return M
