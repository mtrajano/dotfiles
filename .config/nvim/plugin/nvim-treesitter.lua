-- TODO: start with buffers unfolded
vim.cmd([[ set foldmethod=expr ]])
vim.cmd([[ set foldexpr=nvim_treesitter#foldexpr() ]])

require('nvim-treesitter.configs').setup {

  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'cpp',
    'query',
    'javascript',
    'json',
    'lua',
    'php',
    'python',
    'scss',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'html',
  },

  highlight = {
    enable = true,
    disable = { 'php' }, -- breaks autoindent in php (relies on synId)
  },

  indent = {
    enable = true,
    disable = {
      'php', -- need to investigate perf issues
      'python', -- seems to be broken
      'cpp', -- seems to be broken
    },
  },

  -- for debugging
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },


  autotag = {
    enable = true,
  },
}
