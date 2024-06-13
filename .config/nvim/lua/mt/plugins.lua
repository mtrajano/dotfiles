local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

  -- TODO: LOOK INTO LAZY LOADING A LOT OF THESE
  -- NEED TO MOVE PLUGIN CONFIGS OUTSIDE OF AUTOLOADED /PLUGIN DIR
require('lazy').setup({
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_keymaps()
    end,
  },

  'folke/tokyonight.nvim',

  'dstein64/vim-startuptime',

  'tversteeg/registers.nvim',
  'ojroques/vim-oscyank',

  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
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
    config = function()
      require('ufo').setup {
        provider_selector = function()
          return { 'treesitter', 'indent' }
        end,
      }
    end,
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
    config = function()
      require('mt.lsp')
    end,
  },

  {
    'nvim-neorg/neorg',
    config = function()
      require('mt.plugins.neorg')
    end,
    dependencies = { 'nvim-treesitter', 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' },
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
    config = function()
      require('ibl').setup {
        exclude = { filetypes = { 'terminal', 'nofile', 'help', 'markdown', 'vimwiki', 'text', 'fugitive' } },
      }
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndotreeToggle' })
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
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
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1

      vim.keymap.set('n', '<C-L>', vim.cmd.TmuxNavigateRight, { desc = 'TmuxNavigateRight' })
      vim.keymap.set('n', '<C-K>', vim.cmd.TmuxNavigateUp, { desc = 'TmuxNavigateUp' })
      vim.keymap.set('n', '<C-J>', vim.cmd.TmuxNavigateDown, { desc = 'TmuxNavigateDown' })
      vim.keymap.set('n', '<C-H>', vim.cmd.TmuxNavigateLeft, { desc = 'TmuxNavigateLeft' })
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
        vim.cmd.Bd { bang = true }
      end, { desc = 'Bufferdelete force' })
      vim.keymap.set('n', '<leader>bw', vim.cmd.Bw, { desc = 'Bufferwipeout' })
      vim.keymap.set('n', '<leader>bW', function()
        vim.cmd.Bw { bang = true }
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
    -- keys = {
    --   { 'n', '<leader>ss' },
    --   { 'n', '<leader>sj' },
    -- },
  },

  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup {
        aliases = {
          ['c'] = '`', -- inline code block, should this be moved to markdown/norg specific?
        },
      }
    end,
  },

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

  {
    'tpope/vim-scriptease',
    event = 'VeryLazy',
    -- keys = {
    --   { 'n', 'zS' },
    --   { 'n', '<leader>m' },
    -- },
    config = function()
      vim.keymap.set('n', '<leader>m', vim.cmd.Messages, { desc = 'Messages' })
    end,
  },
  {
    'tpope/vim-dispatch',
    event = 'VeryLazy',
    -- cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
    -- opt = true,
    config = function()
      vim.g.dispatch_no_tmux_dispatch = 1 -- breaks zoomed panes
    end,
  },

  'L3MON4D3/LuaSnip',

  'honza/vim-snippets',

  {
    'sindrets/diffview.nvim',
    config = function()
      local actions = require('diffview.actions')
      vim.keymap.set('n', '<leader>D', vim.cmd.DiffviewOpen, { desc = 'DiffviewOpen' })
      require('diffview').setup {
        keymaps = {
          file_panel = {
            ['s'] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
          },
        },
      }
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      require('mt.plugins.fugitive')
    end,
  },
  'tpope/vim-rhubarb',
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
      require('todo-comments').setup {}

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
    ft = { 'nofile', 'text', 'markdown', 'vimwiki' },
  },
  {
    'plasticboy/vim-markdown',
    ft = { 'markdown', 'vimwiki' },
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
      require('treesitter-context').setup()
    end,
  },
  'windwp/nvim-ts-autotag',
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
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-cmdline', -- TODO: looks like it breaks when native_menu is set, look into: https://github.com/hrsh7th/nvim-cmp/issues/1059
    },
    config = function()
      require('mt.plugins.nvim-cmp')
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup {
        toggle_key = '<C-K>',
      }
    end,
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
  },

  {
    'folke/trouble.nvim',
    config = function()
      vim.cmd([[
        hi link TroubleSignError DiagnosticSignError
        hi link TroubleTextError DiagnosticError
        hi link TroubleSignWarning DiagnosticSignWarning
        hi link TroubleTextWarning DiagnosticWarning
      ]])
      require('trouble').setup {
        auto_fold = true,
        auto_close = true,
        signs = {
          error = '',
          warning = '',
          hint = '',
          information = '',
          other = '﫠',
        },
      }
    end,
    event = 'VeryLazy',
  },
})
