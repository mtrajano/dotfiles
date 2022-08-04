local null_ls = require('null-ls')

local augroup = vim.api.nvim_create_augroup('NullLsFormat', { clear = true })

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.stylua,
  },
  on_attach = function(client, bufnr)
    -- format on save
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            bufnr = bufnr,
            filter = function(source)
              return source.name == 'null-ls'
            end,
          }
        end,
      })
    end
  end,
}
