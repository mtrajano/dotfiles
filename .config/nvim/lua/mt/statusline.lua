require'lualine'.setup {
  options = {
    theme = 'auto',
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
      { 'diagnostics', sources = { 'nvim_lsp', 'ale' } },
    },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
  }
}
