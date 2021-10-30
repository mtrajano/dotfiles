local u = require('mt.utils')
local g = vim.g
local o = vim.o
local fn = vim.fn
local cmd = vim.cmd

local special_chars = {'.', '{', '}', '[', ']', '(', ')', '-', '+', '*', '?', '^', '$', '#'}

-- use ripgrep for searching
g.ackprg = 'rg --vimgrep --smart-case'

-- use dispatch for non-blocking
g.ack_use_dispatch = 1

-- use word under cursor on empty search
g.ack_use_cword_for_empty_search = 1

local M = {}

local function escape_special_chars(word)
  for _, val in ipairs(special_chars) do
    word = word:gsub('%' .. val, '\\%1')
  end

  return word
end

local function include_file_globs(filetype)
  local filetype_to_glob = {
    php = {"'!*Test.php'"},
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
    javascript = {'js', 'ts'},
    lua = {'lua'},
    php = {'php'},
    typescript = {'js', 'ts'},
    typescriptreact = {'js', 'ts'},
    vue = {'js', 'ts'},
  }

  local search_filetypes = {'all'}

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
local function get_search_term(raw_term, opts)
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

  return search_term .. optional_params
end

-- @class opts
-- @field ignore      : Dont respect version control ignore files
-- @field boundary     : Add a word boundary around the search term
-- @field include_ft   : Search within same filetype
local function get_search_opts(opts)
  local default_opts = {
    ignore = false,
    boundary = true,
    include_ft = true,
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
M.search_normal = function(opts)
  opts = get_search_opts(opts)

  local search_word = fn.expand('<cword>')

  cmd('Ack!' ..  get_search_term(search_word, opts))

  if opts.boundary then
    search_word = '\\<' .. search_word .. '\\>'
  end

  fn.setreg('/', search_word) -- to make highlight search term work with word boundaries

end

-- @class opts
-- @field ignore      : Dont respect version control ignore files
-- @field boundary     : Add a word boundary around the search term
-- @field include_ft   : Search within same filetype
M.search_visual = function(opts)
  opts = get_search_opts(opts)

  local line_start = fn.line("'<")
  local line_end = fn.line("'>")

  if (line_start ~= line_end) then
    -- TODO: Need to fix handling back slashes (need to escape them)
    local search_term = ''
    while line_start <= line_end do
      local line = fn.getline(line_start)
      line_start = line_start + 1
      search_term = search_term .. "\\n" .. line
    end

    search_term = search_term:gsub('^\\n', '')

    cmd('Ack! --multiline ' ..  get_search_term(search_term, opts))
  else
    local line = fn.getline(line_start)
    local col_start = fn.col("'<")
    local col_end = fn.col("'>")
    local word = string.sub(line, col_start, col_end);

    cmd('Ack!' ..  get_search_term(word, opts))

    if opts.boundary then
      local search_word = ''
      search_word = '\\<' .. search_word .. '\\>'
    end

    fn.setreg('/', word) -- to make highlight search term work with word boundaries
  end
end

M.update_search_abbrev = function()
  u.cnoreabbrev('F', 'Ack!' .. get_search_term(nil, {include_ft=true}))
end

u.nmap('<leader>F', ':lua require("mt.search").search_normal({include_ft=true})<cr>')
u.vmap('<leader>F', ':lua require("mt.search").search_visual({include_ft=true, boundary=false})<cr>')
u.nmap('<leader>f', ':lua require("mt.search").search_normal({include_ft=false})<cr>')
u.vmap('<leader>f', ':lua require("mt.search").search_visual({include_ft=false, boundary=false})<cr>')
--TODO possibly change these to user commands
-- u.cnoreabbrev('F!', 'Ack! -tall') -- default, should get updated per filetype
u.cnoreabbrev('F', 'Ack!') -- default, should get updated per filetype
u.cnoreabbrev('Fa', 'Ack!') -- search all

cmd [[
augroup update_search_abbrev
  autocmd!
  autocmd BufEnter * lua require('mt.search').update_search_abbrev()
augroup END
]]

return M
