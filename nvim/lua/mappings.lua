local u = require('utils')

-- Text object remaps
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
-- function and object text objects provided by CoC
u.omap('ac', '<Plug>(coc-classobj-a)', {noremap=false})
u.xmap('ac', '<Plug>(coc-classobj-a)', {noremap=false})
u.omap('af', '<Plug>(coc-funcobj-a)', {noremap=false})
u.xmap('af', '<Plug>(coc-funcobj-a)', {noremap=false})
-- TODO: look into the inner ones, they don't seem to be working correctly
u.omap('ic', '<Plug>(coc-classobj-i)', {noremap=false})
u.xmap('ic', '<Plug>(coc-classobj-i)', {noremap=false})
u.omap('if', '<Plug>(coc-funcobj-i)', {noremap=false})
u.xmap('if', '<Plug>(coc-funcobj-i)', {noremap=false})

-- "hunk" text objects provided by signify
u.omap('ah', '<Plug>(signify-motion-outer-pending)', {noremap=false})
u.xmap('ah', '<Plug>(signify-motion-outer-visual)', {noremap=false})
u.omap('ih', '<Plug>(signify-motion-inner-pending)', {noremap=false})
u.xmap('ih', '<Plug>(signify-motion-inner-visual)', {noremap=false})

-- Esc remaps
u.cmap('kj', '<C-c>')
u.imap('kj', '<Esc>')
u.omap('kj', '<Esc>')
u.tmap('kj', '<Esc>')
u.vmap('v', '<Esc>')

-- Coc remaps
u.nmap('gd', '<Plug>(coc-definition)', {noremap=false})
u.nmap('gD', ':call CocAction("jumpDefinition", v:false)<cr>')
u.nmap('gr', '<Plug>(coc-rename)', {noremap=false})
u.nmap('gR', '<Plug>(coc-references)', {noremap=false})
u.nmap('gy', '<Plug>(coc-type-definition)', {noremap=false})
-- interferes with jumping to last insert
-- map('n', 'gi', '<Plug>(coc-implementation)', {noremap=false})
u.nmap('K', ':lua require"plugins.coc".show_documentation()<CR>')
-- easier navigation through diagnostics in file
u.nmap('<leader>dd', ':CocList diagnostics<cr>' )
u.nmap('<leader>dp', '<Plug>(coc-diagnostic-prev)', {noremap=false})
u.nmap('<leader>dn', '<Plug>(coc-diagnostic-next)', {noremap=false})
-- symbol search across file and workspace
u.nmap('<leader>k', ':<C-u>CocList outline<cr>', {noremap=false})
u.nmap('<leader>K', ':<C-u>CocList -I symbols<cr>', {noremap=false})

-- Ack remaps
u.nmap('<leader>f', ':Ack!<space>', {silent = false})

-- Fugitive remaps
u.nmap('<leader>gs', ':G<cr>')
u.nmap('<leader>gd', ':Gdiff<cr>')
u.nmap('<leader>gb', ':Gblame<cr>')
-- Signify remaps
u.nmap('<leader>gk', ':SignifyHunkDiff<cr>')
u.nmap('<leader>gu', ':SignifyHunkUndo<cr>')
u.nmap('<leader>gz', ':SignifyFold<cr>')

-- FZF remaps
u.nmap('<leader>l', ':Buffers<CR>')
u.nmap('<leader>j', ':Files<CR>')
u.nmap('<leader>JJ', ':FilesAll<cr>')
u.nmap('<leader>Jh', ':Files ~<cr>')
u.nmap('<leader>Jd', ':Files ~/dotfiles<cr>')
