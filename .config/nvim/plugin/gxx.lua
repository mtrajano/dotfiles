local search_providers = {
  -- TODO: need to encode spaces and other chars
  google = 'https://www.google.com/search?q=%s',
  duckduckgo = 'https://duckduckgo.com/?q=%s',
}

local function setup(opts)
  -- TODO: add defaults
  local key = opts.search_provider
  local pattern = search_providers[key]

  if not pattern then
    -- TODO: should exit with error
    print('not supported')
  end
end

-- NOTE: remove this setup code after done testing
setup({search_provider = 'google'})

-- TODO: move this to a directory for personal dev
-- A more useful gx that adapts to the file pattern it matches with
local function map_uri(possible_uri)
  local file = vim.fn.expand('%:t')
  local extension = vim.fn.expand('%:e')

  if file == 'plugins.lua' or file == 'tmux.conf' then
    possible_uri = vim.api.nvim_get_current_line()
    possible_uri = vim.fn.trim(possible_uri)

    local package_name = possible_uri:match([['(%S+/%S+)']])
    return 'https://github.com/' .. package_name
  elseif extension == 'lua' then
    -- strip quotes
    possible_uri = possible_uri:match([[^'(.+)'$]]) or possible_uri
    possible_uri = possible_uri:match([[^"(.+)"$]]) or possible_uri
  end

  return possible_uri
end

vim.keymap.set('n', 'gx', function()
  local possible_uri = vim.fn.expand('<cWORD>')

  -- TODO: need to look into these escapes
  possible_uri = vim.fn.substitute(possible_uri, '?', '\\?', '')
  possible_uri = vim.fn.substitute(possible_uri, '&', '\\&', 'g')

  possible_uri = map_uri(possible_uri)

  -- TODO: remove this debuggin line
  print('opening: ' .. possible_uri)

  if possible_uri:match('^https://.+$') ~= nil then
    vim.fn.jobstart('open ' .. possible_uri)
  end
end, { desc = 'Custom open link' })
