-- A port of gruvbox community theme to lua with treesitter and semantic highlights support.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("ellisonleao/gruvbox.nvim"), -- https://github.com/ellisonleao/gruvbox.nvim
})

require("gruvbox").setup({
  contrast = "hard",
})

vim.o.background = "dark" -- or "light" for light mode
vim.cmd("colorscheme gruvbox")
