-- Catppuccin for Neovim

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  {
    src = githubUrl('catppuccin/nvim'), --https://github.com/catppuccin/nvim
    name = 'catppuccin',
  },
})

require('catppuccin').setup({
  flavour = 'mocha',
  transparent_background = true,
})

vim.cmd.colorscheme('catppuccin-nvim')
