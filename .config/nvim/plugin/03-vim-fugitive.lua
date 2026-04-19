-- Fugitive is the premier Vim plugin for Git.
-- Or maybe it's the premier Git plugin for Vim? Either way, it's "so awesome, it should be illegal".
-- That's why it's called Fugitive.

local githubUrl = require('utils.github-url')
vim.pack.add({
  githubUrl('tpope/vim-fugitive'), -- https://github.com/tpope/vim-fugitive
})

local keymap = require('utils.keymap')
keymap('<leader>gg', function() vim.cmd('Git') end, { desc = '[g]it status' })
keymap('<leader>gt', function() vim.cmd('vertical Gdiffsplit!') end, { desc = '[t]hree-way diff view' })
keymap('<leader>gd', function() vim.cmd('Gdiffsplit') end, { desc = 'two-way [d]iff view' })
keymap('<leader>gD', function()
  local vert_gds = function(branch)
    if not branch or branch == '' then return end
    vim.cmd('vertical Gdiffsplit ' .. branch)
  end
  vim.ui.input({ prompt = 'Branch: ' }, vert_gds)
end, { desc = 'two-way [d]iff view (choose branch to diff againts)' })
keymap('<leader>gs', function() vim.cmd('Gwrite!') end, { desc = '[s]tage file' })
keymap('<leader>gb', function() vim.cmd('Git blame') end, { desc = 'git [b]lame' })
