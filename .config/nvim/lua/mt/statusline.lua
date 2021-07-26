local function file_percentage()
  local percentage = vim.fn.line('.') / vim.api.nvim_buf_line_count(0)
  return math.ceil(percentage * 100) .. '%%'
end

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
    lualine_z = { 'location', file_percentage },
  },
  inactive_sections = {
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
  }
}
