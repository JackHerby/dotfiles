-- Fugitive is the premier Vim plugin for Git.
-- Or maybe it's the premier Git plugin for Vim? Either way, it's "so awesome, it should be illegal".
-- That's why it's called Fugitive.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('tpope/vim-fugitive'), -- https://github.com/tpope/vim-fugitive
})
