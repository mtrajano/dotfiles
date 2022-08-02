local o = vim.o
local fn = vim.fn

local lsp_installer = require("nvim-lsp-installer")

-- TODO: https://github.com/williamboman/nvim-lsp-installer/discussions/636
lsp_installer.on_server_ready(function(server)
  local function my_attach(client)
    require "lsp_signature".on_attach()
    require'lsp-status'.on_attach(client)
  end

  local opts = {
    on_attach = my_attach,
  }

  if server.name == "intelephense" then
    opts.init_options = {
      licenceKey = os.getenv('INTELEPHENSE_KEY')
    }
  end

  if server.name == "tsserver" then
    opts.on_attach = function (client)
      require "lsp_signature".on_attach()
      require'lsp-status'.on_attach(client)

      -- use null-ls for formatting
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end
  end

  if server.name == "sumneko_lua" then
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")


    opts = require("lua-dev").setup({
      lspconfig = {
        -- passes client, bufnr
        on_attach = my_attach,
        -- cmd = {sumneko_binary, "-E", sumneko_root_path:joinpath("/main.lua")};
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Setup your lua path
              path = runtime_path,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim', 'use'},
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }
    })
  end

  server:setup(opts)
end)

-- define diagnostics signs
vim.cmd [[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
]]


----------
-- KEYMAPS
----------
local function hover_or_get_docs()
  if vim.tbl_contains({'vim', 'help'}, o.filetype) then
    vim.cmd.help(fn.expand('<cword>'))
  elseif vim.tbl_contains({'sh', 'zsh'}, o.filetype) then
    vim.cmd.Man(fn.expand('<cword>'))
  else
    vim.cmd [[Lspsaga hover_doc]]
  end
end

-- mappings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc='definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc='declaration' })
vim.keymap.set('n', 'gR', function() vim.cmd.Lspsaga('rename') end)
vim.keymap.set('n', 'gr', require"mt.telescope".lsp_references, { desc = 'lsp_references' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc='implementation' })

vim.keymap.set('n', 'K', hover_or_get_docs, { desc = 'hover_or_get_docs' })
vim.keymap.set('n', '<C-f>', function() require("lspsaga.action").smart_scroll_with_saga(1) end)
vim.keymap.set('n', '<C-b>', function() require("lspsaga.action").smart_scroll_with_saga(-1) end)

-- TODO: replace these with lsp-saga
vim.keymap.set('n', '[D', vim.diagnostic.goto_prev, { desc = 'diagnostic goto_prev all' })
vim.keymap.set('n', ']D', vim.diagnostic.goto_next, { desc = 'diagnostic goto_next all' })
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({severity_limit="Warning"}) end)
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({severity_limit="Warning"}) end)
vim.keymap.set('n', '<leader>da', function() vim.cmd.Lspsaga('code_action') end)
vim.keymap.set('n', '<leader>dd', vim.cmd.Trouble, { desc = 'Trouble' })

-- coming from other plugins
vim.keymap.set('n', '<leader>k', function() require"telescope.builtin".lsp_document_symbols({ignore_filename = false, symbol_width = 35}) end, {silent=true})
vim.keymap.set('n', '<leader>K', function() require"telescope.builtin".lsp_dynamic_workspace_symbols({ignore_filename = false, previewer = false, show_line = true}) end, {silent=true})
