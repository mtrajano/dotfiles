-- wrap on whole words
vim.opt_local.linebreak = true
vim.opt_local.list = false

vim.opt_local.textwidth = 0

vim.opt_local.spell = true

require('nvim-surround').buffer_setup({
  aliases = {
    ['c'] = '`', -- code
    ['b'] = '**', -- bold
    ['i'] = '_', -- italics
  },
  surrounds = {
    -- TODO: add delete and change
    ['l'] = { -- add a link
      add = function()
        local config = require('nvim-surround.config')
        local result = config.get_input('Enter link: ')
        if result then
          return { { '[' }, { '](' .. result .. ')' } }
        end
      end,
    },
  },
})
