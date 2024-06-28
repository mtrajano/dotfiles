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
      add = { 'function() ', ' end' },
      -- TODO: can I create a delete version of this? Should be something like this but it's not working
      -- delete = '^(function%(%) )().*( end)()$',
    },
    ['P'] = {
      add = { 'P(', ')' },
    },
  },
})
