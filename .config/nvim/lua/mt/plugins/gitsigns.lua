require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    local function map_feedkey_on_diff(key, command)
      map('n', key, function()
        if vim.wo.diff then
          return vim.api.nvim_feedkeys(key, 'n', false)
        else
          return vim.cmd.Gitsigns(command)
        end
      end, { desc = command })
    end

    -- Navigation
    map_feedkey_on_diff(']c', 'next_hunk')
    map_feedkey_on_diff('[c', 'prev_hunk')

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer, { desc = 'GitSigns stage_buffer' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'GitSigns undo_stage_hunk' })
    map('n', '<leader>hR', gs.reset_buffer, { desc = 'GitSigns reset_buffer' })
    map('n', '<leader>hp', gs.preview_hunk, { desc = 'GitSigns preview_hunk' })
    map('n', '<leader>hb', function()
      gs.blame_line { full = true }
    end)
    map('n', '<leader>hd', gs.diffthis, { desc = 'GitSigns diffthis' })
    map('n', '<leader>hD', function()
      gs.diffthis('~')
    end)
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'GitSigns toggle_current_line_blame' })
    map('n', '<leader>td', gs.toggle_deleted, { desc = 'GitSigns toggle_deleted' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
