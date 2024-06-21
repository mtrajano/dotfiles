return {
  'kylechui/nvim-surround',
  config = function()
    require('nvim-surround').setup({
      surrounds = {
        -- TODO: add delete and change
        -- TODO: how to make this line like?
        ['C'] = { -- markdown like code blocks for github, etc..
          add = function()
            local config = require('nvim-surround.config')
            local language = config.get_input('Enter language: ')

            return { { '```' .. language }, { '```' } }
          end,
        },
      },
    })

    -- NOTE: these can probably be defined outside the plugin
    vim.keymap.set('o', 'ir', 'i[')
    vim.keymap.set('o', 'ar', 'a[')
    vim.keymap.set('o', 'ia', 'i<')
    vim.keymap.set('o', 'aa', 'a<')
  end,
}
