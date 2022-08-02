if os.getenv('SSH_CONNECTION') then
  vim.keymap.set({ 'n', 'v' }, '<leader>y', '<Plug>OSCYank', { remap = true, desc = 'OscYank' })
else
  vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
end

vim.keymap.set('n', '<leader>Y', '<leader>y$', { remap = true })
