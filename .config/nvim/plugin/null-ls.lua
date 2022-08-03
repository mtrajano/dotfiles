local null_ls = require 'null-ls'

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.diagnostics.shellcheck,
  },
  on_attach = function(client, bufnr)
    -- format on save
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(client)
              return client.name == "null-ls"
            end
          })
        end,
      })
    end
  end,
}
