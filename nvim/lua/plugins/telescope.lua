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
    -- TODO this needs to get updated on chdir
    prompt_prefix = get_prompt_prefix() .. '> ',
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
      },
    },
  }
}

u.nmap('<leader>j', ':lua require"telescope.builtin".find_files({follow=true})<cr>')
u.nmap('<leader>J', ':lua require"telescope.builtin".find_files({follow=true, hidden=true})<cr>')
u.nmap('<leader>l', ':lua require"telescope.builtin".buffers()<cr>')
u.nmap('<leader>H', ':lua require"telescope.builtin".help_tags()<cr>')
