-- TODO: this shouldn't always be `expr`, for example vim files with markers
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
    'markdown',
    'norg',
  },

  highlight = {
    enable = true,
    disable = { 'php' }, -- breaks autoindent in php (relies on synId)
  },

  indent = {
    enable = false, -- still seems to be pretty buggy
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
