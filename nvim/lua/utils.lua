local utils = {}

local function merge_default_maps(override_opts)
  -- flip unique to true if want to debug overlapping mappings
  local opts = {unique = false, noremap = true, silent = true}
  if override_opts then opts = vim.tbl_extend('force', opts, override_opts) end

  return opts
end

local function map(mode, lhs, rhs, override_opts)
  opts = merge_default_maps(override_opts)

  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- mapping functions
utils.nmap = function(lhs, rhs, override_opts) map('n', lhs, rhs, override_opts) end
utils.imap = function(lhs, rhs, override_opts) map('i', lhs, rhs, override_opts) end
utils.vmap = function(lhs, rhs, override_opts) map('v', lhs, rhs, override_opts) end
utils.xmap = function(lhs, rhs, override_opts) map('x', lhs, rhs, override_opts) end
utils.omap = function(lhs, rhs, override_opts) map('o', lhs, rhs, override_opts) end
utils.tmap = function(lhs, rhs, override_opts) map('t', lhs, rhs, override_opts) end
utils.cmap = function(lhs, rhs, override_opts) map('c', lhs, rhs, override_opts) end

-- translate vim keycodes into actual term keycodes
utils.t = function(keycode)
  return vim.api.nvim_replace_termcodes(keycode, true, true, true)
end

utils.contains = function(table, needle)
  for i,value in ipairs(table) do
    if (value == needle) then
      return true
    end
  end

  return false
end

return utils
