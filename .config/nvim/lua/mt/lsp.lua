local u = require('mt.utils')
local o = vim.o
local fn = vim.fn

local lsp_installer = require("nvim-lsp-installer")

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
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
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

-- TODO: move this or see if it's still necessary
vim.cmd [[
  sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
  sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
  sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
  sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
]]


------
-- ALL
------
local M = {}

M.hover_or_get_docs = function()
  if u.contains({'vim', 'help'}, o.filetype) then
    fn.execute('h ' .. fn.expand('<cword>'))
  elseif u.contains({'sh', 'zsh'}, o.filetype) then
    fn.execute('Man ' .. fn.expand('<cword>'))
  else
    vim.cmd [[Lspsaga hover_doc]]
  end
end

-- mappings
u.nmap('gd', ':lua vim.lsp.buf.definition()<cr>')
u.nmap('gD', ':lua vim.lsp.buf.declaration()<cr>')
u.nmap('gR', ':Lspsaga rename<cr>')
u.nmap('gr', ':lua require"mt.telescope".lsp_references()<cr>')
u.nmap('gi', ':lua vim.lsp.buf.implementation()<cr>')

u.nmap('K', ':lua require("mt.lsp").hover_or_get_docs()<cr>')
u.nmap('<C-f>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>')
u.nmap('<C-b>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>')

u.nmap('[D', ':lua vim.diagnostic.goto_prev()<cr>')
u.nmap(']D', ':lua vim.diagnostic.goto_next()<cr>')
u.nmap('[d', ':lua vim.diagnostic.goto_prev({severity_limit="Warning"})<cr>')
u.nmap(']d', ':lua vim.diagnostic.goto_next({severity_limit="Warning"})<cr>')
u.nmap('<leader>da', ':Lspsaga code_action<cr>')
u.nmap('<leader>dd', ':Trouble<cr>')

-- coming from other plugins
u.nmap('<leader>k', ':lua require"telescope.builtin".lsp_document_symbols({ignore_filename = false, symbol_width = 35})<cr>', {silent=true})
u.nmap('<leader>K', ':lua require"telescope.builtin".lsp_dynamic_workspace_symbols({ignore_filename = false, previewer = false, show_line = true})<cr>', {silent=true})

return M
