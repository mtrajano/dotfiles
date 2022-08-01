vim.keymap.set('n', 'gx', function()
  local possible_uri = vim.fn.expand('<cWORD>')

  -- TODO: need to look into these escapes
  possible_uri = vim.fn.substitute(possible_uri, '?', '\\?', '')
  possible_uri = vim.fn.substitute(possible_uri, '&', '\\&', 'g')

  -- TODO: add check for web pattern
  if possible_uri ~= '' then
    vim.fn.jobstart('open ' .. possible_uri)
  end
end)
