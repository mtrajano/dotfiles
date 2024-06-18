return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
  },

  {
    -- TODO: install neorg telescope integration
    'nvim-neorg/neorg',
    dependencies = { 'luarocks.nvim' },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    config = function()
      vim.keymap.set('n', '<leader>n', function()
        if vim.bo.filetype == 'norg' then
          vim.cmd.Neorg('return')
        else
          vim.cmd.Neorg('index')
        end
      end)

      require('neorg').setup({
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.dirman'] = {
            config = {
              workspaces = {
                dev = '~/notes/dev',
                pontal = '~/noes/pontal',
                personal = '~/noes/personal',
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
        },
      })
    end,
  },
}
