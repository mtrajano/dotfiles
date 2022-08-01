local null_ls = require'null-ls'

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.shellcheck,
  },
  on_attach = function(client)
    -- format on save
    if client.server_capabilities.document_formatting then
      vim.cmd([[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])
    end
  end,
}
