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
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    enabled = treesitter_enabled,
    -- NOTE: there is currently an issue having both linewise selection and the include_surrounding_whitespace option set: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/575
    -- for now I added a manual fix so don't update this plugin: /Users/mtrajano/.local/share/nvim/lazy/nvim-treesitter-textobjects/lua/nvim-treesitter/textobjects/select.lua:75
    pin = true,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = true,
    config = function()
      require('treesitter-context').setup({
        max_lines = 2,
        -- PERF: disable on large files as seems to cause longer times to open file
        on_attach = function(bufnr)
          local max_filesize = 1024 * 1024 -- 1 MB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
          if ok and stats and stats.size > max_filesize then
            return false
          end

          return true
        end,
      })
    end,
  },
}
