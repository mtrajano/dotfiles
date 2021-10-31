local entry_display = require "telescope.pickers.entry_display"
local Path = require'plenary.path'

local M = {}

local function line_info_file_display(entry)
  local displayer = entry_display.create {
    separator = "▏",
    items = {
      -- TODO: look into these values
      { width = 8 },
      { remaining = true },
    },
  }

  local filename = Path:new(entry.filename):make_relative(vim.fn.getcwd())

  local line_info = { table.concat({ entry.lnum, entry.col }, ":"), "TelescopeResultsLineNr" }

  return displayer {
    line_info,
    filename,
  }
end

M.file_with_linenumbers = function(entry)
  local filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr)

  return {
    valid = true,

    value = entry,
    ordinal = filename,
    display = line_info_file_display,

    bufnr = entry.bufnr,
    filename = filename,
    lnum = entry.lnum,
    col = entry.col,
    text = entry.text,
    start = entry.start,
    finish = entry.finish,
  }
end

return M
