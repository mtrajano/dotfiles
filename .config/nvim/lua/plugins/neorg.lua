return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
  },

  -- TODO: consider lazy loading, is the one causing the most time during startup
  {
    dir = '~/dev/nvim-plugins/neorg',
    dependencies = { 'luarocks.nvim', 'nvim-neorg/neorg-telescope' },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    config = function()
      vim.keymap.set('n', '<leader>n', function()
        if vim.bo.filetype == 'norg' then
          vim.cmd.Neorg('return')
        else
          vim.cmd.Telescope({ 'neorg', 'find_norg_files' })
        end
      end, { desc = 'Neorg find files' })

      -- Quickly switching to workspace
      vim.keymap.set('n', '<leader>jw', function()
        vim.cmd.Telescope({ 'neorg', 'switch_workspace' })
      end, { desc = 'Neorg switch workspace' })

      local neorg_callbacks = require('neorg.core.callbacks')

      neorg_callbacks.on_event('core.keybinds.events.enable_keybinds', function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode('norg', {
          n = { -- Bind keys in normal mode
            {
              keybinds.leader .. 'ss',
              'core.integrations.telescope.find_linkable',
            },
            { keybinds.leader .. 'sh', 'core.integrations.telescope.search_headings' },
            { keybinds.leader .. 'il', 'core.integrations.telescope.insert_link' },
            { keybinds.leader .. 'sf', 'core.integrations.telescope.find_norg_files' },
          },
          i = { -- Bind in insert mode
            { '<C-l>', 'core.integrations.telescope.insert_link' },
          },
        }, {
          silent = true,
          noremap = true,
        })
      end)

      require('neorg').setup({
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.dirman'] = {
            config = {
              workspaces = {
                dev = '~/notes/dev',
                pontal = '~/notes/pontal',
                personal = '~/notes/personal',
              },
              default_workspace = 'dev',
            },
          },
          ['core.completion'] = {
            config = {
              engine = 'nvim-cmp',
            },
          },
          ['core.integrations.nvim-cmp'] = {},
          ['core.text-objects'] = {},
          ['core.keybinds'] = {
            config = {
              hook = function(keybinds)
                -- NOTE: testing these
                -- Binds to move items up or down
                keybinds.remap_event('norg', 'n', '<M-up>', 'core.text-objects.item_up')
                keybinds.remap_event('norg', 'n', '<M-down>', 'core.text-objects.item_down')

                -- NOTE: testing these
                -- text objects, these binds are available as `vaH` to "visual select around a header" or
                -- `diH` to "delete inside a header"
                keybinds.remap_event('norg', { 'o', 'x' }, 'iH', 'core.text-objects.textobject.heading.inner')
                keybinds.remap_event('norg', { 'o', 'x' }, 'aH', 'core.text-objects.textobject.heading.outer')
              end,
            },
          },
          ['core.integrations.telescope'] = {},
        },
      })
    end,
  },
}
