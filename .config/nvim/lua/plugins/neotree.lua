-- TODO: some missing functionality:
--  * cd, tcd, lcd actions
--  * copy path: absolute, relative
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    vim.keymap.set('n', '\\', function()
      vim.cmd.Neotree({ 'reveal', 'reveal_force_cwd=true' })
    end, { desc = 'NeoTree reveal' })

    require('neo-tree').setup({
      filesystem = {
        hijack_netrw_behavior = 'open_current',
        filtered_items = {
          hide_dotfiles = false,
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
            ['l'] = 'open',
            ['h'] = 'close_node',
          },
        },
      },
    })
  end,
}
