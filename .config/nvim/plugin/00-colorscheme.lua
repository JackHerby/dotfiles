-- A port of gruvbox community theme to lua with treesitter and semantic highlights support.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("ellisonleao/gruvbox.nvim"), -- https://github.com/ellisonleao/gruvbox.nvim
})

require("gruvbox").setup({
  contrast = "hard",
  overrides = {
    DiagnosticUnderlineError = {
      sp = "#cc241d",
      undercurl = false,
      underline = true,
    },
    DiagnosticUnderlineWarn = {
      sp = "#d79921",
      undercurl = false,
      underline = true,
    },
    DiagnosticUnderlineInfo = {
      sp = "#458588",
      undercurl = false,
      underline = true,
    },
    DiagnosticUnderlineHint = {
      sp = "#98971a",
      undercurl = false,
      underline = true,
    },
  },
  transparent_mode = not vim.g.neovide,
})

vim.o.background = "dark" -- or "light" for light mode
vim.cmd("colorscheme gruvbox")
