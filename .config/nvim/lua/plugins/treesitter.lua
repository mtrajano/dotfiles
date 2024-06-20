local treesitter_enabled = true

return {
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = treesitter_enabled,
    build = ':TSUpdate',
    config = function()
      require('mt.plugins.nvim-treesitter')
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', enabled = treesitter_enabled },
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = treesitter_enabled,
    config = function()
      require('treesitter-context').setup({
        max_lines = 2,
      })
    end,
  },
}
