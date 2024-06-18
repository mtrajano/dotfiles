---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup {

  auto_install = false, -- do not auto install parsers, should manually pick which ones I want to install

  sync_install = false, -- for the ensure_installed property

  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'cpp',
    'query',
    'javascript',
    'json',
    'lua',
    'php',
    'python',
    'scss',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'html',
    'markdown',
    'norg',
    'fennel', -- for plugins/config writter in fennel
    -- tmux -- is still pretty new and has a lot of parsing errors
  },

  highlight = {
    enable = true,
    disable = { 'php' }, -- breaks autoindent in php (relies on synId)
  },

  indent = {
    enable = false, -- still seems to be pretty buggy
  },

  -- for debugging
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn', -- set to `false` to disable one of the mappings
      -- scope_incremental = 's',
      -- NOTE: experimental
      -- good candidates for this: ; , . s S (since c/C do same thing in visual mode)
      node_incremental = ';',
      node_decremental = ',',
    },
  },
}
