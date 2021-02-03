local map = function(mode, lhs, rhs, override_opts)
  local opts = {unique = true, noremap = true, silent = true}
  if override_opts then opts = vim.tbl_extend('force', opts, override_opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

local function bmap(mode, lhs, rhs, override_opts)
  local opts = {unique = true, noremap = true, silent = true}
  if override_opts then opts = vim.tbl_extend('force', opts, override_opts) end
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

-- Text object remaps
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
-- function and object text objects provided by CoC
map('o', 'ac', '<Plug>(coc-classobj-a)', {noremap=false})
map('x', 'ac', '<Plug>(coc-classobj-a)', {noremap=false})
map('o', 'af', '<Plug>(coc-funcobj-a)', {noremap=false})
map('x', 'af', '<Plug>(coc-funcobj-a)', {noremap=false})
-- TODO: look into the inner ones, they don't seem to be working correctly
map('o', 'ic', '<Plug>(coc-classobj-i)', {noremap=false})
map('x', 'ic', '<Plug>(coc-classobj-i)', {noremap=false})
map('o', 'if', '<Plug>(coc-funcobj-i)', {noremap=false})
map('x', 'if', '<Plug>(coc-funcobj-i)', {noremap=false})

-- "hunk" text objects provided by signify
map('o', 'ah', '<Plug>(signify-motion-outer-pending)', {noremap=false})
map('x', 'ah', '<Plug>(signify-motion-outer-visual)', {noremap=false})
map('o', 'ih', '<Plug>(signify-motion-inner-pending)', {noremap=false})
map('x', 'ih', '<Plug>(signify-motion-inner-visual)', {noremap=false})

-- Esc remaps
map('c', 'kj', '<C-c>')
map('i', 'kj', '<Esc>')
map('o', 'kj', '<Esc>')
map('t', 'kj', '<Esc>')
map('v', 'v', '<Esc>')

-- Coc remaps
-- easier navigation through diagnostics in file
map('n', '<leader>dd', ':CocList diagnostics<cr>' )
map('n', '<leader>dp', '<Plug>(coc-diagnostic-prev)', {noremap=false})
map('n', '<leader>dn', '<Plug>(coc-diagnostic-next)', {noremap=false})
map('n', 'gd', '<Plug>(coc-definition)', {noremap=false})
map('n', 'gD', ':call CocAction("jumpDefinition", v:false)<cr>')
map('n', 'gr', '<Plug>(coc-rename)', {noremap=false})
map('n', 'gR', '<Plug>(coc-references)', {noremap=false})
map('n', 'gy', '<Plug>(coc-type-definition)', {noremap=false})
-- interferes with jumping to last insert
-- map('n', 'gi', '<Plug>(coc-implementation)', {noremap=false})
map('n', 'K', ':lua require"plugins.coc".show_documentation()<CR>')

-- Ack remaps
map('n', '<leader>f', ':Ack!<space>', {silent = false})

-- Fugitive remaps
map('n', '<leader>gs', ':G<cr>')
map('n', '<leader>gd', ':Gdiff<cr>')
map('n', '<leader>gb', ':Gblame<cr>')
-- Signify remaps
map('n', '<leader>gk', ':SignifyHunkDiff<cr>')
map('n', '<leader>gu', ':SignifyHunkUndo<cr>')
map('n', '<leader>gz', ':SignifyFold<cr>')

-- FZF remaps
map('n', '<leader>l', ':Buffers<CR>')
map('n', '<leader>j', ':Files<CR>')
map('n', '<leader>JJ', ':FilesAll<cr>')
map('n', '<leader>Jh', ':Files ~<cr>')
map('n', '<leader>Jd', ':Files ~/dotfiles<cr>')

return {
  map = map,
  bmap = map
}
