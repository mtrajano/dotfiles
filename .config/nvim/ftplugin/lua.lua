vim.cmd [[ setl includeexpr=substitute(v:fname,'\\.','/','g') ]]
  
vim.keymap.set('n', '<leader>r', function() vim.cmd.luafile('%') end, {
  buffer = true,
  desc = "Run lua file",
})

require("nvim-surround").buffer_setup({
  delimiters = { 
    pairs = {
      ["F"] = {'function() ', ' end'}
    }
  }
})

-- P(require("nvim-surround.config").get_opts())
