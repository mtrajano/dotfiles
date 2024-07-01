local function map(mode, lhs, rhs, options)
  options = options or {}
  options.buffer = true
  vim.keymap.set(mode, lhs, rhs, options)
end

map({ 'n', 'v' }, '<tab>', '=', { remap = true })

-- p for pull
map('n', 'p', function()
  vim.cmd.G('pu')
end)

-- P for push
map('n', 'P', function()
  vim.cmd.G('up')
end)

-- open gitignore instead of .git/info/exclude by default
map('n', 'gi', function()
  vim.cmd.Gsplit('.gitignore')
end)
