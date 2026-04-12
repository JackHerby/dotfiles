-- https://github.com/tpope/vim-fugitive

---@module 'lazy'
---@type LazySpec
return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  config = function()
    local keymap = require('utils.keymap')
    keymap('<leader>gg', function() vim.cmd('Git') end, { desc = '[G]it status' })
    keymap('<leader>gt', function() vim.cmd('vertical Gdiffsplit!') end, { desc = '[T]hree-way diff view' })
    keymap('<leader>gd', function() vim.cmd('Gdiffsplit') end, { desc = 'Two-way [d]iff view' })

    local diff_branch = function()
      local vert_gds = function(branch)
        if not branch or branch == '' then return end
        vim.cmd('vertical Gdiffsplit ' .. branch)
      end
      vim.ui.input({ prompt = 'Branch: ' }, vert_gds)
    end
    keymap('<leader>gD', diff_branch, { desc = 'Two-way [d]iff view (choose branch to diff againts)' })
    keymap('<leader>gs', function() vim.cmd('Gwrite!') end, { desc = '[S]tage file' })
    keymap('<leader>gb', function() vim.cmd('Git blame') end, { desc = 'Git [b]lame' })
  end,
}
