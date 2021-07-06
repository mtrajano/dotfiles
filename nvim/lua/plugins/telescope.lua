local u = require('mt.utils')

require'telescope'.setup{
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = "top",
    },
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
      },
    },
  }
}

u.nmap('<leader>j', ':lua require"telescope.builtin".find_files()<cr>')
u.nmap('<leader>l', ':lua require"telescope.builtin".buffers()<cr>')
u.nmap('<leader>H', ':lua require"telescope.builtin".help_tags()<cr>')
