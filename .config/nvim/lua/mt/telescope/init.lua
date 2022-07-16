local action = require('telescope.actions')
local Path = require('plenary.path')
local u = require('mt.utils')
local o = vim.o
local fn = vim.fn

local developing = false
if developing then
  RELOAD 'telescope'
  RELOAD 'plenary'
  RELOAD 'popup'
end

require'telescope'.setup{
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = "top",
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
        ["<C-j>"] = action.cycle_history_next,
        ["<C-k>"] = action.cycle_history_prev,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "ignore_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

require('telescope').load_extension('fzf')

local function custom_mapping(key, method)
  u.nmap(key, string.format(':lua require"mt.telescope".%s()<cr>', method))
end

local function builtin_mapping(key, method)
  u.nmap(key, string.format(':lua require"telescope.builtin".%s()<cr>', method))
end

custom_mapping('<leader>jj', 'git_files')
custom_mapping('<leader>jf', 'find_files')
custom_mapping('<leader>jd', 'edit_dotfiles')
custom_mapping('<leader>ji', 'edit_installed') -- TODO: delete this
custom_mapping('<leader>jv', 'edit_vendor')
custom_mapping('<leader>jw', 'edit_work_files')
custom_mapping('<leader>jb', 'edit_behance')
custom_mapping('<leader>jp', 'edit_packer')
custom_mapping('<leader>jr', 'edit_runtime')
custom_mapping('<leader>JJ', 'find_all_files') -- TODO figure out why this is so slow
custom_mapping('<leader>jn', 'edit_node_modules')

custom_mapping('<leader>l', 'buffers')
custom_mapping('<leader>H', 'search_help')
builtin_mapping('<leader>:', 'commands')
builtin_mapping('<leader>jo', 'oldfiles')
builtin_mapping('<leader>jl', 'resume')

-- TODO: maybe move this to utils so can be reused in different places (also
-- used in the statusline)
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

  require'telescope.builtin'.git_files(options)
end

M.find_files = function()
  local options = {
    prompt_prefix = shorten_path(fn.getcwd()) .. '> ',
    cwd = fn.getcwd(),
  }

  require'telescope.builtin'.find_files(options)
end

M.find_all_files = function()
  require'telescope.builtin'.find_files({
    find_command = {"fd", "--type", "f", "--no-ignore-vcs"},
    hidden = true
  })
end

M.edit_dotfiles = function()
  require"telescope.builtin".find_files({
    cwd = tostring(Path:new({ os.getenv("HOME"), 'dotfiles/.config' })),
    prompt_title =' Dotfiles',
    prompt_prefix = 'dotfiles> '
  })
end

-- TODO: replace this with plenary.path
local function relative_path(path)
  return string.format('%s/%s', fn.getcwd(), path)
end

-- TODO: check this command on files that don't meed the file type
-- TODO: have this work with certain projects instead of file types
local function get_installed_cwd()
  local ft = o.filetype

  local package_paths = {
    php = relative_path('vendor'),
    javascript = relative_path('node_modules'),
    vue = relative_path('node_modules'),
    lua = os.getenv("XDG_DATA_HOME") .. "/nvim/site/pack/packer",
    vim = os.getenv("XDG_DATA_HOME") .. "/nvim/site/pack/packer",
    help = os.getenv("XDG_DATA_HOME") .. "/nvim/site/pack/packer",
  }

  return package_paths[ft] or fn.getcwd()
end

local function get_installed_cwd_display()
  return shorten_path(get_installed_cwd())
end

-- TODO: delete this
M.edit_installed = function()
  require'telescope.builtin'.find_files {
    prompt_title = 'Installed Packages',
    prompt_prefix = string.format('%s> ', get_installed_cwd_display()),
    cwd = get_installed_cwd(),
  }
end

M.edit_work_files = function()
  require'telescope.builtin'.find_files {
    cwd = os.getenv("STOW_DIR") .. "/work/.config",
  }
end

M.edit_packer = function()
  require'telescope.builtin'.find_files {
    prompt_title = 'Pro2 View',
    cwd = os.getenv("XDG_DATA_HOME") .. "/nvim/site/pack/packer",
  }
end

M.edit_vendor = function()
  require'telescope.builtin'.find_files {
    prompt_title = 'Vendor Files',
    cwd = relative_path('vendor'),
  }
end

M.edit_behance = function()
  require'telescope.builtin'.find_files {
    prompt_title = 'Behance',
    cwd = os.getenv('HOME') .. "/dev/behance",
  }
end

M.edit_runtime = function()
  require'telescope.builtin'.find_files {
    prompt_title = 'Runtime',
    cwd = os.getenv('VIMRUNTIME'),
  }
end

M.edit_node_modules = function()
  require'telescope.builtin'.find_files {
    prompt_title = 'Node Modules',
    cwd = relative_path('node_modules'),
  }
end

M.oldfiles = function()
  require'telescope.builtin'.oldfiles {}
end

M.buffers = function()
  require'telescope.builtin'.buffers({
    sort_mru = true,
  })
end

M.search_help = function()
  require'telescope.builtin'.help_tags {
    prompt_prefix = 'help tags> '
  }
end

M.lsp_references = function()
  require'telescope.builtin'.lsp_references {
    entry_maker = require'mt.telescope.entry_makers'.file_with_linenumbers,
    layout_strategy = 'vertical',
  }
end

return M
