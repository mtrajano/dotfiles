local u = require('mt.utils')
local o = vim.o
local fn = vim.fn

------
-- PHP
------
require'lspconfig'.intelephense.setup{
  init_options = {
    licenceKey = os.getenv('INTELEPHENSE_KEY')
  }
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
        globals = {'vim'},
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
