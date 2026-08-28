local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('Bilal2453/luvit-meta'), -- https://github.com/Bilal2453/luvit-meta
  githubUrl('nvim-lua/plenary.nvim'), -- https://github.com/nvim-lua/plenary.nvim
  githubUrl('nvim-tree/nvim-web-devicons'), -- https://github.com/nvim-tree/nvim-web-devicons
})
