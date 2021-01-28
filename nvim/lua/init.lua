require'nvim-treesitter.configs'.setup {
  ensure_installed = {"php", "python", "javascript", "tsx", "json", "lua"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    disable = {"php"}, -- breaks autoindent in php
  },
  indent = { enable = true },
}
