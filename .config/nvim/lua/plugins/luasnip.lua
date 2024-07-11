-- TODO: look into snipmate and luasnip snippets
-- vscode ones are needed for friendly-snippets
return {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  version = 'v2.*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_snipmate').lazy_load()

    local ls = require('luasnip')

    vim.keymap.set({ 'i' }, '<C-y>', function()
      ls.expand()
    end, { silent = true })
    vim.keymap.set({ 'i', 's' }, '<C-l>', function()
      ls.jump(1)
    end, { silent = true })
    vim.keymap.set({ 'i', 's' }, '<C-h>', function()
      ls.jump(-1)
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-e>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })
  end,
  build = 'make install_jsregexp',
}
