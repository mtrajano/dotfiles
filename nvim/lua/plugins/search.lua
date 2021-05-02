local u = require('utils')
local fn = vim.fn
local cmd = vim.cmd

local special_chars = {'.', '{', '}', '[', ']', '-', '+', '*', '?', '^', '$'}

-- use ripgrep for searching
vim.g.ackprg = 'rg --vimgrep --smart-case'

-- use dispatch for non-blocking
vim.g.ack_use_dispatch = 1

-- use word under cursor on empty search
vim.g.ack_use_cword_for_empty_search = 1

-- highlight searched terms
vim.g.ackhighlight = 1

u.cnoreabbrev('Ack', 'Ack!')

local M = {}

local function escape_special_chars(word)
  for _, val in ipairs(special_chars) do
    word = word:gsub('%' .. val, '\\%1')
  end

  return word
end

local function resolve_types(filetype)
  local type_overrides = {
    javascript = {'js', 'ts'},
    qf = {'all'},
    typescript = {'js', 'ts'},
    typescriptreact = {'js', 'ts'},
    vue = {'js', 'ts'},
  }

  local search_filetypes = {filetype}

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
-- @field ignored   : Dont respect version control ignore files
-- @field boundary  : Add a word boundary around the search term
local function search_word(raw_term, opts)
  local opts = opts or {}
  local optional_params = (opts.ignored and " --no-ignore-vcs") or ""

  -- TODO only append filetype if valid rg option
  optional_params = optional_params .. resolve_types(vim.bo.filetype)

  local search_term = escape_special_chars(raw_term)
  if opts.boundary then
    search_term = "'\\b" .. search_term .. "\\b'"
  else
    search_term = "'" .. search_term .. "'"
  end

  cmd('Ack! ' .. search_term .. optional_params)
  fn.setreg('/', raw_term) -- to make highlight search term work with word boundaries
end

M.search_normal = function(include_ignored)
  search_word(fn.expand('<cword>'), {
    ignored=include_ignored,
    boundary=true
  })
end

M.search_visual = function()
  local line_start = fn.line("'<")
  local line_end = fn.line("'>")
  if (line_start ~= line_end) then
    -- TODO ? support search across multiple lines by appending "\s*\n" to each line
    print('Search should only be across a single line')
  else
    local line = fn.getline(line_start)
    local col_start = fn.col("'<")
    local col_end = fn.col("'>")
    local word = string.sub(line, col_start, col_end);

    search_word(word)
  end
end

u.nmap('<leader>f', ':lua require("plugins.search").search_normal(false)<cr>')
u.vmap('<leader>f', ':lua require("plugins.search").search_visual()<cr>')
u.nmap('<leader>F', ':lua require("plugins.search").search_normal(true)<cr>') -- use with caution

return M
