return {

  -- TODO: see if can get rid of this dependency now that lazy supports lua rocks deps
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
      --------------
      -- KEYBINDINGS
      --------------
      -- FIX: gO to open TOC is broken
      vim.keymap.set('n', '<leader>jn', function()
        vim.cmd.Telescope({ 'neorg', 'find_norg_files' })
      end, { desc = 'Neorg find files' })

      -- Quickly switching to workspace
      vim.keymap.set('n', '<leader>jw', function()
        vim.cmd.Telescope({ 'neorg', 'switch_workspace' })
      end, { desc = 'Neorg switch workspace' })

      vim.api.nvim_create_autocmd('Filetype', {
        pattern = 'norg',
        callback = function()
          vim.keymap.set('n', '<localleader>q', function()
            vim.cmd.Neorg('return')
          end)

          -- telescope
          vim.keymap.set('i', '<C-l>', '<Plug>(neorg.telescope.insert_link)', { buffer = true })
          vim.keymap.set('n', '<localleader>ss', '<Plug>(neorg.telescope.find_linkable)', { buffer = true })
          vim.keymap.set('n', '<localleader>sh', '<Plug>(neorg.telescope.search_headings)', { buffer = true })
          vim.keymap.set('n', '<localleader>il', '<Plug>(neorg.telescope.insert_link)', { buffer = true })

          -- text objects
          vim.keymap.set('n', '<up>', '<Plug>(neorg.text-objects.item-up)')
          vim.keymap.set('n', '<down>', '<Plug>(neorg.text-objects.item-down)')
          vim.keymap.set({ 'o', 'x' }, 'iH', '<Plug>(neorg.text-objects.textobject.heading.inner)')
          vim.keymap.set({ 'o', 'x' }, 'aH', '<Plug>(neorg.text-objects.textobject.heading.outer)')
        end,
      })

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
                journal = '~/notes/journal',
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
          ['core.integrations.telescope'] = {},
          ['core.ui.calendar'] = {},
          ['core.journal'] = {
            config = {
              workspace = 'journal',
            },
          },
        },
      })
    end,
  },
}
