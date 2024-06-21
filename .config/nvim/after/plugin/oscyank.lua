if os.getenv('SSH_CONNECTION') then
  vim.keymap.set({ 'n', 'v' }, '<leader>y', '<Plug>OSCYank', { remap = true, desc = 'OscYank' })
else
  vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to clipboard' })
end

vim.keymap.set('n', '<leader>Y', '<leader>y$', { remap = true, desc = 'Copy to clipboard until EOL' })

-- maps for copying current path file to clipboard
-- TODO: how to account for ssh connection?

vim.keymap.set(
  'n',
  '<leader>yf',
  '<cmd>let @+=expand("%:t")<cr>',
  { remap = true, desc = 'Copy curent file name to clipboard' }
)
vim.keymap.set(
  'n',
  '<leader>yp',
  '<cmd>let @+=expand("%:p")<cr>',
  { remap = true, desc = 'Copy curent file absolute path to clipboard' }
)
vim.keymap.set(
  'n',
  '<leader>yl',
  '<cmd>let @+=expand("%:p") . ":" . line(".")<cr>',
  { remap = true, desc = 'Copy curent file absolute path to clipboard with line number appended' }
)
vim.keymap.set(
  'n',
  '<leader>yr',
  '<cmd>let @+=expand("%")<cr>',
  { remap = true, desc = 'Copy curent file relative path to clipboard' }
)
