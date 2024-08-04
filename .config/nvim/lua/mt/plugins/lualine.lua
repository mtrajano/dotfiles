-- returns filename as indicator
local function get_harpoon_indicator(harpoon_entry)
  return vim.fs.basename(harpoon_entry.value)
end

-- TODO: add line to say wether session is being recorded
require('lualine').setup({
  options = {
    theme = 'onedark',
    ignore_focus = {
      'dapui_scopes',
      'dapui_breakpoints',
      'dapui_stacks',
      'dapui_watches',
      'dap-repl',
      'dapui_console',
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = {
      { 'filename', file_status = true, path = 1 },
      { '%=' },
      {
        'harpoon2',
        indicators = {
          get_harpoon_indicator,
          get_harpoon_indicator,
          get_harpoon_indicator,
          get_harpoon_indicator,
        },
        _separator = ' ',
      },
    },
    lualine_x = {},
    lualine_y = {
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_z = { 'ObsessionStatus', 'location', 'progress' },
  },
  inactive_sections = {
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
  },
})
