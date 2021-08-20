local action = require('telescope.actions')
local Path = require('plenary.path')
local u = require('mt.utils')
local api = vim.api

require'telescope'.setup{
  defaults = {
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
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
      },
    },
  },
  extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}

require('telescope').load_extension('fzy_native')

local function telescope_mapping(key, method)
  u.nmap(key, string.format(':lua require"plugins.telescope".%s()<cr>', method))
end

telescope_mapping('<leader>jj', 'find_files')
telescope_mapping('<leader>jd', 'edit_dotfiles') -- TODO need to update prompt
telescope_mapping('<leader>ji', 'edit_installed')
telescope_mapping('<leader>jw', 'edit_work_files')
telescope_mapping('<leader>JJ', 'find_all_files') -- TODO figure out why this is so slow

-- TODO create mappings for tcd, lcd, cd, delete
telescope_mapping('<leader>hd', 'open_dotfiles')
telescope_mapping('<leader>hi', 'open_installed')
telescope_mapping('<leader>hs', 'open_scratch')

telescope_mapping('<leader>l', 'buffers')
telescope_mapping('<leader>H', 'search_help')

telescope_mapping('<leader>go', 'git_branches')

-- TODO maybe move this to utils so can be reused in different places (also
-- used in the statusline)
local function get_prompt_prefix()
  local pwd = api.nvim_exec([[ pwd ]], true) or ''
  pwd = pwd:gsub(os.getenv('HOME'), '~')

  local path = Path:new(pwd)

  return path:shorten(1)
end

local M = {}

M.find_files = function()
  require'telescope.builtin'.find_files({
    prompt_prefix = get_prompt_prefix() .. '> ',
  })
end

M.find_all_files = function()
  require'telescope.builtin'.find_files({
    find_command = {"fd", "--type", "f", "--no-ignore-vcs"},
  })
end

M.edit_dotfiles = function()
  require"telescope.builtin".find_files({
    cwd = os.getenv("DOTFILES"),
    prompt_title =' Dotfiles',
    prompt_prefix = 'dotfiles> '
  })
end

M.edit_installed = function()
  require"telescope.builtin".find_files {
    prompt_title = 'Packer Installed',
    prompt_prefix = 'Packer> ',
    cwd = os.getenv("XDG_DATA_HOME") .. "/nvim/site/pack/packer",
  }
end

M.edit_work_files = function()
  require"telescope.builtin".find_files {
    cwd=os.getenv("STOW_DIR") .. "/work/.config",
  }
end

M.buffers = function()
  require"telescope.builtin".buffers()
end

M.search_help = function()
  require"telescope.builtin".help_tags {
    prompt_prefix = '> '
  }
end

M.open_scratch = function()
  require'telescope.builtin'.file_browser {
    prompt_title = 'Sratch dir',
    cwd = '~/dev/test'
  }
end

M.git_branches = function()
  require'telescope.builtin'.git_branches {
    prompt_prefix = 'branches> ',
    previewer=false,
  }
end

return M
