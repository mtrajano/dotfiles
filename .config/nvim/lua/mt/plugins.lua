local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- TODO: LOOK INTO LAZY LOADING A LOT OF THESE
-- NEED TO MOVE PLUGIN CONFIGS OUTSIDE OF AUTOLOADED /PLUGIN DIR
require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = 'night'
      vim.cmd.colorscheme('tokyonight')
    end,
  },

  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },

  'tversteeg/registers.nvim',
  'ojroques/vim-oscyank',

  {
    'folke/which-key.nvim',
    opts = {},
  },

  {
    'hoob3rt/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('mt.plugins.lualine')
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
        provider_selector = function()
          return { 'treesitter', 'indent' }
        end,
    }
  },

  ------
  -- LSP
  ------
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'neovim/nvim-lspconfig',
    },
  },

  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup()
      vim.keymap.set('n', '<leader>o', vim.cmd.SymbolsOutline)
    end,
  },

  --------------
  ---- DEBUGGING
  --------------
  --use {
  --  'mfussenegger/nvim-dap',
  --  dependencies = {
  --    'rcarriga/nvim-dap-ui',
  --  },
  --  config = function()
  --    require('mt.plugins.dap')
  --  end,
  --},

  'jbyuki/one-small-step-for-vimkind',

  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    config = function()
      require('ibl').setup({
        exclude = { filetypes = { 'terminal', 'nofile', 'help', 'markdown', 'text', 'fugitive' } },
      })
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree' })
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchpref = {
        html = { tagnameonly = 1 },
        liquid = { tagnameonly = 1 },
      }
    end,
  },

  -- TODO: need to install the tmux plguin so can navigate back
  {
    'christoomey/vim-tmux-navigator',
    keys = {
      { '<C-L>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Tmux Navigate Right' } },
      { '<C-K>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Tmux Navigate Up' } },
      { '<C-J>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Tmux Navigate Down' } },
      { '<C-H>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Tmux Navigate Left' } },
    },
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  {
    'mileszs/ack.vim',
    event = 'VeryLazy',
  },
  {
    'romainl/vim-qf',
    config = function()
      vim.g.qf_mapping_ack_style = 1
    end,
  },
  {
    'moll/vim-bbye',
    config = function()
      vim.keymap.set('n', '<leader>bd', vim.cmd.Bd, { desc = 'Bufferdelete' })
      vim.keymap.set('n', '<leader>bD', function()
        vim.cmd.Bd({ bang = true })
      end, { desc = 'Bufferdelete force' })
      vim.keymap.set('n', '<leader>bw', vim.cmd.Bw, { desc = 'Bufferwipeout' })
      vim.keymap.set('n', '<leader>bW', function()
        vim.cmd.Bw({ bang = true })
      end, { desc = 'Bufferwipeout force' })
    end,
  },
  {
    'AndrewRadev/splitjoin.vim',
    config = function()
      -- split join, each method call in a different line
      vim.g.splitjoin_php_method_chain_full = 1

      vim.keymap.set('n', '<leader>ss', vim.cmd.SplitjoinSplit, { desc = 'SplitjoinSplit' })
      vim.keymap.set('n', '<leader>sj', vim.cmd.SplitjoinJoin, { desc = 'SplitjoinJoin' })
    end,
    event = 'VeryLazy',
  },

  {
    'kylechui/nvim-surround',
    opts = {},
  },

  'mtrajano/vim-vinegar', -- NOTE: had to fork repo to make y. work due to it having a mapcheck which is taken by which-key
  'tpope/vim-sleuth', -- automatically detect space issue
  'tpope/vim-repeat',
  {
    'tpope/vim-projectionist',
    config = function()
      vim.keymap.set('n', '<leader>es', vim.cmd.Esource, { desc = 'Esource' })
      vim.keymap.set('n', '<leader>et', vim.cmd.Etest, { desc = 'Etest' })
    end,
  },
  'tpope/vim-commentary', -- TODO: install the nvim version
  'tpope/vim-unimpaired',
  'tpope/vim-abolish',
  'tpope/vim-speeddating',
  'tpope/vim-obsession',
  'tpope/vim-scriptease',
  {
    'tpope/vim-dispatch',
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
    config = function()
      vim.g.dispatch_no_tmux_dispatch = 1 -- breaks zoomed panes
    end,
  },

  { 'L3MON4D3/LuaSnip', event = 'InsertEnter', dependencies = {
    'honza/vim-snippets',
  } },

  {
    'sindrets/diffview.nvim',
    config = function()
      local actions = require('diffview.actions')
      vim.keymap.set('n', '<leader>D', vim.cmd.DiffviewOpen, { desc = 'DiffviewOpen' })
      require('diffview').setup({
        keymaps = {
          file_panel = {
            ['s'] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
          },
        },
      })
    end,
  },
  {
    'tpope/vim-fugitive',
    cmd = 'G',
    config = function()
      require('mt.plugins.fugitive')
    end,
    dependencies = { 'tpope/vim-rhubarb' },
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('mt.plugins.gitsigns')
    end,
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup({})

      vim.cmd.inoreabbrev('bug:', 'BUG:')
      vim.cmd.inoreabbrev('todo:', 'TODO:')
      vim.cmd.inoreabbrev('note:', 'NOTE:')
      vim.cmd.inoreabbrev('test:', 'TEST:')
      vim.cmd.inoreabbrev('hack:', 'HACK:')
      vim.cmd.inoreabbrev('fixme:', 'FIXME:')
    end,
  },

  -- TODO: try treesitter-text-objs and get rid of most of these
  -- local function install_textobj(repo)
  --   use {, repo, dependencies = { 'kana/vim-textobj-user' } }
  -- end

  -- install_textobj('kana/vim-textobj-entire')
  -- install_textobj('glts/vim-textobj-comment')
  'wellle/targets.vim',

  -- for writing
  'preservim/vim-pencil',
  'junegunn/goyo.vim',
  {
    'dkarter/bullets.vim',
    ft = { 'nofile', 'text', 'markdown' },
  },
  {
    'plasticboy/vim-markdown',
    ft = { 'markdown' },
  },
  'godlygeek/tabular',

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('mt.plugins.nvim-treesitter')
    end,
  },
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        max_lines = 2,
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'folke/neodev.nvim',

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('mt.telescope')
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        toggle_key = '<C-K>',
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    'nvimdev/lspsaga.nvim',
    opts = {
      lightbulb = {
        sign = false, -- causes view to shift on every cursor move if the space is not reserved on the sign column
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },

  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    config = function()
      vim.cmd([[
        hi link TroubleSignError DiagnosticSignError
        hi link TroubleTextError DiagnosticError
        hi link TroubleSignWarning DiagnosticSignWarning
        hi link TroubleTextWarning DiagnosticWarning
      ]])
      require('trouble').setup({
        auto_fold = true,
        auto_close = true,
        signs = {
          error = '',
          warning = '',
          hint = '',
          information = '',
          other = '﫠',
        },
      })
    end,
  },

  { import = 'plugins' },
})
