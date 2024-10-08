local action = require('telescope.actions')
local action_state = require('telescope.actions.state')
local Path = require('plenary.path')
local fn = vim.fn

local developing = false
if developing then
  RELOAD('telescope')
  RELOAD('plenary')
  RELOAD('popup')
end

require('telescope').setup({
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
    },
    mappings = {
      i = {
        ['<esc>'] = action.close,
        ['<C-a>'] = { '<Home>', type = 'command' },
        ['<C-e>'] = { '<End>', type = 'command' }, -- TODO need to fix this, appending can no longer clear previous text
        ['<C-b>'] = action.preview_scrolling_up,
        ['<C-f>'] = action.preview_scrolling_down,
        ['<C-u>'] = false, -- overrides delete prompt
        ['<C-d>'] = false,
        ['<C-j>'] = action.cycle_history_next,
        ['<C-k>'] = action.cycle_history_prev,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'ignore_case', -- or "ignore_case" or "respect_case"
    },
  },
})

require('telescope').load_extension('fzf')

local function custom_mapping(key, method)
  vim.keymap.set('n', key, string.format(':lua require"mt.telescope".%s()<cr>', method))
end

local function builtin_mapping(key, method)
  vim.keymap.set('n', key, string.format(':lua require"telescope.builtin".%s()<cr>', method))
end

custom_mapping('<leader>jj', 'find_files')
custom_mapping('<leader>jg', 'git_files')
custom_mapping('<leader>jd', 'edit_dotfiles')
custom_mapping('<leader>jv', 'edit_vendor')
custom_mapping('<leader>jp', 'edit_plugins')

custom_mapping('<leader>l', 'buffers')
custom_mapping('<leader>H', 'search_help')
builtin_mapping('<leader>M', 'man_pages')
builtin_mapping('<leader>:', 'commands')
builtin_mapping('<leader>;', 'command_history')
builtin_mapping('<leader>jo', 'oldfiles')
builtin_mapping('<leader>jq', 'quickfix')
builtin_mapping('<leader>jr', 'resume')

local function shorten_path(path)
  path = fn.fnamemodify(path, ':~')
  path = Path:new(path)

  return path:shorten(1)
end

local M = {}

M.git_files = function()
  local options = {
    debounce = 50,
    prompt_prefix = shorten_path(fn.getcwd()) .. '> ',
    cwd = fn.getcwd(),
  }

  local ok = pcall(require('telescope.builtin').git_files, options)
  if not ok then
    M.find_files()
  end
end

M.find_files = function()
  if vim.fn.getcwd() == '/Users/mtrajano/dotfiles' then
    return M.edit_dotfiles()
  end
  local options = {
    prompt_prefix = shorten_path(fn.getcwd()) .. '> ',
    cwd = fn.getcwd(),
    find_command = function()
      return { 'fd', '-t', 'f' }
    end,
  }

  require('telescope.builtin').find_files(options)
end

M.find_all_files = function()
  require('telescope.builtin').find_files({
    find_command = { 'fd', '--type', 'f', '--no-ignore-vcs' },
    hidden = true,
  })
end

M.edit_dotfiles = function()
  require('telescope.builtin').find_files({
    cwd = tostring(Path:new({ vim.loop.os_homedir(), 'dotfiles' })),
    search_dirs = { '.config', 'init.sh' },
    prompt_title = ' Dotfiles',
    prompt_prefix = 'dotfiles> ',
  })
end

-- TODO: replace this with plenary.path
local function relative_path(path)
  return string.format('%s/%s', fn.getcwd(), path)
end

M.edit_plugins = function()
  require('telescope.builtin').find_files({
    prompt_title = 'Go to plugins',
    find_command = { 'fd', '--type', 'directory', '--max-depth', '1' },
    cwd = vim.fn.stdpath('data') .. '/lazy',
    previewer = false,
    attach_mappings = function()
      action.select_default:replace(function(prompt_bufnr)
        action.select_tab(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        vim.cmd.tcd(entry.path)
      end)

      return true
    end,
  })
end

M.edit_vendor = function()
  require('telescope.builtin').find_files({
    prompt_title = 'Vendor Files',
    cwd = relative_path('vendor'),
  })
end

M.oldfiles = function()
  require('telescope.builtin').oldfiles({})
end

M.quickfix = function()
  require('telescope.builtin').quickfix({})
end

M.buffers = function()
  require('telescope.builtin').buffers({
    sort_mru = true,
  })
end

M.search_help = function()
  require('telescope.builtin').help_tags({
    prompt_prefix = 'help tags> ',
  })
end

M.man_pages = function()
  require('telescope.builtin').man_pages({
    prompt_prefix = 'man pages> ',
  })
end

M.lsp_references = function()
  require('telescope.builtin').lsp_references({
    entry_maker = require('mt.telescope.entry_makers').file_with_linenumbers,
    layout_strategy = 'vertical',
  })
end

return M
