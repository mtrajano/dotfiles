require'nvim-treesitter.configs'.setup {

  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    "php",
    "python",
    "lua"
  },

  highlight = {
    enable = true,
    disable = {}, -- breaks autoindent in php
  },

  indent = {
    enable = true,
    disable = {}, -- breaks autoindent in php
  },

  -- for debugging
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }

}
