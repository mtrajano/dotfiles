return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-cmdline', -- NOTE: looks like it breaks when native_menu is set, look into: https://github.com/hrsh7th/nvim-cmp/issues/1059
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- select true automatically applies without having to hover selection
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(), -- TODO: see if this should be something else
          c = cmp.mapping.close(),
        }),
        ['<C-n>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ['<C-p>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'nvim_lsp', max_item_count = 10 }, -- NOTE: this seems very noisy
        { name = 'luasnip' },
        { name = 'neorg' },
        { name = 'buffer', max_item_count = 5 },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline({
        -- https://github.com/hrsh7th/cmp-cmdline/issues/108
        ['<C-n>'] = { c = cmp.mapping.select_next_item() },
        ['<C-p>'] = { c = cmp.mapping.select_prev_item() },
      }),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline({
        -- https://github.com/hrsh7th/cmp-cmdline/issues/108
        ['<C-n>'] = { c = cmp.mapping.select_next_item() },
        ['<C-p>'] = { c = cmp.mapping.select_prev_item() },
      }),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
}
