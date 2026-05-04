-- Catppuccin for Neovim

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  { src = githubUrl("catppuccin/nvim"), name = "catppuccin" }, -- https://github.com/catppuccin/nvim
})

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    fidget = true,
    harpoon = true,
    indent_blankline = {
      colored_indent_levels = true,
      enabled = true,
      scope_color = "maroon",
    },
    mason = true,
    which_key = true,
  },
  transparent_background = not vim.g.neovide,
})

vim.cmd("colorscheme catppuccin-nvim")
