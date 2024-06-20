vim.cmd([[ setl includeexpr=substitute(v:fname,'\\.','/','g') ]])

vim.keymap.set('n', '<leader>r', function()
  vim.cmd.luafile('%')
end, {
  buffer = true,
  desc = 'Run lua file',
})

require('nvim-surround').buffer_setup({
  surrounds = {
    ['F'] = {
      -- TODO: can I create a delete version of this?
      add = { 'function() ', ' end' },
    },
    ['P'] = {
      add = { 'P(', ')' },
    },
  },
})
