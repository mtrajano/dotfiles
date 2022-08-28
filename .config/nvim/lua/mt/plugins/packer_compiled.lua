-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/mtrajano/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/mtrajano/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/mtrajano/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/mtrajano/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/mtrajano/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["ack.vim"] = {
    commands = { "Ack" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/opt/ack.vim",
    url = "https://github.com/mileszs/ack.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nŸ\2\0\0\5\0\r\0\0186\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0005\4\4\0B\0\4\0016\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\t\0005\3\b\0=\3\n\0025\3\v\0=\3\f\2B\0\2\1K\0\1\0\20buftype_exclude\1\b\0\0\rterminal\vnofile\thelp\rmarkdown\fvimwiki\ttext\rfugitive\24char_highlight_list\1\0\0\1\2\0\0\26IndentBlanklineIndent\nsetup\21indent_blankline\frequire\1\0\1\afg\f#393d4e\26IndentBlanklineIndent\16nvim_set_hl\bapi\bvim\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\nS\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\15toggle_key\n<C-K>\nsetup\18lsp_signature\frequire\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nA\0\0\4\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\1K\0\1\0\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/hoob3rt/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-tool-installer.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/mason-tool-installer.nvim",
    url = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n&\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\vmt.lsp\frequire\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\nS\0\0\3\0\4\0\0066\0\0\0009\0\1\0009\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\4\0\0\vtoggle\fcurrent\21reveal_force_cwd\fNeotree\bcmd\bvim›\2\1\0\6\0\18\0\0246\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\v\0005\3\t\0005\4\a\0005\5\6\0=\5\b\4=\4\n\3=\3\f\2B\0\2\0016\0\0\0009\0\r\0009\0\14\0'\2\15\0'\3\16\0003\4\17\0B\0\4\1K\0\1\0\0\15<leader>kk\6n\bset\vkeymap\15filesystem\1\0\0\vwindow\1\0\0\rmappings\1\0\0\1\0\4\f<space>\1\6l\topen\6h\16navigate_up\n<tab>\topen\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  neorg = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    load_after = {},
    loaded = true,
    needs_bufread = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/opt/neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\nY\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\faliases\1\0\0\1\0\1\6c\6`\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ufo"] = {
    config = { "\27LJ\2\n%\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\15treesitter\vindentù\2\1\0\a\0\20\00056\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0'\2\b\0B\0\2\0016\0\6\0009\0\t\0009\0\n\0'\2\v\0'\3\f\0006\4\0\0'\6\1\0B\4\2\0029\4\r\4B\0\4\0016\0\6\0009\0\t\0009\0\n\0'\2\v\0'\3\14\0006\4\0\0'\6\1\0B\4\2\0029\4\15\4B\0\4\0016\0\6\0009\0\t\0009\0\n\0'\2\v\0'\3\16\0006\4\0\0'\6\1\0B\4\2\0029\4\17\4B\0\4\0016\0\6\0009\0\t\0009\0\n\0'\2\v\0'\3\18\0006\4\0\0'\6\1\0B\4\2\0029\4\19\4B\0\4\1K\0\1\0\19closeFoldsWith\azm\25openFoldsExceptKinds\azr\18closeAllFolds\azM\17openAllFolds\azR\6n\bset\vkeymap\26 set foldmethod=expr \bcmd\bvim\22provider_selector\1\0\0\0\nsetup\bufo\frequire\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-ufo",
    url = "https://github.com/kevinhwang91/nvim-ufo"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/one-small-step-for-vimkind",
    url = "https://github.com/jbyuki/one-small-step-for-vimkind"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["registers.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/registers.nvim",
    url = "https://github.com/tversteeg/registers.nvim"
  },
  ["splitjoin.vim"] = {
    commands = { "SplitjoinSplit", "SplitjoinJoin" },
    config = { "\27LJ\2\n‚\2\0\0\6\0\r\0\0256\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0006\4\0\0009\4\a\0049\4\b\0045\5\t\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\n\0006\4\0\0009\4\a\0049\4\v\0045\5\f\0B\0\5\1K\0\1\0\1\0\1\tdesc\18SplitjoinJoin\18SplitjoinJoin\15<leader>sj\1\0\1\tdesc\19SplitjoinSplit\19SplitjoinSplit\bcmd\15<leader>ss\6n\bset\vkeymap$splitjoin_php_method_chain_full\6g\bvim\0" },
    keys = { { "n", "<leader>ss" }, { "n", "<leader>sj" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/opt/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  tabular = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17mt.telescope\frequire\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n'\0\2\a\1\1\0\0066\2\0\0-\4\0\0\18\5\0\0\18\6\1\0B\2\4\1K\0\1\0\1À\npcallî\2\1\0\6\0\21\00026\0\0\0'\2\1\0B\0\2\0029\1\2\0003\2\3\0=\2\2\0006\2\0\0'\4\4\0B\2\2\0029\2\5\0024\4\0\0B\2\2\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\n\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\v\0'\5\f\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\r\0'\5\14\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\15\0'\5\16\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\17\0'\5\18\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\19\0'\5\20\0B\2\3\0012\0\0€K\0\1\0\vFIXME:\vfixme:\nHACK:\nhack:\nTEST:\ntest:\nNOTE:\nnote:\nTODO:\ntodo:\tBUG:\tbug:\16inoreabbrev\bcmd\bvim\nsetup\18todo-comments\0\18highlight_win\28todo-comments.highlight\frequire\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/B4mbus/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "TroubleToggle" },
    config = { "\27LJ\2\n‘\3\0\0\4\0\t\0\r6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\6\0005\3\a\0=\3\b\2B\0\2\1K\0\1\0\nsigns\1\0\5\nother\bï« \fwarning\bï”©\nerror\bï™™\thint\bï µ\16information\bï‘‰\1\0\2\14auto_fold\2\15auto_close\2\nsetup\ftrouble\frequireß\1        hi link TroubleSignError DiagnosticSignError\n        hi link TroubleTextError DiagnosticError\n        hi link TroubleSignWarning DiagnosticSignWarning\n        hi link TroubleTextWarning DiagnosticWarning\n      \bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  undotree = {
    config = { "\27LJ\2\nx\0\0\6\0\b\0\v6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\0\0009\4\5\0049\4\6\0045\5\a\0B\0\5\1K\0\1\0\1\0\1\tdesc\19UndotreeToggle\19UndotreeToggle\bcmd\14<leader>u\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-bbye"] = {
    config = { "\27LJ\2\n3\0\0\3\0\4\0\0066\0\0\0009\0\1\0009\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tbang\2\aBd\bcmd\bvim3\0\0\3\0\4\0\0066\0\0\0009\0\1\0009\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tbang\2\aBw\bcmd\bvimÔ\1\1\0\5\0\r\0!6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\0\0009\4\5\0049\4\6\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0003\4\b\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\t\0006\4\0\0009\4\5\0049\4\n\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\v\0003\4\f\0B\0\4\1K\0\1\0\0\15<leader>bW\aBw\15<leader>bw\0\15<leader>bD\aBd\bcmd\15<leader>bd\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-bbye",
    url = "https://github.com/moll/vim-bbye"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    config = { "\27LJ\2\n;\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\30dispatch_no_tmux_dispatch\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/opt/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-matchup"] = {
    config = { "\27LJ\2\nt\0\0\3\0\b\0\t6\0\0\0009\0\1\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\1=\1\2\0K\0\1\0\vliquid\1\0\1\16tagnameonly\3\1\thtml\1\0\0\1\0\1\16tagnameonly\3\1\22matchup_matchpref\6g\bvim\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-obsession"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-obsession",
    url = "https://github.com/tpope/vim-obsession"
  },
  ["vim-oscyank"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-oscyank",
    url = "https://github.com/ojroques/vim-oscyank"
  },
  ["vim-pencil"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-pencil",
    url = "https://github.com/preservim/vim-pencil"
  },
  ["vim-projectionist"] = {
    config = { "\27LJ\2\n²\1\0\0\6\0\v\0\0216\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\0\0009\4\5\0049\4\6\0045\5\a\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\b\0006\4\0\0009\4\5\0049\4\t\0045\5\n\0B\0\5\1K\0\1\0\1\0\1\tdesc\nEtest\nEtest\15<leader>et\1\0\1\tdesc\fEsource\fEsource\bcmd\15<leader>es\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-projectionist",
    url = "https://github.com/tpope/vim-projectionist"
  },
  ["vim-qf"] = {
    config = { "\27LJ\2\n6\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\25qf_mapping_ack_style\6g\bvim\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-qf",
    url = "https://github.com/romainl/vim-qf"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-scriptease"] = {
    commands = { "Messages" },
    config = { "\27LJ\2\nl\0\0\6\0\b\0\v6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\0\0009\4\5\0049\4\6\0045\5\a\0B\0\5\1K\0\1\0\1\0\1\tdesc\rMessages\rMessages\bcmd\14<leader>m\6n\bset\vkeymap\bvim\0" },
    keys = { { "n", "zS" }, { "n", "<leader>m" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/opt/vim-scriptease",
    url = "https://github.com/tpope/vim-scriptease"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-speeddating",
    url = "https://github.com/tpope/vim-speeddating"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-textobj-entire",
    url = "https://github.com/kana/vim-textobj-entire"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-tmux-navigator"] = {
    config = { "\27LJ\2\n³\3\0\0\6\0\19\0-6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0006\4\0\0009\4\a\0049\4\b\0045\5\t\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\n\0006\4\0\0009\4\a\0049\4\v\0045\5\f\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\r\0006\4\0\0009\4\a\0049\4\14\0045\5\15\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\16\0006\4\0\0009\4\a\0049\4\17\0045\5\18\0B\0\5\1K\0\1\0\1\0\1\tdesc\21TmuxNavigateLeft\21TmuxNavigateLeft\n<C-H>\1\0\1\tdesc\21TmuxNavigateDown\21TmuxNavigateDown\n<C-J>\1\0\1\tdesc\19TmuxNavigateUp\19TmuxNavigateUp\n<C-K>\1\0\1\tdesc\22TmuxNavigateRight\22TmuxNavigateRight\bcmd\n<C-L>\6n\bset\vkeymap'tmux_navigator_disable_when_zoomed\6g\bvim\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  vimwiki = {
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/vimwiki",
    url = "https://github.com/vimwiki/vimwiki"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/mtrajano/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n'\0\2\a\1\1\0\0066\2\0\0-\4\0\0\18\5\0\0\18\6\1\0B\2\4\1K\0\1\0\1À\npcallî\2\1\0\6\0\21\00026\0\0\0'\2\1\0B\0\2\0029\1\2\0003\2\3\0=\2\2\0006\2\0\0'\4\4\0B\2\2\0029\2\5\0024\4\0\0B\2\2\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\n\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\v\0'\5\f\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\r\0'\5\14\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\15\0'\5\16\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\17\0'\5\18\0B\2\3\0016\2\6\0009\2\a\0029\2\b\2'\4\19\0'\5\20\0B\2\3\0012\0\0€K\0\1\0\vFIXME:\vfixme:\nHACK:\nhack:\nTEST:\ntest:\nNOTE:\nnote:\nTODO:\ntodo:\tBUG:\tbug:\16inoreabbrev\bcmd\bvim\nsetup\18todo-comments\0\18highlight_win\28todo-comments.highlight\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: vim-matchup
time([[Config for vim-matchup]], true)
try_loadstring("\27LJ\2\nt\0\0\3\0\b\0\t6\0\0\0009\0\1\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\1=\1\2\0K\0\1\0\vliquid\1\0\1\16tagnameonly\3\1\thtml\1\0\0\1\0\1\16tagnameonly\3\1\22matchup_matchpref\6g\bvim\0", "config", "vim-matchup")
time([[Config for vim-matchup]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\nS\0\0\3\0\4\0\0066\0\0\0009\0\1\0009\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\4\0\0\vtoggle\fcurrent\21reveal_force_cwd\fNeotree\bcmd\bvim›\2\1\0\6\0\18\0\0246\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\v\0005\3\t\0005\4\a\0005\5\6\0=\5\b\4=\4\n\3=\3\f\2B\0\2\0016\0\0\0009\0\r\0009\0\14\0'\2\15\0'\3\16\0003\4\17\0B\0\4\1K\0\1\0\0\15<leader>kk\6n\bset\vkeymap\15filesystem\1\0\0\vwindow\1\0\0\rmappings\1\0\0\1\0\4\f<space>\1\6l\topen\6h\16navigate_up\n<tab>\topen\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: nvim-ufo
time([[Config for nvim-ufo]], true)
try_loadstring("\27LJ\2\n%\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\15treesitter\vindentù\2\1\0\a\0\20\00056\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0'\2\b\0B\0\2\0016\0\6\0009\0\t\0009\0\n\0'\2\v\0'\3\f\0006\4\0\0'\6\1\0B\4\2\0029\4\r\4B\0\4\0016\0\6\0009\0\t\0009\0\n\0'\2\v\0'\3\14\0006\4\0\0'\6\1\0B\4\2\0029\4\15\4B\0\4\0016\0\6\0009\0\t\0009\0\n\0'\2\v\0'\3\16\0006\4\0\0'\6\1\0B\4\2\0029\4\17\4B\0\4\0016\0\6\0009\0\t\0009\0\n\0'\2\v\0'\3\18\0006\4\0\0'\6\1\0B\4\2\0029\4\19\4B\0\4\1K\0\1\0\19closeFoldsWith\azm\25openFoldsExceptKinds\azr\18closeAllFolds\azM\17openAllFolds\azR\6n\bset\vkeymap\26 set foldmethod=expr \bcmd\bvim\22provider_selector\1\0\0\0\nsetup\bufo\frequire\0", "config", "nvim-ufo")
time([[Config for nvim-ufo]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n&\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\vmt.lsp\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: vim-bbye
time([[Config for vim-bbye]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\4\0\0066\0\0\0009\0\1\0009\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tbang\2\aBd\bcmd\bvim3\0\0\3\0\4\0\0066\0\0\0009\0\1\0009\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tbang\2\aBw\bcmd\bvimÔ\1\1\0\5\0\r\0!6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\0\0009\4\5\0049\4\6\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0003\4\b\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\t\0006\4\0\0009\4\5\0049\4\n\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\v\0003\4\f\0B\0\4\1K\0\1\0\0\15<leader>bW\aBw\15<leader>bw\0\15<leader>bD\aBd\bcmd\15<leader>bd\6n\bset\vkeymap\bvim\0", "config", "vim-bbye")
time([[Config for vim-bbye]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\nA\0\0\4\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\1K\0\1\0\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17mt.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\nY\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\faliases\1\0\0\1\0\1\6c\6`\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
try_loadstring("\27LJ\2\nS\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\15toggle_key\n<C-K>\nsetup\18lsp_signature\frequire\0", "config", "lsp_signature.nvim")
time([[Config for lsp_signature.nvim]], false)
-- Config for: undotree
time([[Config for undotree]], true)
try_loadstring("\27LJ\2\nx\0\0\6\0\b\0\v6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\0\0009\4\5\0049\4\6\0045\5\a\0B\0\5\1K\0\1\0\1\0\1\tdesc\19UndotreeToggle\19UndotreeToggle\bcmd\14<leader>u\6n\bset\vkeymap\bvim\0", "config", "undotree")
time([[Config for undotree]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: vim-tmux-navigator
time([[Config for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\n³\3\0\0\6\0\19\0-6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0006\4\0\0009\4\a\0049\4\b\0045\5\t\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\n\0006\4\0\0009\4\a\0049\4\v\0045\5\f\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\r\0006\4\0\0009\4\a\0049\4\14\0045\5\15\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\16\0006\4\0\0009\4\a\0049\4\17\0045\5\18\0B\0\5\1K\0\1\0\1\0\1\tdesc\21TmuxNavigateLeft\21TmuxNavigateLeft\n<C-H>\1\0\1\tdesc\21TmuxNavigateDown\21TmuxNavigateDown\n<C-J>\1\0\1\tdesc\19TmuxNavigateUp\19TmuxNavigateUp\n<C-K>\1\0\1\tdesc\22TmuxNavigateRight\22TmuxNavigateRight\bcmd\n<C-L>\6n\bset\vkeymap'tmux_navigator_disable_when_zoomed\6g\bvim\0", "config", "vim-tmux-navigator")
time([[Config for vim-tmux-navigator]], false)
-- Config for: vim-projectionist
time([[Config for vim-projectionist]], true)
try_loadstring("\27LJ\2\n²\1\0\0\6\0\v\0\0216\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\0\0009\4\5\0049\4\6\0045\5\a\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\b\0006\4\0\0009\4\5\0049\4\t\0045\5\n\0B\0\5\1K\0\1\0\1\0\1\tdesc\nEtest\nEtest\15<leader>et\1\0\1\tdesc\fEsource\fEsource\bcmd\15<leader>es\6n\bset\vkeymap\bvim\0", "config", "vim-projectionist")
time([[Config for vim-projectionist]], false)
-- Config for: vim-qf
time([[Config for vim-qf]], true)
try_loadstring("\27LJ\2\n6\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\25qf_mapping_ack_style\6g\bvim\0", "config", "vim-qf")
time([[Config for vim-qf]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nŸ\2\0\0\5\0\r\0\0186\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0005\4\4\0B\0\4\0016\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\t\0005\3\b\0=\3\n\0025\3\v\0=\3\f\2B\0\2\1K\0\1\0\20buftype_exclude\1\b\0\0\rterminal\vnofile\thelp\rmarkdown\fvimwiki\ttext\rfugitive\24char_highlight_list\1\0\0\1\2\0\0\26IndentBlanklineIndent\nsetup\21indent_blankline\frequire\1\0\1\afg\f#393d4e\26IndentBlanklineIndent\16nvim_set_hl\bapi\bvim\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-treesitter ]]
vim.cmd [[ packadd neorg ]]

-- Config for: neorg
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "neorg")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SplitjoinJoin lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinJoin", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSHighlightCapturesUnderCursor lua require("packer.load")({'playground'}, { cmd = "TSHighlightCapturesUnderCursor", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SplitjoinSplit lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinSplit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Ack lua require("packer.load")({'ack.vim'}, { cmd = "Ack", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Messages lua require("packer.load")({'vim-scriptease'}, { cmd = "Messages", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[nnoremap <silent> <leader>m <cmd>lua require("packer.load")({'vim-scriptease'}, { keys = "<lt>leader>m", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> zS <cmd>lua require("packer.load")({'vim-scriptease'}, { keys = "zS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>ss <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "<lt>leader>ss", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>sj <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "<lt>leader>sj", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
