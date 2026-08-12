local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('nvim-lua/plenary.nvim'), -- https://github.com/nvim-lua/plenary.nvim
  githubUrl('Bilal2453/luvit-meta'), -- https://github.com/Bilal2453/luvit-meta
})
