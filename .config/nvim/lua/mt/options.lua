local opt = vim.opt
local cmd = vim.cmd
local keymap = vim.keymap

local function disable(key, reason)
  keymap.set('n', key, '<NOP>', { desc = reason })
end

disable('Q', 'disable ex-mode (can be mapped)')

-- map escape in terminal
keymap.set('t', '<esc>', '<C-\\><C-n>')
keymap.set('n', '<esc>', ':noh<cr><esc>', { silent = true })

-- TODO: move these util keymaps somewhere else
keymap.set('n', 'gp', '`[v`]') -- select last pasted
keymap.set('n', '<leader><space>', '<C-^>') -- last buffer/window
keymap.set('n', '<leader>q', '<Plug>(qf_qf_toggle)', { remap = true }) -- toggle quickfix
keymap.set('v', '*', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]]) -- search under selection
keymap.set('v', '<leader>.', ':norm .<CR>')

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
opt.shiftround = true -- indenting rounds to multiple of shiftwidth
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.expandtab = true

opt.textwidth = 120

-- NOTE: keeping these low for which-key
opt.timeoutlen = 500 -- decrease timeout b/w remaps
opt.updatetime = 500 -- increase cursor hold frequency

-- popup menu
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

-- start with folds open
opt.foldlevelstart = 99

-- ====================
-- INSERT ABBREVIATIONS
-- ====================
-- TODO: move these somewhere else
cmd.inoreabbrev('kb', 'KB')
cmd.inoreabbrev('mb', 'MB')
cmd.inoreabbrev('gb', 'GB')
cmd.inoreabbrev('tb', 'TB')

-- TODO: eventually move these to filetype.lua file
vim.filetype.add({
  filename = {
    ['.env'] = 'env',
  },
})

-- TODO: see a better place to put this
vim.api.nvim_create_autocmd('TextYankPost', {
  command = 'silent! lua vim.highlight.on_yank()',
  group = vim.api.nvim_create_augroup('highlight_on_yank', {}),
})

-- util functions, find better to put these
vim.keymap.set('n', '<localleader>it', function()
  local time = os.date('%I:%M %p') -- Format the time as HH:MM:SS
  vim.api.nvim_put({ time }, 'c', true, true) -- Insert the time at the cursor position
end, { desc = 'Insert time' })

-- matchparen highlight updates on every cursor move, for very large files/lines this can help with perf
vim.g.matchparen_timeout = 50
vim.g.matchparen_insert_timeout = 50
