local u = require('utils')

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

-- "hunk" text objects provided by signify
u.omap('ah', '<Plug>(signify-motion-outer-pending)', {noremap=false})
u.xmap('ah', '<Plug>(signify-motion-outer-visual)', {noremap=false})
u.omap('ih', '<Plug>(signify-motion-inner-pending)', {noremap=false})
u.xmap('ih', '<Plug>(signify-motion-inner-visual)', {noremap=false})

-- Fixes php textobj for function
api.nvim_exec([[
function! FixPhpFunctionTxtObj()
  let b:textobj_function_select = function('textobj#function#java#select')

  if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= '|'
  else
    let b:undo_ftplugin = ''
  endif
  let b:undo_ftplugin .= 'unlet b:textobj_function_select'
endfunction

augroup text_obj_fixes
  autocmd!
  autocmd BufEnter *.php call FixPhpFunctionTxtObj()
augroup END
]], false)
