return {
  -- Source/docs: https://github.com/Robitx/gp.nvim
  {
    'Robitx/gp.nvim',
    keys = {
      -- stylua: ignore start
      { '<leader>cc', function() vim.cmd.GpChatNew('tabnew') end, },
      { '<leader>cf', vim.cmd.GpChatFinder },
      -- stylua: ignore end
    },
    opts = {},
  },

  -- FIX: [x / ]x jump to conflict markers is conflicting with unimpaired xml motions
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    build = 'make', -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
    opts = {
      provider = 'claude',
      hints = { enabled = true }, -- TODO: disable once used to plugin
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
  },

  -- disabling copilot for now since I don't have a good workflow for it
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    enabled = false,
    config = function()
      require('copilot').setup({})
    end,
  },
}
