local ls = require('luasnip')

return {
  ls.parser.parse_snippet('cn', vim.fn.expand('%:t:r'))
}
