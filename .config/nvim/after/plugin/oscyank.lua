if os.getenv('SSH_CONNECTION') then
  vim.keymap.set({ 'n', 'v' }, '<leader>y', '<Plug>OSCYank', { remap = true, desc = 'OscYank' })
else
  vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to clipboard' })
end

vim.keymap.set('n', '<leader>Y', '<leader>y$', { remap = true, desc = 'Copy to clipboard until EOL' })
