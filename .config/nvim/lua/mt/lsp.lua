local o = vim.o
local fn = vim.fn

local debug = false

if debug then
  vim.lsp.set_log_level('TRACE')
end

require('mason').setup()
require('mason-tool-installer').setup({
  ensure_installed = {
    -- lsp
    'intelephense',
    'typescript-language-server',
    'lua-language-server',
    'bash-language-server',
    'json-lsp',
    'pyright',
    'css-lsp',

    'shellcheck',
    'stylua',
    'proselint',
  },
})

local lspconfig = require('lspconfig')
local lsp_signature = require('lsp_signature')

local function my_attach(client)
  lsp_signature.on_attach()
  -- PERF: seems to be causing a lot of lag in larger files, disabling for now
  -- TODO: look into this:
  --  * https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide#:~:text=Semantic%20tokenization%20allows%20language%20servers,the%20syntax%20highlighting%20from%20grammars
  --  * https://blog.jetbrains.com/pycharm/2017/01/make-sense-of-your-variables-at-a-glance-with-semantic-highlighting/
  client.server_capabilities.semanticTokensProvider = nil
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enables css autocomplete
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- for nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

lspconfig.intelephense.setup({
  capabilities = capabilities,
  on_attach = my_attach,
  init_options = {
    licenceKey = vim.env.INTELEPHENSE_KEY,
  },
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = my_attach,
})

lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = my_attach,
})

lspconfig.jsonls.setup({
  on_attach = my_attach,
  capabilities = capabilities,
  -- TODO: see if can complain about incorrect keys
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'manifest.json' },
          url = 'https://json.schemastore.org/chrome-manifest',
        },
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package',
        },
      },
      validate = {
        enable = true,
      },
    },
  },
})

lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = my_attach,
})

require('neodev').setup({})
-- example to setup sumneko and enable call snippets
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = my_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
})

-- define diagnostics signs
-- TODO: convert this to vim.diagnostic.config
-- TODO: signs in neotree are still not working correctly, might need to define this before plugin loads
vim.cmd([[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
]])

----------
-- KEYMAPS
----------
local function hover_or_get_docs()
  -- NOTE: can probably simplify these by setting 'keywordprg' for each buffer
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
-- NOTE: overwrites vim's replace mode which is like like the insert key in windows
-- I have personally never used it but if it's needed, replaces this keymap
vim.keymap.set('n', 'R', function()
  vim.cmd.Lspsaga('rename')
end, { desc = 'Saga rename' })
vim.keymap.set('n', 'gr', require('mt.telescope').lsp_references, { desc = 'lsp_references' })
vim.keymap.set('n', '<leader>di', vim.lsp.buf.implementation, { desc = 'implementation' })

-- NOTE: Cool looks like pressing this twice moves us to the hover window
vim.keymap.set('n', 'K', hover_or_get_docs, { desc = 'hover_or_get_docs' })

-- jump to diagnostics
vim.keymap.set('n', '[D', function()
  require('lspsaga.diagnostic'):goto_prev()
end, { desc = 'Diagnostic go to prev' })
vim.keymap.set('n', ']D', function()
  require('lspsaga.diagnostic'):goto_next()
end, { desc = 'Diagnostic go to next' })
vim.keymap.set('n', '[d', function()
  require('lspsaga.diagnostic'):goto_prev({ severity = { min = vim.diagnostic.severity.WARN } })
end, { desc = 'Diagnostic go to prev warning+' })
vim.keymap.set('n', ']d', function()
  require('lspsaga.diagnostic'):goto_next({ severity = { min = vim.diagnostic.severity.WARN } })
end, { desc = 'Diagnostic go to next warning+' })

vim.keymap.set('n', '<leader>da', function()
  vim.cmd.Lspsaga('code_action')
end, { desc = 'Code action' })

-- coming from other plugins
vim.keymap.set('n', '<leader>ds', function()
  require('telescope.builtin').lsp_document_symbols({ ignore_filename = false, symbol_width = 35 })
end, { silent = true, desc = 'Search document symbols' })
vim.keymap.set('n', '<leader>dw', function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols({
    ignore_filename = false,
    previewer = false,
    show_line = true,
  })
end, { silent = true, desc = 'Search workspace symbols' })
