local utils = require('mt.utils')


utils.nmap('[q', '<Plug>(qf_qf_previous)', {noremap = false})
utils.nmap(']q', '<Plug>(qf_qf_next)', {noremap = false})
utils.nmap('[l', '<Plug>(qf_loc_previous)', {noremap = false})
utils.nmap(']l', '<Plug>(qf_loc_next)', {noremap = false})

-- enable mappings to open files in different ways
vim.g.qf_mapping_ack_style = 1

local fn = vim.fn
local cmd = vim.cmd

local M = {}

local function find_next_diagnostic_ix(loclist)
  local cur_line = fn.line('.')

  for i,val in ipairs(loclist) do
    local line=val.lnum

    if cur_line < line then
      return i
    elseif cur_line == line then
      return i + 1
    end
  end
end

local function find_prev_diagnostic_ix(loclist)
  local cur_line = fn.line('.')

  for i,val in ipairs(loclist) do
    local line=val.lnum

    if cur_line <= line then
      return i - 1
    end
  end

  -- past last diagnostic
  return #loclist
end

-- TODO look into this not have to traverse the entire list every time (would
-- need an autocmd that updates the table)
M.get_next_diagnostic = function()
  local loclist = fn.getloclist(0)

  local nr = find_next_diagnostic_ix(loclist)

  if nr ~= nil then
    cmd('ll ' .. nr)
  end
end

-- TODO look into this not have to traverse the entire list every time (would
-- need an autocmd that updates the table)
M.get_prev_diagnostic = function()
  local loclist = fn.getloclist(0)

  local nr = find_prev_diagnostic_ix(loclist)

  if nr ~= 0 then
    cmd('ll ' .. nr)
  end
end

utils.nmap('[d', ':lua require("mt.quickfix").get_prev_diagnostic()<cr>')
utils.nmap(']d', ':lua require("mt.quickfix").get_next_diagnostic()<cr>')

return M
