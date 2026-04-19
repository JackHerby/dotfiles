-- Blazing fast indentation style detection for Neovim written in Lua.

local githubUrl = require("utils.github-url")
vim.pack.add({
  githubUrl("NMAC427/guess-indent.nvim"), -- https://github.com/NMAC427/guess-indent.nvim
})

require("guess-indent").setup({})
