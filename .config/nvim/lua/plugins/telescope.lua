local action = require('telescope.actions')
local Path = require('plenary.path')
local u = require('mt.utils')
local api = vim.api

-- TODO maybe move this to utils so can be reused in different places (also
-- used in the statusline)
local function get_prompt_prefix()
  local pwd = api.nvim_exec([[ pwd ]], true)
  pwd = pwd:gsub(os.getenv('HOME'), '~')

  local path = Path:new(pwd)

  return path:shorten(1)
end

require'telescope'.setup{
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = "top",
    },
    prompt_prefix = get_prompt_prefix() .. '> ',
    mappings = {
      i = {
        ['<esc>'] = action.close,
        ['<C-a>'] = { '<Home>', type = 'command' },
        ['<C-e>'] = { '<End>', type = 'command' },
        ['<C-b>'] = action.preview_scrolling_up,
        ['<C-f>'] = action.preview_scrolling_down,
        ['<C-u>'] = false, -- overrides delete prompt
        ['<C-d>'] = false,
      },
    },
  }
}

require("telescope").load_extension('frecency')
require('telescope').load_extension('fzy_native')

-- TODO move these out functions
u.nmap('<leader>jj', ':lua require"telescope.builtin".find_files()<cr>')
u.nmap('<leader>JJ', ':lua require"telescope.builtin".find_files({find_command={"fd", "--type", "f", "--no-ignore-vcs"}})<cr>') -- TODO figure out why this is so slow
u.nmap('<leader>jl', ':lua require"telescope.builtin".find_files({cwd="vendor"})<cr>') -- TODO make this language specific, need to update prompt
u.nmap('<leader>jd', ':lua require"telescope.builtin".find_files({cwd=os.getenv("DOTFILES")})<cr>') -- TODO need to update prompt
u.nmap('<leader>jw', ':lua require"telescope.builtin".find_files({cwd=os.getenv("STOW_DIR") .. "/work/.config"})<cr>') -- TODO need to update prompt
u.nmap('<leader>l', ':lua require"telescope.builtin".buffers()<cr>')

u.nmap('<leader>H', ':lua require"telescope.builtin".help_tags()<cr>')

u.nmap('<leader>go', ':lua require"telescope.builtin".git_branches({previewer=false})<cr>')

local M = {}

M.update_prompt = function()
  require'telescope.config'.values.prompt_prefix = get_prompt_prefix() .. '> '
end

return M
