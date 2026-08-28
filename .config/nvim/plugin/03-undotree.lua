-- Undotree visualizes the undo history and makes it easy to browse and switch between different undo branches.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('mbbill/undotree'), -- https://github.com/mbbill/undotree
})

vim.g.undotree_DiffpanelHeight = 20
vim.g.undotree_SplitWidth = 50
vim.g.undotree_WindowLayout = 4

local keymap = require('utils.keymap')
keymap('<leader>uf', function() vim.cmd('UndotreeFocus') end, { desc = '[F]ocus Undotree' })
keymap('<leader>uh', function() vim.cmd('UndotreeHide') end, { desc = '[H]ide Undotree' })
keymap(
  '<leader>up',
  function() vim.cmd('UndotreePersistUndo') end,
  { desc = 'Undotree [p]ersist undo' }
)
keymap('<leader>us', function() vim.cmd('UndotreeShow') end, { desc = '[S]how Undotree' })
keymap('<leader>uu', function() vim.cmd('UndotreeToggle') end, { desc = 'Toggle [U]ndotree' })
