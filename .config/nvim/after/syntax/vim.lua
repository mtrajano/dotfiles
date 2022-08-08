vim.keymap.set('n', '<leader>r', function()
  vim.cmd.source('%')
end, { desc = 'Source file', buffer = true })

require('nvim-surround').buffer_setup {
  delimiters = {
    pairs = {
      ['P'] = { 'P(', ')' },
    },
  },
}
