local u = require('mt.utils')

local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

-- Text object remaps
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
-- function and object text objects provided by CoC
u.omap('aC', '<Plug>(coc-classobj-a)', {noremap=false}) -- ac is taken by comment obj
u.xmap('aC', '<Plug>(coc-classobj-a)', {noremap=false}) -- ac is taken by comment obj
u.omap('Af', '<Plug>(coc-funcobj-a)', {noremap=false}) -- af is taken by comment obj, this wraps comment as well
u.xmap('Af', '<Plug>(coc-funcobj-a)ok', {noremap=false}) -- af is taken by comment obj, this wraps comment as well
u.omap('iC', '<Plug>(coc-classobj-i)', {noremap=false}) -- ic is taken by comment obj
u.xmap('iC', '<Plug>(coc-classobj-i)', {noremap=false}) -- ic is taken by comment obj
u.omap('If', '<Plug>(coc-funcobj-i)', {noremap=false}) -- if is taken by comment  obj, this is broken due to phpls returning comment as range as well
u.xmap('If', '<Plug>(coc-funcobj-i)', {noremap=false}) -- if is taken by comment  obj, this is broken due to phpls returning comment as range as well
