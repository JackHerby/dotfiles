-- Undotree visualizes the undo history and makes it easy to browse and switch between different undo branches.

local github_url = require('utils.github_url')
vim.pack.add({
  github_url('mbbill/undotree'), -- https://github.com/mbbill/undotree
})

local keymap = require('utils.keymap')
keymap('<leader>uu', vim.cmd.UndotreeToggle, { desc = 'toggle [U]ndotree' })

vim.g.undotree_WindowLayout = 4
vim.g.undotree_SplitWidth = 50
vim.g.undotree_DiffpanelHeight = 20
