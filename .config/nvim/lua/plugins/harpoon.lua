return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  requires = { { 'nvim-lua/plenary.nvim' } },
  opts = {
    settings = { save_on_toggle = true },
  },
  keys = {
    {
      'gha',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon add',
    },
    {
      'ghl',
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
      end,
      desc = 'Harpoon list',
    },
    {
      '<M-j>',
      function()
        require('harpoon'):list():select(1)
      end,
    },
    {
      '<M-k>',
      function()
        require('harpoon'):list():select(2)
      end,
    },
    {
      '<M-l>',
      function()
        require('harpoon'):list():select(3)
      end,
    },
    {
      '<M-;>',
      function()
        require('harpoon'):list():select(4)
      end,
    },
  },
}
