local u = require('mt.utils')

if os.getenv('SSH_CONNECTION') then
  u.nmap('<leader>y', '<Plug>OSCYank', { noremap = false })
  u.vmap('<leader>y', ':OSCYank<cr>', { noremap = false })
else
  u.nmap('<leader>y', '"+y')
  u.vmap('<leader>y', '"+y')
end
