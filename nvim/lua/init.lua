require'nvim-treesitter.configs'.setup {
  ensure_installed = {"php", "python", "javascript", "tsx", "json", "lua"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  indent = {
    enable = true,
    disable = {},  -- list of language that will be disabled
  }
}
