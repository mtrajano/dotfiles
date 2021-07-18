local u = require('mt.utils')
local o = vim.o
local fn = vim.fn
local cmd = vim.cmd

cmd [[
augroup update_function_status
  autocmd!
  autocmd CursorHold,BufEnter <buffer> lua require'lsp-status'.update_current_function()
augroup END
]]

local function my_attach(client)
  require "lsp_signature".on_attach()
  require'lsp-status'.on_attach(client)
end

------
-- PHP
------
require'lspconfig'.intelephense.setup{
  -- passes client, bufnr
  on_attach = my_attach,
  init_options = {
    licenceKey = os.getenv('INTELEPHENSE_KEY')
  }
}

--------
-- JS/TS
--------
require'lspconfig'.tsserver.setup {
  on_attach = my_attach,
}

------
-- LUA
------
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end
-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require'lspconfig'.sumneko_lua.setup {
  -- passes client, bufnr
  on_attach = my_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
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

--------
-- C/C++
--------
require'lspconfig'.clangd.setup {
  on_attach = my_attach,
}

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
u.nmap('<leader>K', ':lua require"telescope.builtin".lsp_dynamic_workspace_symbols({ignore_filename = true})<cr>')

return M
