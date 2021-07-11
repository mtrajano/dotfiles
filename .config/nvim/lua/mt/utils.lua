local utils = {}

local cmd = vim.cmd
local api = vim.api

local function map(mode, lhs, rhs, opts, local_to_buf)
  -- flip unique to true if want to debug overlapping mappings
  local default_opts = {
    unique = false,
    noremap = true,
    silent = true,
    expr = false,
  }

  if opts then
    default_opts = vim.tbl_extend('force', default_opts, opts)
  end

  if local_to_buf then
    api.nvim_buf_set_keymap(0, mode, lhs, rhs, default_opts)
  else
    api.nvim_set_keymap(mode, lhs, rhs, default_opts)
  end
end

-- mapping functions
utils.nmap = function(lhs, rhs, override_opts) map('n', lhs, rhs, override_opts) end
utils.imap = function(lhs, rhs, override_opts) map('i', lhs, rhs, override_opts) end
utils.vmap = function(lhs, rhs, override_opts) map('v', lhs, rhs, override_opts) end
utils.xmap = function(lhs, rhs, override_opts) map('x', lhs, rhs, override_opts) end
utils.omap = function(lhs, rhs, override_opts) map('o', lhs, rhs, override_opts) end
utils.tmap = function(lhs, rhs, override_opts) map('t', lhs, rhs, override_opts) end
utils.cmap = function(lhs, rhs, override_opts) map('c', lhs, rhs, override_opts) end

utils.buf_nmap = function(lhs, rhs, override_opts) map('n', lhs, rhs, override_opts, true) end
utils.buf_imap = function(lhs, rhs, override_opts) map('i', lhs, rhs, override_opts, true) end
utils.buf_vmap = function(lhs, rhs, override_opts) map('v', lhs, rhs, override_opts, true) end
utils.buf_xmap = function(lhs, rhs, override_opts) map('x', lhs, rhs, override_opts, true) end
utils.buf_omap = function(lhs, rhs, override_opts) map('o', lhs, rhs, override_opts, true) end
utils.buf_tmap = function(lhs, rhs, override_opts) map('t', lhs, rhs, override_opts, true) end
utils.buf_cmap = function(lhs, rhs, override_opts) map('c', lhs, rhs, override_opts, true) end

utils.cnoreabbrev = function(abbrev, expanded)
  cmd('cnoreabbrev ' .. abbrev .. ' ' .. expanded)
end

-- translate vim keycodes into actual term keycodes
utils.t = function(keycode)
  return api.nvim_replace_termcodes(keycode, true, true, true)
end

utils.contains = function(table, needle)
  for _,value in ipairs(table) do
    if (value == needle) then
      return true
    end
  end

  return false
end

-- revert a table
utils.revert = function(table)
  local new_table = {}

  for i = #table, 1, -1 do
    local new_ix = #table - i + 1
    new_table[new_ix] = table[i]
  end

  return new_table
end

return utils
