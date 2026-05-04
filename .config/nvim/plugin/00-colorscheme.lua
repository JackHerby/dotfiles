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
  vim.g.terminal_color_0 = "#45475a"
  vim.g.terminal_color_1 = "#f38ba8"
  vim.g.terminal_color_2 = "#a6e3a1"
  vim.g.terminal_color_3 = "#f9e2af"
  vim.g.terminal_color_4 = "#89b4fa"
  vim.g.terminal_color_5 = "#f5c2e7"
  vim.g.terminal_color_6 = "#94e2d5"
  vim.g.terminal_color_7 = "#a6adc8"
  vim.g.terminal_color_8 = "#585b70"
  vim.g.terminal_color_9 = "#f37799"
  vim.g.terminal_color_10 = "#89d88b"
  vim.g.terminal_color_11 = "#ebd391"
  vim.g.terminal_color_12 = "#74a8fc"
  vim.g.terminal_color_13 = "#f2aede"
  vim.g.terminal_color_14 = "#6bd7ca"
  vim.g.terminal_color_15 = "#bac2de"
end
