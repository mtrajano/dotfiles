-- disable text width for certain file types
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'Avante', 'AvanteInput' },
  callback = function()
    vim.keymap.set('n', '<localleader>q', function()
      vim.cmd.quit()
    end, { buffer = true })
  end,
})
