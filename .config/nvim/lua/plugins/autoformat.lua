return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = 'DisableAutoformat',
  config = function()
    -- TODO: add commands to only format specific lines
    -- TODO: add commands for enabling/disabling formatting for buffer only
    vim.cmd([[ command! -nargs=0 EnableAutoformat unlet g:disable_autoformat ]])
    vim.cmd([[ command! -nargs=0 DisableAutoformat let g:disable_autoformat = 1 ]])

    require('conform').setup({
      notify_on_error = false, -- turn of if gets too annoying
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_lsp_filetypes = { c = true, cpp = true }
        local ignore_filetypes = {}

        -- Disable with a global or buffer-local variable
        -- TODO: create a function that sets this
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        -- Disable autoformat on certain filetypes
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        -- Disable autoformat for files in a certain path
        -- TODO: should do this by filetype
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match('/node_modules/') then
          return
        end

        return {
          timeout_ms = 500,
          lsp_fallback = not disable_lsp_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      -- NOTE: look at the github page to see different ways to format these: https://github.com/stevearc/conform.nvim
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd' },
      },
    })
  end,
}
