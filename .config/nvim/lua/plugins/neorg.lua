return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
  },

  {
    -- TODO: install neorg telescope integration
    -- TODO: add neorg cmp integration
    'nvim-neorg/neorg',
    dependencies = { 'luarocks.nvim' },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    config = function()
      vim.keymap.set('n', '<leader>n', function()
        local bufnr = vim.fn.bufnr()
        if vim.bo[bufnr].filetype == 'norg' then
          vim.cmd.Neorg('return')
        else
          vim.cmd.Neorg('index')
        end
      end)

      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.dirman'] = {
            config = {
              workspaces = {
                dev = '~/notes/dev',
                pontal = '~/noes/pontal',
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
        },
      }
    end,
  },
}
