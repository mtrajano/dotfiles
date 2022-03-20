vim.cmd [[
augroup compile_onsave
  autocmd!
  autocmd BufWritePost */mt/plugins.lua source <afile> | PackerCompile
augroup END
]]

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'

  use 'lewis6991/impatient.nvim'

  use 'ojroques/vim-oscyank'

  use 'folke/tokyonight.nvim'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require'mt.statusline'
    end
  }

  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
          char = '|',
          char_highlight_list = {
              'IndentBlanklineIndent', -- defined in rigel overrides
          },
          buftype_exclude = {'terminal', 'nofile', 'help', 'markdown', 'vimwiki', 'text', 'fugitive' }
      }
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.trim_whitespace,
          null_ls.builtins.code_actions.proselint
        }
      }
    end
  }

  use {
    'mbbill/undotree',
  }

  use 'vimwiki/vimwiki'

  use {
    'jiangmiao/auto-pairs',
    config = function()
      vim.g.AutoPairsMapSpace = 0
      vim.g.AutoPairsMultilineClose = 0
    end
  }

  use {
    'vim-test/vim-test',
    cmd = { 'TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit' }
  }
  use 'benmills/vimux'
  use 'voldikss/vim-floaterm'
  use {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end
  }
  use {
    'mileszs/ack.vim',
    cmd = 'Ack'
  }
  use {
    'romainl/vim-qf',
    config = function()
      vim.g.qf_mapping_ack_style = 1
    end,
  }
  use {
    'moll/vim-bbye',
  }
  use {
    'AndrewRadev/splitjoin.vim',
    config = function()
      -- split join, each method call in a different line
      vim.g.splitjoin_php_method_chain_full = 1
    end,
    cmd = { 'SplitjoinSplit', 'SplitjoinJoin' }
  }

  use 'tpope/vim-surround'
  use 'tpope/vim-sleuth' -- automatically detect space issues
  use 'tpope/vim-repeat'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-commentary'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-abolish'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-obsession'

  use {
    'tpope/vim-scriptease',
    cmd = 'Messages',
    keys = {
      {'n', 'zS'}
    }
  }
  use {
    'tpope/vim-dispatch',
    cmd = {'Dispatch', 'Make', 'Focus', 'Start'},
    opt = true,
    config = function()
      vim.g.dispatch_no_tmux_dispatch = 1 -- breaks zoomed panes
    end
  }

  use {
    'SirVer/ultisnips',
  }
  use {
    'honza/vim-snippets',
    ft = { 'python', 'vim', 'zsh' }
  }

  use 'sindrets/diffview.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require'plugins.gitsigns'
    end,
  }

  use {
    'tamago324/lir.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require 'plugins.lir'
    end
  }

  use {
    'folke/todo-comments.nvim',
    config = function()
      require'todo-comments'.setup {}
      require'mt.utils'.nmap('<leader>to', ':TodoTelescope<cr>')
    end,
    requires = {
      'nvim-telescope/telescope.nvim',
    }
  }

  -- TODO: try treesitter-text-objs and get rid of most of these
  local function install_textobj(repo)
    use { repo, requires = { 'kana/vim-textobj-user' }}
  end
  install_textobj('kana/vim-textobj-function')
  install_textobj('kana/vim-textobj-entire')
  install_textobj('glts/vim-textobj-comment')
  use 'wellle/targets.vim'

  -- for writing
  use 'preservim/vim-pencil'
  use { 'junegunn/goyo.vim' }
  use {
    'dkarter/bullets.vim',
    ft = { 'nofile', 'text', 'markdown', 'vimwiki' }
  }
  use {
    'plasticboy/vim-markdown',
    ft = { 'markdown', 'vimwiki' }
  }
  use 'godlygeek/tabular'


  -- NVIM SPECIFIC

  -- Need this until https://github.com/neovim/neovim/issues/12587 gets resolved
  use 'antoinemadec/FixCursorHold.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'plugins.treesitter'
    end,
  }
  use {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' }
  }
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'folke/lua-dev.nvim'

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require 'mt.telescope'
    end,
  }

  use {
    'williamboman/nvim-lsp-installer',
    requires = { 'neovim/nvim-lspconfig' },
    config = function()
      require 'mt.lsp'
    end,
  }
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require'plugins.cmp'
    end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'quangnguyen30192/cmp-nvim-ultisnips',
    },
  }
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require'lsp_signature'.setup {
        toggle_key = '<C-K>'
      }
    end
  }
  use 'nvim-lua/lsp-status.nvim'
  use {
    'tami5/lspsaga.nvim',
    config = function()
      require'lspsaga'.init_lsp_saga {
        code_action_prompt = {
          enable = false
        }
      }
    end,
  }
  use {
    'folke/trouble.nvim',
    config = function()
      vim.cmd [[
        hi link TroubleSignError DiagnosticSignError
        hi link TroubleTextError DiagnosticError
        hi link TroubleSignWarning DiagnosticSignWarning
        hi link TroubleTextWarning DiagnosticWarning
      ]]
      require("trouble").setup {
        auto_fold = true,
        auto_close = true,
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠",
        },
      }
    end,
    cmd = { 'TroubleToggle' }
  }

	-- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
