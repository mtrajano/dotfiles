local opt = vim.opt
local cmd = vim.cmd

local function disable(key, reason)
  vim.keymap.set('n', key, '<NOP>', { desc = reason })
end

-- NOTE: currently testing these keys with nvim-surround
disable('S', 'map S to NOP until get used to cc')
disable('s', 'map s to NOP until get used to cl')
disable('Q', 'disable ex-mode (can be mapped)')

-- map escape in terminal
vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

opt.swapfile = false
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true

-- spacing
-- TODO: look into moving some of these to language specfic indents
opt.shiftround = true -- indenting rounds to multiple of shiftwidth
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.expandtab = true

-- decrease timeout b/w remaps
opt.timeoutlen = 1000
-- increase cursor hold frequency
opt.updatetime = 1000

-- popup menu
-- o.completeopt = 'menu,menuone,noselect'
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.pumheight = 20

-- horizontal/vertical cursor padding, move cursor 1 line at a time
opt.sidescrolloff = 10
opt.sidescroll = 1
opt.scrolloff = 3
opt.scrolljump = 1
opt.scroll = 10

-- natural split positions
opt.splitbelow = true
opt.splitright = true

opt.undofile = true -- persistent undo

-- delay macro rendering until it's done for better perf
opt.lazyredraw = true

-- wildmenu options, don't automatically fill result
opt.wildmode = 'longest:full,list:full'

-- display hidden chars
opt.list = true
opt.listchars = 'tab:> ,nbsp:·'

opt.switchbuf = 'uselast' -- open quickfix result in last window

opt.colorcolumn = { 120 }

-- find nested files
opt.path = opt.path + { '**' }
opt.wildignore = opt.wildignore + { 'vendor/**', '.git/**', 'node_modules/**' }

-- ====================
-- INSERT ABBREVIATIONS
-- ====================
-- TODO: move these somewhere else
cmd.inoreabbrev('kb', 'KB')
cmd.inoreabbrev('mb', 'MB')
cmd.inoreabbrev('gb', 'GB')
cmd.inoreabbrev('tb', 'TB')
