local cmp = require'cmp'

cmp.setup({
  -- TODO: this should probably be moved to luasnip config
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(), -- TODO: see if this should be something else
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- have to hover over selection to apply
  },
  view = {
    entries = 'native'
  },
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'nvim_lsp', max_item_count = 10 }, -- NOTE: this seems very noisy
    { name = 'luasnip' },
    { name = 'buffer', max_item_count = 5 },
  })
})