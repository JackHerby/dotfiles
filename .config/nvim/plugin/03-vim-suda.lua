-- Suda is a plugin to read or write files with sudo command.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("lambdalisue/suda.vim"), -- https://github.com/lambdalisue/vim-suda
})
