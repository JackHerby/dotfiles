-- This plugin adds indentation guides to Neovim.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("lukas-reineke/indent-blankline.nvim"), -- https://github.com/lukas-reineke/indent-blankline.nvim
})

require("ibl").setup({
  scope = {
    show_start = false,
  },
  whitespace = {
    highlight = { "Whitespace", "NonText" },
  },
})

-- Enable list mode to show white space characters.
vim.opt.list = true
vim.opt.listchars = {
  space = "·",
  tab = "󰌒 ",
  trail = "∘",
  extends = "",
  precedes = "",
  nbsp = "󱁐",
  eol = "󰘌",
}
