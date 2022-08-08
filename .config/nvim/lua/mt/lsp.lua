local o = vim.o
local fn = vim.fn

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {
    'intelephense',
    'tsserver',
    'sumneko_lua',
    'bashls',
    'jsonls',
  },
}

local lspconfig = require('lspconfig')

local function my_attach(client)
  require('lsp_signature').on_attach()
  require('lsp-status').on_attach(client)
end

lspconfig.intelephense.setup {
  on_attach = my_attach,
  init_options = {
    licenceKey = os.getenv('INTELEPHENSE_KEY'),
  },
}

lspconfig.tsserver.setup {
  on_attach = my_attach,
}

lspconfig.jsonls.setup {
  on_attach = my_attach,
}

local luadev = require('lua-dev').setup {}
lspconfig.sumneko_lua.setup(luadev)

-- define diagnostics signs
vim.cmd([[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
]])

----------
-- KEYMAPS
----------
local function hover_or_get_docs()
  if vim.tbl_contains({ 'vim', 'help' }, o.filetype) then
    vim.cmd.help(fn.expand('<cword>'))
  elseif vim.tbl_contains({ 'sh', 'zsh' }, o.filetype) then
    vim.cmd.Man(fn.expand('<cword>'))
  else
    vim.cmd([[Lspsaga hover_doc]])
  end
end

-- mappings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'declaration' })
vim.keymap.set('n', 'R', function()
  vim.cmd.Lspsaga('rename')
end)
vim.keymap.set('n', 'gr', require('mt.telescope').lsp_references, { desc = 'lsp_references' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'implementation' })

vim.keymap.set('n', 'K', hover_or_get_docs, { desc = 'hover_or_get_docs' })
vim.keymap.set('n', '<C-f>', function()
  require('lspsaga.action').smart_scroll_with_saga(1)
end)
vim.keymap.set('n', '<C-b>', function()
  require('lspsaga.action').smart_scroll_with_saga(-1)
end)

-- jump to diagnostics
vim.keymap.set('n', '[D', function()
  require('lspsaga.diagnostic').goto_prev()
end, { desc = 'Diagnostic go to prev' })
vim.keymap.set('n', ']D', function()
  require('lspsaga.diagnostic').goto_next()
end, { desc = 'Diagnostic go to next' })
vim.keymap.set('n', '[d', function()
  require('lspsaga.diagnostic').goto_prev {
    severity = { min = vim.diagnostic.severity.WARN },
  }
end, { desc = 'Diagnostic go to prev warning+' })
vim.keymap.set('n', ']d', function()
  require('lspsaga.diagnostic').goto_next {
    severity = { min = vim.diagnostic.severity.WARN },
  }
end, { desc = 'Diagnostic go to next warning+' })

vim.keymap.set('n', '<leader>da', function()
  vim.cmd.Lspsaga('code_action')
end)

-- coming from other plugins
vim.keymap.set('n', '<leader>k', function()
  require('telescope.builtin').lsp_document_symbols { ignore_filename = false, symbol_width = 35 }
end, { silent = true })
vim.keymap.set('n', '<leader>K', function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols {
    ignore_filename = false,
    previewer = false,
    show_line = true,
  }
end, { silent = true })
