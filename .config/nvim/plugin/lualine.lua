require'lualine'.setup {
  options = {
    theme = 'tokyonight',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {
      { 'filename', file_status = true, path = 1 },
      { 'vim.b.lsp_current_function' },
    },
    lualine_x = {},
    lualine_y = {
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_z = { 'location', 'progress' },
  },
  inactive_sections = {
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
  }
}
