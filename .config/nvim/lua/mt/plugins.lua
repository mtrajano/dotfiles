vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('compile_onsave', {
    clear = true,
  }),
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

  use('nanotee/zoxide.vim')

  use('folke/tokyonight.nvim')

  use('dstein64/vim-startuptime')
  use('lewis6991/impatient.nvim')

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
    requires = 'nvim-lua/plenary.nvim',
  }

  ------------
  -- DEBUGGING
  ------------
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'jbyuki/one-small-step-for-vimkind',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require('mt.plugins.dap')
    end,
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      -- TODO: see if this can be created using colors/utils from tokyonight theme
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent', { fg = '#393d4e' })
      require('indent_blankline').setup {
        char_highlight_list = {
          'IndentBlanklineIndent',
        },
        buftype_exclude = { 'terminal', 'nofile', 'help', 'markdown', 'vimwiki', 'text', 'fugitive' },
      }
    end,
  }

  use('jose-elias-alvarez/null-ls.nvim')

  use {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndotreeToggle' })
    end,
  }

  use('vimwiki/vimwiki')

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
      vim.keymap.set('n', '<leader>bd', vim.cmd.Bd)
      vim.keymap.set('n', '<leader>bD', function()
        vim.cmd.Bd { bang = true }
      end)
      vim.keymap.set('n', '<leader>bw', vim.cmd.Bw)
      vim.keymap.set('n', '<leader>bW', function()
        vim.cmd.Bw { bang = true }
      end)
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

  use('sindrets/diffview.nvim')
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
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require('neo-tree').setup {
        filesystem = {
          window = {
            mappings = {
              ['<tab>'] = 'open',
              ['l'] = 'open',
              ['h'] = 'navigate_up',
              ['<space>'] = false,
            },
          },
        },
      }
      vim.keymap.set('n', '<leader>kk', function()
        vim.cmd.Neotree { 'toggle', 'current', 'reveal_force_cwd' }
      end)
      -- TODO: set keymaping for running in a new tab lua require("neo-tree").paste_default_config()
    end,
  }

  use {
    'folke/todo-comments.nvim',
    config = function()
      -- HACK: #104 Invalid in command-line window
      local hl = require('todo-comments.highlight')
      local highlight_win = hl.highlight_win
      hl.highlight_win = function(win, force)
        pcall(highlight_win, win, force)
      end

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

  -- NOTE: need this until https://github.com/neovim/neovim/issues/12587 gets resolved
  use('antoinemadec/FixCursorHold.nvim')

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'mt.plugins.nvim-treesitter'
    end
  }
  use('nvim-treesitter/nvim-treesitter-textobjects')
  use('windwp/nvim-ts-autotag')
  use {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
  }
  use('nvim-lua/plenary.nvim')
  use('nvim-lua/popup.nvim')
  use('folke/lua-dev.nvim')

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
    },
  }
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup {
        toggle_key = '<C-K>',
      }
    end,
  }
  use('nvim-lua/lsp-status.nvim')
  use {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    config = function()
      local saga = require('lspsaga')

      saga.init_lsp_saga {
        -- your configuration
      }
    end,
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
