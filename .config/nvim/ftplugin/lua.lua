vim.cmd([[ setl includeexpr=substitute(v:fname,'\\.','/','g') ]])

vim.keymap.set('n', '<leader>r', function()
  vim.cmd.luafile('%')
end, {
  buffer = true,
  desc = 'Run lua file',
})

require('nvim-surround').buffer_setup {
  surrounds = {
    ['F'] = {
      add = { 'function() ', ' end' },
    },
    ['P'] = {
      -- TODO: look at the other actions
      add = { 'P(', ')' }
    },
  },
}

vim.keymap.set('n', '<leader>dd', require('osv').run_this, { buffer = true, desc = 'Start debugging lua file' })
