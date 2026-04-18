-- A port of gruvbox community theme to lua with treesitter and semantic highlights support.

local github_url = require('utils.github_url')
vim.pack.add({
  github_url('ellisonleao/gruvbox.nvim'), -- https://github.com/ellisonleao/gruvbox.nvim
})

require('gruvbox').setup({
  contrast = 'hard',
})

vim.o.background = 'dark' -- or "light" for light mode
vim.cmd('colorscheme gruvbox')
