vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('compile_onsave', { clear = true }),
  pattern = '*/mt/plugins.lua',
  callback = function()
    vim.cmd.source('<afile>')
    vim.cmd.PackerCompile()
  end,
})

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  -- TODO: how can I alert when this command fails?
  packer_bootstrap =
      vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
end

return require('packer').startup(function(use)
  -- TODO: LOOK INTO LAZY LOADING A LOT OF THESE
  -- NEED TO MOVE PLUGIN CONFIGS OUTSIDE OF AUTOLOADED /PLUGIN DIR
  use('wbthomason/packer.nvim')

  use {
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_keymaps()
    end,
  }

  use('folke/tokyonight.nvim')

  use('dstein64/vim-startuptime')

  use('tversteeg/registers.nvim')
  use('ojroques/vim-oscyank')

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  }

  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('mt.plugins.lualine')
    end,
  }
  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup {
        provider_selector = function()
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  }

  ------
  -- LSP
  ------
  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mt.lsp')
    end,
  }

  use {
    'nvim-neorg/neorg',
    after = 'nvim-treesitter',
    config = function()
      require('mt.plugins.neorg')
    end,
    requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' },
  }
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup()
      vim.keymap.set('n', '<leader>o', vim.cmd.SymbolsOutline)
    end,
  }

  ------------
  -- DEBUGGING
  ------------
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require('mt.plugins.dap')
    end,
  }

  use('jbyuki/one-small-step-for-vimkind')

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup {
        exclude = { filetypes = { 'terminal', 'nofile', 'help', 'markdown', 'vimwiki', 'text', 'fugitive' } },
      }
    end,
  }

  use {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndotreeToggle' })
    end,
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }

  use {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchpref = {
        html = { tagnameonly = 1 },
        liquid = { tagnameonly = 1 },
      }
    end,
  }

  use {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1

      vim.keymap.set('n', '<C-L>', vim.cmd.TmuxNavigateRight, { desc = 'TmuxNavigateRight' })
      vim.keymap.set('n', '<C-K>', vim.cmd.TmuxNavigateUp, { desc = 'TmuxNavigateUp' })
      vim.keymap.set('n', '<C-J>', vim.cmd.TmuxNavigateDown, { desc = 'TmuxNavigateDown' })
      vim.keymap.set('n', '<C-H>', vim.cmd.TmuxNavigateLeft, { desc = 'TmuxNavigateLeft' })
    end,
  }
  use {
    'mileszs/ack.vim',
    cmd = 'Ack',
  }
  use {
    'romainl/vim-qf',
    config = function()
      vim.g.qf_mapping_ack_style = 1
    end,
  }
  use {
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
  }
  use {
    'AndrewRadev/splitjoin.vim',
    config = function()
      -- split join, each method call in a different line
      vim.g.splitjoin_php_method_chain_full = 1

      vim.keymap.set('n', '<leader>ss', vim.cmd.SplitjoinSplit, { desc = 'SplitjoinSplit' })
      vim.keymap.set('n', '<leader>sj', vim.cmd.SplitjoinJoin, { desc = 'SplitjoinJoin' })
    end,
    cmd = { 'SplitjoinSplit', 'SplitjoinJoin' },
    keys = {
      { 'n', '<leader>ss' },
      { 'n', '<leader>sj' },
    },
  }

  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup {
        aliases = {
          ['c'] = '`', -- inline code block, should this be moved to markdown/norg specific?
        },
      }
    end,
  }

  use('tpope/vim-sleuth') -- automatically detect space issues
  use('tpope/vim-repeat')
  use {
    'tpope/vim-projectionist',
    config = function()
      vim.keymap.set('n', '<leader>es', vim.cmd.Esource, { desc = 'Esource' })
      vim.keymap.set('n', '<leader>et', vim.cmd.Etest, { desc = 'Etest' })
    end,
  }
  use('tpope/vim-commentary')
  use('tpope/vim-unimpaired')
  use('tpope/vim-abolish')
  use('tpope/vim-speeddating')
  use('tpope/vim-obsession')

  use {
    'tpope/vim-scriptease',
    cmd = 'Messages',
    keys = {
      { 'n', 'zS' },
      { 'n', '<leader>m' },
    },
    config = function()
      vim.keymap.set('n', '<leader>m', vim.cmd.Messages, { desc = 'Messages' })
    end,
  }
  use {
    'tpope/vim-dispatch',
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
    opt = true,
    config = function()
      vim.g.dispatch_no_tmux_dispatch = 1 -- breaks zoomed panes
    end,
  }

  use('L3MON4D3/LuaSnip')

  use('honza/vim-snippets')

  use {
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
  }
  use {
    'tpope/vim-fugitive',
    config = function()
      require('mt.plugins.fugitive')
    end,
  }
  use('tpope/vim-rhubarb')
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('mt.plugins.gitsigns')
    end,
  }

  use {
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup {}

      vim.cmd.inoreabbrev('bug:', 'BUG:')
      vim.cmd.inoreabbrev('todo:', 'TODO:')
      vim.cmd.inoreabbrev('note:', 'NOTE:')
      vim.cmd.inoreabbrev('test:', 'TEST:')
      vim.cmd.inoreabbrev('hack:', 'HACK:')
      vim.cmd.inoreabbrev('fixme:', 'FIXME:')
    end,
  }

  -- TODO: try treesitter-text-objs and get rid of most of these
  local function install_textobj(repo)
    use { repo, requires = { 'kana/vim-textobj-user' } }
  end

  install_textobj('kana/vim-textobj-entire')
  install_textobj('glts/vim-textobj-comment')
  use('wellle/targets.vim')

  -- for writing
  use('preservim/vim-pencil')
  use { 'junegunn/goyo.vim' }
  use {
    'dkarter/bullets.vim',
    ft = { 'nofile', 'text', 'markdown', 'vimwiki' },
  }
  use {
    'plasticboy/vim-markdown',
    ft = { 'markdown', 'vimwiki' },
  }
  use('godlygeek/tabular')

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('mt.plugins.nvim-treesitter')
    end,
  }
  use('nvim-treesitter/nvim-treesitter-textobjects')
  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup()
    end,
  }
  use('windwp/nvim-ts-autotag')
  use('nvim-lua/plenary.nvim') 
  use('nvim-lua/popup.nvim')
  use('folke/neodev.nvim')

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('mt.telescope')
    end,
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-cmdline', -- TODO: looks like it breaks when native_menu is set, look into: https://github.com/hrsh7th/nvim-cmp/issues/1059
    },
    config = function()
      require('mt.plugins.nvim-cmp')
    end,
  }
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup {
        toggle_key = '<C-K>',
      }
    end,
  }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  }
  use {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end,
    requires = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
  }

  use {
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
    cmd = { 'TroubleToggle' },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
