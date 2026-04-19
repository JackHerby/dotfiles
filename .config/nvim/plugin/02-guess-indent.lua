-- Blazing fast indentation style detection for Neovim written in Lua.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("NMAC427/guess-indent.nvim"), -- https://github.com/NMAC427/guess-indent.nvim
})

require("guess-indent").setup({})
