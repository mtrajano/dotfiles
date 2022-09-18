-- TODO: see if this can be converted to a proper plugin
-- TODO: send these to telescope instead of quickfix
-- TODO: input for search path with the cwd as the default
-- TODO: remove ack dep
local g = vim.g
local o = vim.o
local fn = vim.fn
local cmd = vim.cmd

local special_chars = { '.', '{', '}', '[', ']', '(', ')', '-', '+', '*', '?', '^', '$', '#', '-' }

-- use ripgrep for searching
g.ackprg = 'rg --vimgrep --smart-case --color never'

-- use dispatch for non-blocking
g.ack_use_dispatch = 1

-- use word under cursor on empty search
g.ack_use_cword_for_empty_search = 1

local function escape_special_chars(word)
  for _, val in ipairs(special_chars) do
    word = word:gsub('%' .. val, '\\%1')
  end

  return word
end

local function include_file_globs(filetype)
  local filetype_to_glob = {
    php = { "'!*Test.php'" },
  }

  local glob_param = ''

  if filetype_to_glob[filetype] ~= nil then
    for _, glob in ipairs(filetype_to_glob[filetype]) do
      glob_param = glob_param .. ' -g ' .. glob
    end
  end

  return glob_param
end

local function resolve_types(filetype)
  local type_overrides = {
    javascript = { 'js', 'ts' },
    lua = { 'lua' },
    php = { 'php' },
    typescript = { 'js', 'ts' },
    typescriptreact = { 'js', 'ts' },
    vue = { 'js', 'ts' },
  }

  local search_filetypes = {}

  if type_overrides[filetype] ~= nil then
    search_filetypes = type_overrides[filetype]
  end

  local search_param = ''
  for _, ft in ipairs(search_filetypes) do
    search_param = search_param .. ' -t' .. ft
  end

  return search_param
end

-- @class opts
-- @field ignore      : Dont respect version control ignore files
-- @field boundary     : Add a word boundary around the search term
-- @field include_ft   : Search within same filetype
-- @field include_cwd   : Append the present working directory to the search
local function get_search_args(raw_term, opts)
  opts = opts or {}

  local optional_params = (opts.ignore and ' --no-ignore-vcs') or ''
  optional_params = optional_params .. ((opts.boundary and ' --word-regexp') or '')

  if opts.include_ft then
    optional_params = optional_params .. resolve_types(o.filetype) .. include_file_globs(o.filetype)
  end

  local search_term = ''
  if raw_term then
    search_term = escape_special_chars(raw_term)
  end

  local search = search_term .. optional_params

  if opts.include_cwd then
    search = search .. ' ' .. fn.getcwd()
  end

  return search
end

-- @class opts
-- @field ignore      : Dont respect version control ignore files
-- @field boundary     : Add a word boundary around the search term
-- @field include_ft   : Search within same filetype
-- @field include_cwd   : Append the present working directory to the search
local function get_search_opts(opts)
  local default_opts = {
    ignore = false,
    boundary = true,
    include_ft = true,
    -- TODO: change this to include_root, path should be git root
    include_cwd = true,
  }

  if opts then
    default_opts = vim.tbl_extend('force', default_opts, opts)
  end

  return default_opts
end

-- @class opts
-- @field ignore      : Dont respect version control ignore files
-- @field boundary     : Add a word boundary around the search term
-- @field include_ft   : Search within same filetype
-- @field include_cwd   : Append the present working directory to the search
local function search_normal(opts)
  opts = get_search_opts(opts)

  local search_word = fn.expand('<cword>')

  cmd('Ack!' .. get_search_args(search_word, opts))

  if opts.boundary then
    search_word = '\\<' .. search_word .. '\\>'
  end

  fn.setreg('/', search_word) -- to make highlight search term work with word boundaries
end

-- @class opts
-- @field ignore      : Dont respect version control ignore files
-- @field boundary     : Add a word boundary around the search term
-- @field include_ft   : Search within same filetype
-- @field include_cwd   : Append the present working directory to the search
local function search_visual(opts)
  opts = get_search_opts(opts)

  local line_start = fn.line("'<")
  local line_end = fn.line("'>")

  if line_start ~= line_end then
    -- TODO: Need to fix handling back slashes (need to escape them)
    local search_term = ''
    while line_start <= line_end do
      local line = fn.getline(line_start)
      line_start = line_start + 1
      search_term = search_term .. '\\n' .. line
    end

    search_term = search_term:gsub('^\\n', '')

    cmd('Ack! --multiline ' .. get_search_args(search_term, opts))
  else
    local line = fn.getline(line_start)
    local col_start = fn.col("'<")
    local col_end = fn.col("'>")
    local word = string.sub(line, col_start, col_end)

    cmd('Ack!' .. get_search_args(word, opts))

    if opts.boundary then
      local search_word = ''
      search_word = '\\<' .. search_word .. '\\>'
    end

    fn.setreg('/', word) -- to make highlight search term work with word boundaries
  end
end

-- TODO: make a prefix with custom directories to search for, <leader>ff is cwd
vim.keymap.set('n', '<leader>F', function()
  search_normal { include_ft = true }
end, { desc = 'Ack search in file' })
vim.keymap.set('v', '<leader>F', function()
  search_visual { include_ft = true, boundary = false }
end)
vim.keymap.set('n', '<leader>f', function()
  search_normal { include_ft = false }
end, { desc = 'Ack search all' })
vim.keymap.set('v', '<leader>f', function()
  search_visual { include_ft = false, boundary = false }
end, { desc = 'Ack search selected' })

--TODO: possibly change these to user commands
vim.cmd.cnoreabbrev('FF', 'Ack!') -- default, should get updated per filetype
vim.cmd.cnoreabbrev('F', 'Ack!') -- search all

local group = vim.api.nvim_create_augroup('update_search_abbrev', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  pattern = '*',
  callback = function()
    vim.cmd.cnoreabbrev('FF', 'Ack!' .. get_search_args(nil, { include_ft = true, include_cwd = false }))
  end,
})
