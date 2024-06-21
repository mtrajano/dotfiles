vim.opt_local.conceallevel = 2

local function ensure_link_prefix(link)
  if not string.match(link, '^https://') then
    link = 'https://' .. link
  end

  return link
end

require('nvim-surround').buffer_setup({
  -- NOTE: this can be applied to other filetypes as well, ex. markdown, etc..
  aliases = {
    ['c'] = '`', -- code
    ['b'] = '*', -- bold
    ['u'] = '_', -- underscore
    ['i'] = '/', -- italics
    ['s'] = '-', -- strikethrough
  },
  surrounds = {
    -- TODO: add delete and change
    -- TODO: improve this by accounting for other types of links: path, norg file, links, etc..
    -- When doing the above it will be hard to ensure the link is properly formatted so it would porbably be better to
    -- check for the others first and just fall back to the general link
    -- TODO: how to detect link is a file? Would I have to open the file for reading?
    ['l'] = { -- add a link
      add = function()
        local config = require('nvim-surround.config')
        local result = config.get_input('Enter link: ')
        if result then
          -- TODO: move this into a util file
          result = ensure_link_prefix(result)
          return { { '{' .. result .. '}[' }, { ']' } }
        end
      end,
    },
  },
})
