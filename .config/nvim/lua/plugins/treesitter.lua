require'nvim-treesitter.configs'.setup {

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
  },

  highlight = {
    enable = true,
    disable = {'php'}, -- breaks autoindent in php (relies on synId)
  },

  indent = {
    enable = true,
    disable = {'php'}, -- need to investigate perf issues
  },

  -- for debugging
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }

}
