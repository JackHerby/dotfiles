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

-- Set terminal color scheme for Neovide.
if vim.g.neovide then
  vim.g.terminal_color_0 = "#11111b"
  vim.g.terminal_color_1 = "#f38ba8"
  vim.g.terminal_color_2 = "#a6e3a1"
  vim.g.terminal_color_3 = "#f9e2af"
  vim.g.terminal_color_4 = "#89b4fa"
  vim.g.terminal_color_5 = "#cba6f7"
  vim.g.terminal_color_6 = "#94e2d5"
  vim.g.terminal_color_7 = "#cdd6f4"

  vim.g.terminal_color_8 = "#313244"
  vim.g.terminal_color_9 = "#f38ba8"
  vim.g.terminal_color_10 = "#a6e3a1"
  vim.g.terminal_color_11 = "#f9e2af"
  vim.g.terminal_color_12 = "#89b4fa"
  vim.g.terminal_color_13 = "#cba6f7"
  vim.g.terminal_color_14 = "#94e2d5"
  vim.g.terminal_color_15 = "#bac2de"
end
