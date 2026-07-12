-- Undotree visualizes the undo history and makes it easy to browse and switch between different undo branches.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('mbbill/undotree'), -- https://github.com/mbbill/undotree
})

vim.g.undotree_WindowLayout = 4
vim.g.undotree_SplitWidth = 50
vim.g.undotree_DiffpanelHeight = 20
